// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, only_throw_errors

import 'dart:io';
import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ex_reusable/ex_reusable.dart';
import 'package:get/get.dart' hide Value;
import 'package:mock_data/mock_data.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

import '../../common/exception/exception.dart';
import '../../common/resource/_index.dart';

part 'database.g.dart';

/// Documentation : https://drift.simonbinder.eu/docs/getting-started/
/// —————————————————————————————————————————————————————————————————————————————
/// CODE GENERATOR
/// —————————————————————————————————————————————————————————————————————————————
/// > flutter packages pub run build_runner build
/// > dart run drift_dev analyze
/// —————————————————————————————————————————————————————————————————————————————
/// */

// —————————————————————————————————————————————————————————————————————————
// MODEL TABLE CLASS
// —————————————————————————————————————————————————————————————————————————
class Users extends Table {
  TextColumn get username => text().withLength(min: 6, max: 32)();
  RealColumn get balance => real()();
  DateTimeColumn get createAt => dateTime()();

  @override
  Set<Column>? get primaryKey => {username};
}

class TransactionLogs extends Table {
  IntColumn get id => integer().autoIncrement()(); // pk
  TextColumn get username => text().withLength(min: 6, max: 32)();
  TextColumn get from => text()();
  TextColumn get to => text()();
  RealColumn get amount => real()();
  TextColumn get description => text()();
  DateTimeColumn get createAt => dateTime()();
}

// —————————————————————————————————————————————————————————————————————————
// DATABASE
// —————————————————————————————————————————————————————————————————————————

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'atm.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Users, TransactionLogs])
class MyDatabase extends _$MyDatabase {
  // MyDatabase() : super(_openConnection());
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // —————————————————————————————————————————————————————————————————————————————
  // Table Users
  // —————————————————————————————————————————————————————————————————————————————
  Future<int> createUser(UsersCompanion entry) => into(users).insert(entry);
  Future<int> createOrUpdateUser(User entry) => into(users).insertOnConflictUpdate(entry);
  Future<List<User>> get getListUser => select(users).get();
  Stream<User> getUserByUsername(String username) => (select(users)..where((t) => t.username.equals(username))).watchSingle();
  Future<int> deleteUser(User entry) => delete(users).delete(entry);
  Future<int> deleteAllUser() async => delete<Table, dynamic>(users).go();

  Stream<QueryRow> countUsers() {
    return customSelect('SELECT COUNT(*) FROM users',
      readsFrom: {users},
    ).watchSingle();
  }

  // —————————————————————————————————————————————————————————————————————————
  // Table TransactionLogs
  // —————————————————————————————————————————————————————————————————————————
  Future<int> createTransactionLog(TransactionLogsCompanion entry) => into(transactionLogs).insert(entry);
  Future<int> createOrUpdateTransactionLog(TransactionLog entry) => into(transactionLogs).insertOnConflictUpdate(entry);
  Future<List<TransactionLog>> getListTransactionLogByUsername(String username) {
    return (select(transactionLogs)
          ..where((t) => t.username.equals(username))
          ..orderBy([(t) => OrderingTerm.desc(t.createAt)]))
        .get();
  }

  Stream<TransactionLog> getTransactionLogById(int id) => (select(transactionLogs)..where((t) => t.id.equals(id))).watchSingle();
  Future<int> deleteTransactionLog(TransactionLog entry) => delete(transactionLogs).delete(entry);
  Future<int> deleteAllTransactionLog() async => delete<Table, dynamic>(transactionLogs).go();

  // —————————————————————————————————————————————————————————————————————————
  // action
  // —————————————————————————————————————————————————————————————————————————

  /// deposit
  ///
  /// @param {User} user
  /// @param {number} amount
  /// @returns {Future}
  ///*/

  Future deposit(User user, double amount) async {
    return transaction(() async {
      try {
        // update current user balance
        await (update(users)..where((tbl) => tbl.username.equals(user.username))).write(UsersCompanion(
          balance: Value(user.balance + amount),
        ));

        // insert to transactionLog
        final log = TransactionLog(
          id: randomBetween(100, 123456789),
          username: user.username,
          from: user.username,
          to: user.username,
          amount: amount,
          description: 'deposit',
          createAt: DateTime.now(),
        );
        await createOrUpdateTransactionLog(log);
        Get.snackbar(
          'Sukses',
          'berhasil deposit sebesar ${rupiahFormat(amount)}',
          backgroundColor: const Color(0x8A2E7D32),
          barBlur: 8.0,
          colorText: colorWhite,
        );
        logW('deposit : [$user, $amount]');
      } catch (e) {
        if (e is LocalException) {
          Get.snackbar('ERROR', e.message);
        } else {
          Get.snackbar('ERROR', '$e');
          logE('deposit : $e');
        }
      }
    });
  }

