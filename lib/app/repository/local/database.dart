import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ex_reusable/ex_reusable.dart';
import 'package:get/get.dart' hide Value;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

part 'database.g.dart';

/**
 * Documentation : https://drift.simonbinder.eu/docs/getting-started/
 * —————————————————————————————————————————————————————————————————————————————
 * CODE GENERATOR
 * —————————————————————————————————————————————————————————————————————————————
 * > flutter packages pub run build_runner build
 * > dart run drift_dev analyze
 * —————————————————————————————————————————————————————————————————————————————
 * */

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

  // —————————————————————————————————————————————————————————————————————————
  // Table TransactionLogs
  // —————————————————————————————————————————————————————————————————————————
  Future<int> createTransactionLog(TransactionLogsCompanion entry) => into(transactionLogs).insert(entry);
  Future<int> createOrUpdateTransactionLog(TransactionLog entry) => into(transactionLogs).insertOnConflictUpdate(entry);
  Future<List<TransactionLog>> getListTransactionLogByUsername(String username) => (select(transactionLogs)..where((t) => t.from.equals(username))).get();
  Stream<TransactionLog> getTransactionLogById(int id) => (select(transactionLogs)..where((t) => t.id.equals(id))).watchSingle();
  Future<int> deleteTransactionLog(TransactionLog entry) => delete(transactionLogs).delete(entry);
  Future<int> deleteAllTransactionLog() async => delete<Table, dynamic>(transactionLogs).go();


  // —————————————————————————————————————————————————————————————————————————
  // action
  // —————————————————————————————————————————————————————————————————————————

  /**
   * deposit
   *
   * @param {User} user
   * @param {number} amount
   * @returns {Future}
   **/

  Future deposit(User user, double amount) async {
    return transaction(() async {
      try {
        // update current user balance
        await customUpdate(
          'UPDATE users SET balance = ? WHERE username = ?',
          updates: {users},
          variables: [
            Variable.withReal((user.balance + amount)),
            Variable.withString(user.username),
          ],
        );

        // insert to transactionLog
        var log = TransactionLog(
          id: randomBetween(100, 123456789),
          from: user.username,
          to: user.username,
          amount: amount,
          description: 'deposit',
          createAt: DateTime.now(),
        );
        await createOrUpdateTransactionLog(log);
      } catch (e) {
        Get.snackbar('ERROR', '$e');
        logE("deposit : $e");
      }
    });
  }

  /**
   * withdraw
   *
   * @param {User} user
   * @param {number} amount
   * @returns {Future}
   **/

  Future withdraw(User user, double amount) async {
    return transaction(() async {
      try {
        // validasi
        if (user.balance - amount < 0) {
          Get.snackbar('Gagal', 'Saldo anda tidak cukup');
          return;
        }

        // update current user balance
        await customUpdate(
          'UPDATE users SET balance = ? WHERE username = ?',
          updates: {users},
          variables: [
            Variable.withReal((user.balance - amount)),
            Variable.withString(user.username),
          ],
        );

        // insert to transactionLog
        var log = TransactionLog(
          id: randomBetween(100, 123456789),
          from: user.username,
          to: user.username,
          amount: amount,
          description: 'deposit',
          createAt: DateTime.now(),
        );
        await createOrUpdateTransactionLog(log);
      } catch (e) {
        Get.snackbar('ERROR', '$e');
        logE("withdraw : $e");
      }
    });
  }

  /**
   * transfer
   *
   * @param {User} userOwner
   * @param {User} userTarget
   * @param {number} amount
   * @returns {Future}
   **/

  Future transfer(User userOwner, User userTarget, double amount) async {
    return transaction(() async {
      try {
        // validasi
        if (userOwner.balance - amount < 0) {
          Get.snackbar('Gagal', 'Saldo anda tidak cukup');
          return;
        }

        // update current user balance ----
        await customUpdate(
          'UPDATE users SET balance = ? WHERE username = ?',
          updates: {users},
          variables: [Variable.withReal((userOwner.balance - amount)), Variable.withString(userOwner.username)],
        );

        // update target user balance ++++
        await customUpdate(
          'UPDATE users SET balance = ? WHERE username = ?',
          updates: {users},
          variables: [Variable.withReal((userTarget.balance + amount)), Variable.withString(userTarget.username)],
        );

        // insert to transactionLog
        var log = TransactionLog(
          id: randomBetween(100, 123456789),
          from: userOwner.username,
          to: userTarget.username,
          amount: amount,
          description: 'transfer',
          createAt: DateTime.now(),
        );
        await createOrUpdateTransactionLog(log);
      } catch (e) {
        Get.snackbar('ERROR', '$e');
        logE("transfer : $e");
      }
    });
  }
}
