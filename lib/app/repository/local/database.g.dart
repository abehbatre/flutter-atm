// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final String username;
  final double balance;
  final DateTime createAt;
  User({required this.username, required this.balance, required this.createAt});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      balance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}balance'])!,
      createAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['username'] = Variable<String>(username);
    map['balance'] = Variable<double>(balance);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      username: Value(username),
      balance: Value(balance),
      createAt: Value(createAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      username: serializer.fromJson<String>(json['username']),
      balance: serializer.fromJson<double>(json['balance']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'username': serializer.toJson<String>(username),
      'balance': serializer.toJson<double>(balance),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  User copyWith({String? username, double? balance, DateTime? createAt}) =>
      User(
        username: username ?? this.username,
        balance: balance ?? this.balance,
        createAt: createAt ?? this.createAt,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('username: $username, ')
          ..write('balance: $balance, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(username, balance, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.username == this.username &&
          other.balance == this.balance &&
          other.createAt == this.createAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> username;
  final Value<double> balance;
  final Value<DateTime> createAt;
  const UsersCompanion({
    this.username = const Value.absent(),
    this.balance = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  UsersCompanion.insert({
    required String username,
    required double balance,
    required DateTime createAt,
  })  : username = Value(username),
        balance = Value(balance),
        createAt = Value(createAt);
  static Insertable<User> custom({
    Expression<String>? username,
    Expression<double>? balance,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (username != null) 'username': username,
      if (balance != null) 'balance': balance,
      if (createAt != null) 'create_at': createAt,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? username,
      Value<double>? balance,
      Value<DateTime>? createAt}) {
    return UsersCompanion(
      username: username ?? this.username,
      balance: balance ?? this.balance,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('username: $username, ')
          ..write('balance: $balance, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  late final GeneratedColumn<double?> balance = GeneratedColumn<double?>(
      'balance', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _createAtMeta = const VerificationMeta('createAt');
  late final GeneratedColumn<DateTime?> createAt = GeneratedColumn<DateTime?>(
      'create_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [username, balance, createAt];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    } else if (isInserting) {
      context.missing(_createAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {username};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class TransactionLog extends DataClass implements Insertable<TransactionLog> {
  final int id;
  final String from;
  final String to;
  final double amount;
  final String description;
  final DateTime createAt;
  TransactionLog(
      {required this.id,
      required this.from,
      required this.to,
      required this.amount,
      required this.description,
      required this.createAt});
  factory TransactionLog.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TransactionLog(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      from: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}from'])!,
      to: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}to'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      createAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}create_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from'] = Variable<String>(from);
    map['to'] = Variable<String>(to);
    map['amount'] = Variable<double>(amount);
    map['description'] = Variable<String>(description);
    map['create_at'] = Variable<DateTime>(createAt);
    return map;
  }

  TransactionLogsCompanion toCompanion(bool nullToAbsent) {
    return TransactionLogsCompanion(
      id: Value(id),
      from: Value(from),
      to: Value(to),
      amount: Value(amount),
      description: Value(description),
      createAt: Value(createAt),
    );
  }

  factory TransactionLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionLog(
      id: serializer.fromJson<int>(json['id']),
      from: serializer.fromJson<String>(json['from']),
      to: serializer.fromJson<String>(json['to']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String>(json['description']),
      createAt: serializer.fromJson<DateTime>(json['createAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'from': serializer.toJson<String>(from),
      'to': serializer.toJson<String>(to),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String>(description),
      'createAt': serializer.toJson<DateTime>(createAt),
    };
  }

  TransactionLog copyWith(
          {int? id,
          String? from,
          String? to,
          double? amount,
          String? description,
          DateTime? createAt}) =>
      TransactionLog(
        id: id ?? this.id,
        from: from ?? this.from,
        to: to ?? this.to,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        createAt: createAt ?? this.createAt,
      );
  @override
  String toString() {
    return (StringBuffer('TransactionLog(')
          ..write('id: $id, ')
          ..write('from: $from, ')
          ..write('to: $to, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, from, to, amount, description, createAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionLog &&
          other.id == this.id &&
          other.from == this.from &&
          other.to == this.to &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.createAt == this.createAt);
}

class TransactionLogsCompanion extends UpdateCompanion<TransactionLog> {
  final Value<int> id;
  final Value<String> from;
  final Value<String> to;
  final Value<double> amount;
  final Value<String> description;
  final Value<DateTime> createAt;
  const TransactionLogsCompanion({
    this.id = const Value.absent(),
    this.from = const Value.absent(),
    this.to = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.createAt = const Value.absent(),
  });
  TransactionLogsCompanion.insert({
    this.id = const Value.absent(),
    required String from,
    required String to,
    required double amount,
    required String description,
    required DateTime createAt,
  })  : from = Value(from),
        to = Value(to),
        amount = Value(amount),
        description = Value(description),
        createAt = Value(createAt);
  static Insertable<TransactionLog> custom({
    Expression<int>? id,
    Expression<String>? from,
    Expression<String>? to,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<DateTime>? createAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (createAt != null) 'create_at': createAt,
    });
  }

  TransactionLogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? from,
      Value<String>? to,
      Value<double>? amount,
      Value<String>? description,
      Value<DateTime>? createAt}) {
    return TransactionLogsCompanion(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createAt: createAt ?? this.createAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (from.present) {
      map['from'] = Variable<String>(from.value);
    }
    if (to.present) {
      map['to'] = Variable<String>(to.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<DateTime>(createAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionLogsCompanion(')
          ..write('id: $id, ')
          ..write('from: $from, ')
          ..write('to: $to, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('createAt: $createAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionLogsTable extends TransactionLogs
    with TableInfo<$TransactionLogsTable, TransactionLog> {
  final GeneratedDatabase _db;
  final String? _alias;
  $TransactionLogsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _fromMeta = const VerificationMeta('from');
  late final GeneratedColumn<String?> from = GeneratedColumn<String?>(
      'from', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _toMeta = const VerificationMeta('to');
  late final GeneratedColumn<String?> to = GeneratedColumn<String?>(
      'to', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      typeName: 'REAL', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _createAtMeta = const VerificationMeta('createAt');
  late final GeneratedColumn<DateTime?> createAt = GeneratedColumn<DateTime?>(
      'create_at', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, from, to, amount, description, createAt];
  @override
  String get aliasedName => _alias ?? 'transaction_logs';
  @override
  String get actualTableName => 'transaction_logs';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from')) {
      context.handle(
          _fromMeta, from.isAcceptableOrUnknown(data['from']!, _fromMeta));
    } else if (isInserting) {
      context.missing(_fromMeta);
    }
    if (data.containsKey('to')) {
      context.handle(_toMeta, to.isAcceptableOrUnknown(data['to']!, _toMeta));
    } else if (isInserting) {
      context.missing(_toMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    } else if (isInserting) {
      context.missing(_createAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TransactionLog.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TransactionLogsTable createAlias(String alias) {
    return $TransactionLogsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $TransactionLogsTable transactionLogs =
      $TransactionLogsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, transactionLogs];
}