  /// withdraw
  ///
  /// @param {User} user
  /// @param {number} amount
  /// @returns {Future}
  ///*/

  Future withdraw(User user, double amount) async {
    return transaction(() async {
      try {
        // validasi
        if (user.balance - amount < 0) {
          throw const LocalException(message: 'Saldo anda tidak cukup');
        }

        // update current user balance
        await customUpdate(
          'UPDATE users SET balance = ? WHERE username = ?',
          updates: {users},
          variables: [
            Variable.withReal(user.balance - amount),
            Variable.withString(user.username),
          ],
        );

        // insert to transactionLog
        final log = TransactionLog(
          id: randomBetween(100, 123456789),
          username: user.username,
          from: user.username,
          to: user.username,
          amount: amount,
          description: 'withdraw',
          createAt: DateTime.now(),
        );
        await createOrUpdateTransactionLog(log);
        Get.snackbar(
          'Sukses',
          'berhasil withdraw sebesar ${rupiahFormat(amount)}',
          backgroundColor: const Color(0x8A2E7D32),
          barBlur: 8.0,
          colorText: colorWhite,
        );
      } catch (e) {
        if (e is LocalException) {
          Get.snackbar('ERROR', e.message);
        } else {
          Get.snackbar('ERROR', '$e');
          logE('withdraw : $e');
        }
      }
    });
  }

  /// transfer
  ///
  /// @param {User} userOwner
  /// @param {User} userTarget
  /// @param {number} amount
  /// @returns {Future}
  ///*/

  Future transfer(User userOwner, User userTarget, double amount) async {
    return transaction(() async {
      try {
        // validasi
        if (userOwner.balance - amount < 0) {
          throw LocalException(message: 'Saldo anda tidak cukup');
        }

        // update current user balance ----
        await customUpdate(
          'UPDATE users SET balance = ? WHERE username = ?',
          updates: {users},
          variables: [Variable.withReal(userOwner.balance - amount), Variable.withString(userOwner.username)],
        );

        // update target user balance ++++
        await customUpdate(
          'UPDATE users SET balance = ? WHERE username = ?',
          updates: {users},
          variables: [Variable.withReal(userTarget.balance + amount), Variable.withString(userTarget.username)],
        );

        // insert to transactionLog <current user>
        final log = TransactionLog(
          id: randomBetween(100, 123456789),
          username: userOwner.username,
          from: userOwner.username,
          to: userTarget.username,
          amount: amount,
          description: 'transfer',
          createAt: DateTime.now(),
        );
        await createOrUpdateTransactionLog(log);

        // insert to transactionLog <target user>
        final log2 = TransactionLog(
          id: randomBetween(100, 123456789),
          username: userTarget.username,
          from: userOwner.username,
          to: userTarget.username,
          amount: amount,
          description: 'transfer',
          createAt: DateTime.now(),
        );
        await createOrUpdateTransactionLog(log2);

        Get.snackbar(
          'Sukses',
          'berhasil transfer ke ${userTarget.username} sebesar ${rupiahFormat(amount)}',
          backgroundColor: const Color(0x8A2E7D32),
          barBlur: 8.0,
          colorText: colorWhite,
        );
      } catch (e) {
        if (e is LocalException) {
          Get.snackbar('ERROR', e.message);
        } else {
          Get.snackbar('ERROR', '$e');
          logE('transfer : $e');
        }
      }
    });
  }

  Future<void> populateUser() async {
    // Step :
    // - only run this process when data = 0
    // - populate data

    try {
      int? totalData = 0;
      countUsers.call().listen((event) async {
        totalData = event.data.values.toList()[0] as int;
        // only run this process when data < 1
        if (totalData! < 1) { // populate data
          await batch((batch) {
            for (int i = 0; i < 4; i++) {
              batch.insertAll(users, [
                UsersCompanion.insert(username: '${mockName().toLowerCase()}${randomBetween(100, 1000)}', balance: 0, createAt: DateTime.now()),
              ]);
            }
          });
        }

      });




    } catch (e) {
      logW('populateUser : $e');
    }
  }
}
