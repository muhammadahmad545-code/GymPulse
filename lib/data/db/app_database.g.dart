// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OrganizationsTable extends Organizations
    with TableInfo<$OrganizationsTable, Organization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrganizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    countryCode,
    defaultCurrency,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'organizations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Organization> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Organization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Organization(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OrganizationsTable createAlias(String alias) {
    return $OrganizationsTable(attachedDatabase, alias);
  }
}

class Organization extends DataClass implements Insertable<Organization> {
  final String id;
  final String name;
  final String countryCode;
  final String defaultCurrency;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Organization({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.defaultCurrency,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['country_code'] = Variable<String>(countryCode);
    map['default_currency'] = Variable<String>(defaultCurrency);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OrganizationsCompanion toCompanion(bool nullToAbsent) {
    return OrganizationsCompanion(
      id: Value(id),
      name: Value(name),
      countryCode: Value(countryCode),
      defaultCurrency: Value(defaultCurrency),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Organization.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Organization(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'countryCode': serializer.toJson<String>(countryCode),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Organization copyWith({
    String? id,
    String? name,
    String? countryCode,
    String? defaultCurrency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Organization(
    id: id ?? this.id,
    name: name ?? this.name,
    countryCode: countryCode ?? this.countryCode,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Organization copyWithCompanion(OrganizationsCompanion data) {
    return Organization(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Organization(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryCode: $countryCode, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, countryCode, defaultCurrency, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Organization &&
          other.id == this.id &&
          other.name == this.name &&
          other.countryCode == this.countryCode &&
          other.defaultCurrency == this.defaultCurrency &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OrganizationsCompanion extends UpdateCompanion<Organization> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> countryCode;
  final Value<String> defaultCurrency;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const OrganizationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrganizationsCompanion.insert({
    required String id,
    required String name,
    this.countryCode = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Organization> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? countryCode,
    Expression<String>? defaultCurrency,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (countryCode != null) 'country_code': countryCode,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrganizationsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? countryCode,
    Value<String>? defaultCurrency,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return OrganizationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryCode: $countryCode, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('UTC'),
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _addressJsonMeta = const VerificationMeta(
    'addressJson',
  );
  @override
  late final GeneratedColumn<String> addressJson = GeneratedColumn<String>(
    'address_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capacityMeta = const VerificationMeta(
    'capacity',
  );
  @override
  late final GeneratedColumn<int> capacity = GeneratedColumn<int>(
    'capacity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    name,
    timezone,
    countryCode,
    currencyCode,
    addressJson,
    capacity,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Location> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('address_json')) {
      context.handle(
        _addressJsonMeta,
        addressJson.isAcceptableOrUnknown(
          data['address_json']!,
          _addressJsonMeta,
        ),
      );
    }
    if (data.containsKey('capacity')) {
      context.handle(
        _capacityMeta,
        capacity.isAcceptableOrUnknown(data['capacity']!, _capacityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      )!,
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      addressJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_json'],
      ),
      capacity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capacity'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final String id;
  final String organizationId;
  final String name;
  final String timezone;
  final String countryCode;
  final String currencyCode;
  final String? addressJson;
  final int? capacity;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Location({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.timezone,
    required this.countryCode,
    required this.currencyCode,
    this.addressJson,
    this.capacity,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['name'] = Variable<String>(name);
    map['timezone'] = Variable<String>(timezone);
    map['country_code'] = Variable<String>(countryCode);
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || addressJson != null) {
      map['address_json'] = Variable<String>(addressJson);
    }
    if (!nullToAbsent || capacity != null) {
      map['capacity'] = Variable<int>(capacity);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      name: Value(name),
      timezone: Value(timezone),
      countryCode: Value(countryCode),
      currencyCode: Value(currencyCode),
      addressJson: addressJson == null && nullToAbsent
          ? const Value.absent()
          : Value(addressJson),
      capacity: capacity == null && nullToAbsent
          ? const Value.absent()
          : Value(capacity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Location.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      name: serializer.fromJson<String>(json['name']),
      timezone: serializer.fromJson<String>(json['timezone']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      addressJson: serializer.fromJson<String?>(json['addressJson']),
      capacity: serializer.fromJson<int?>(json['capacity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'name': serializer.toJson<String>(name),
      'timezone': serializer.toJson<String>(timezone),
      'countryCode': serializer.toJson<String>(countryCode),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'addressJson': serializer.toJson<String?>(addressJson),
      'capacity': serializer.toJson<int?>(capacity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Location copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? timezone,
    String? countryCode,
    String? currencyCode,
    Value<String?> addressJson = const Value.absent(),
    Value<int?> capacity = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Location(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    name: name ?? this.name,
    timezone: timezone ?? this.timezone,
    countryCode: countryCode ?? this.countryCode,
    currencyCode: currencyCode ?? this.currencyCode,
    addressJson: addressJson.present ? addressJson.value : this.addressJson,
    capacity: capacity.present ? capacity.value : this.capacity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      name: data.name.present ? data.name.value : this.name,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      addressJson: data.addressJson.present
          ? data.addressJson.value
          : this.addressJson,
      capacity: data.capacity.present ? data.capacity.value : this.capacity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('name: $name, ')
          ..write('timezone: $timezone, ')
          ..write('countryCode: $countryCode, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('addressJson: $addressJson, ')
          ..write('capacity: $capacity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    name,
    timezone,
    countryCode,
    currencyCode,
    addressJson,
    capacity,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.name == this.name &&
          other.timezone == this.timezone &&
          other.countryCode == this.countryCode &&
          other.currencyCode == this.currencyCode &&
          other.addressJson == this.addressJson &&
          other.capacity == this.capacity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> name;
  final Value<String> timezone;
  final Value<String> countryCode;
  final Value<String> currencyCode;
  final Value<String?> addressJson;
  final Value<int?> capacity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.name = const Value.absent(),
    this.timezone = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.addressJson = const Value.absent(),
    this.capacity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required String id,
    required String organizationId,
    required String name,
    this.timezone = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.addressJson = const Value.absent(),
    this.capacity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Location> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? name,
    Expression<String>? timezone,
    Expression<String>? countryCode,
    Expression<String>? currencyCode,
    Expression<String>? addressJson,
    Expression<int>? capacity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (name != null) 'name': name,
      if (timezone != null) 'timezone': timezone,
      if (countryCode != null) 'country_code': countryCode,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (addressJson != null) 'address_json': addressJson,
      if (capacity != null) 'capacity': capacity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? name,
    Value<String>? timezone,
    Value<String>? countryCode,
    Value<String>? currencyCode,
    Value<String?>? addressJson,
    Value<int?>? capacity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocationsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      timezone: timezone ?? this.timezone,
      countryCode: countryCode ?? this.countryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      addressJson: addressJson ?? this.addressJson,
      capacity: capacity ?? this.capacity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (addressJson.present) {
      map['address_json'] = Variable<String>(addressJson.value);
    }
    if (capacity.present) {
      map['capacity'] = Variable<int>(capacity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('name: $name, ')
          ..write('timezone: $timezone, ')
          ..write('countryCode: $countryCode, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('addressJson: $addressJson, ')
          ..write('capacity: $capacity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleDefaultMeta = const VerificationMeta(
    'roleDefault',
  );
  @override
  late final GeneratedColumn<String> roleDefault = GeneratedColumn<String>(
    'role_default',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    roleDefault,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('role_default')) {
      context.handle(
        _roleDefaultMeta,
        roleDefault.isAcceptableOrUnknown(
          data['role_default']!,
          _roleDefaultMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      roleDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_default'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final String id;
  final String displayName;
  final String? roleDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalUser({
    required this.id,
    required this.displayName,
    this.roleDefault,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || roleDefault != null) {
      map['role_default'] = Variable<String>(roleDefault);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      id: Value(id),
      displayName: Value(displayName),
      roleDefault: roleDefault == null && nullToAbsent
          ? const Value.absent()
          : Value(roleDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      roleDefault: serializer.fromJson<String?>(json['roleDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'roleDefault': serializer.toJson<String?>(roleDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalUser copyWith({
    String? id,
    String? displayName,
    Value<String?> roleDefault = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalUser(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    roleDefault: roleDefault.present ? roleDefault.value : this.roleDefault,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      roleDefault: data.roleDefault.present
          ? data.roleDefault.value
          : this.roleDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('roleDefault: $roleDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, displayName, roleDefault, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.roleDefault == this.roleDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<String?> roleDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalUsersCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.roleDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String id,
    required String displayName,
    this.roleDefault = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalUser> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? roleDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (roleDefault != null) 'role_default': roleDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUsersCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<String?>? roleDefault,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalUsersCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      roleDefault: roleDefault ?? this.roleDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (roleDefault.present) {
      map['role_default'] = Variable<String>(roleDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('roleDefault: $roleDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrganizationMembersTable extends OrganizationMembers
    with TableInfo<$OrganizationMembersTable, OrganizationMember> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrganizationMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    organizationId,
    userId,
    role,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'organization_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrganizationMember> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {organizationId, userId};
  @override
  OrganizationMember map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrganizationMember(
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OrganizationMembersTable createAlias(String alias) {
    return $OrganizationMembersTable(attachedDatabase, alias);
  }
}

class OrganizationMember extends DataClass
    implements Insertable<OrganizationMember> {
  final String organizationId;
  final String userId;
  final String role;
  final String status;
  final DateTime createdAt;
  const OrganizationMember({
    required this.organizationId,
    required this.userId,
    required this.role,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['organization_id'] = Variable<String>(organizationId);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OrganizationMembersCompanion toCompanion(bool nullToAbsent) {
    return OrganizationMembersCompanion(
      organizationId: Value(organizationId),
      userId: Value(userId),
      role: Value(role),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory OrganizationMember.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrganizationMember(
      organizationId: serializer.fromJson<String>(json['organizationId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'organizationId': serializer.toJson<String>(organizationId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OrganizationMember copyWith({
    String? organizationId,
    String? userId,
    String? role,
    String? status,
    DateTime? createdAt,
  }) => OrganizationMember(
    organizationId: organizationId ?? this.organizationId,
    userId: userId ?? this.userId,
    role: role ?? this.role,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  OrganizationMember copyWithCompanion(OrganizationMembersCompanion data) {
    return OrganizationMember(
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationMember(')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(organizationId, userId, role, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrganizationMember &&
          other.organizationId == this.organizationId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class OrganizationMembersCompanion extends UpdateCompanion<OrganizationMember> {
  final Value<String> organizationId;
  final Value<String> userId;
  final Value<String> role;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const OrganizationMembersCompanion({
    this.organizationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrganizationMembersCompanion.insert({
    required String organizationId,
    required String userId,
    required String role,
    this.status = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : organizationId = Value(organizationId),
       userId = Value(userId),
       role = Value(role),
       createdAt = Value(createdAt);
  static Insertable<OrganizationMember> custom({
    Expression<String>? organizationId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (organizationId != null) 'organization_id': organizationId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrganizationMembersCompanion copyWith({
    Value<String>? organizationId,
    Value<String>? userId,
    Value<String>? role,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return OrganizationMembersCompanion(
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationMembersCompanion(')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationAccessTable extends LocationAccess
    with TableInfo<$LocationAccessTable, LocationAccessData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationAccessTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    organizationId,
    locationId,
    userId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_access';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationAccessData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {organizationId, locationId, userId};
  @override
  LocationAccessData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationAccessData(
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocationAccessTable createAlias(String alias) {
    return $LocationAccessTable(attachedDatabase, alias);
  }
}

class LocationAccessData extends DataClass
    implements Insertable<LocationAccessData> {
  final String organizationId;
  final String locationId;
  final String userId;
  final DateTime createdAt;
  const LocationAccessData({
    required this.organizationId,
    required this.locationId,
    required this.userId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['user_id'] = Variable<String>(userId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocationAccessCompanion toCompanion(bool nullToAbsent) {
    return LocationAccessCompanion(
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      userId: Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory LocationAccessData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationAccessData(
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      userId: serializer.fromJson<String>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'userId': serializer.toJson<String>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocationAccessData copyWith({
    String? organizationId,
    String? locationId,
    String? userId,
    DateTime? createdAt,
  }) => LocationAccessData(
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
  );
  LocationAccessData copyWithCompanion(LocationAccessCompanion data) {
    return LocationAccessData(
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationAccessData(')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(organizationId, locationId, userId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationAccessData &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class LocationAccessCompanion extends UpdateCompanion<LocationAccessData> {
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> userId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocationAccessCompanion({
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationAccessCompanion.insert({
    required String organizationId,
    required String locationId,
    required String userId,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : organizationId = Value(organizationId),
       locationId = Value(locationId),
       userId = Value(userId),
       createdAt = Value(createdAt);
  static Insertable<LocationAccessData> custom({
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationAccessCompanion copyWith({
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? userId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocationAccessCompanion(
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationAccessCompanion(')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalMemberIdMeta = const VerificationMeta(
    'externalMemberId',
  );
  @override
  late final GeneratedColumn<String> externalMemberId = GeneratedColumn<String>(
    'external_member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    externalMemberId,
    firstName,
    lastName,
    phone,
    email,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('external_member_id')) {
      context.handle(
        _externalMemberIdMeta,
        externalMemberId.isAcceptableOrUnknown(
          data['external_member_id']!,
          _externalMemberIdMeta,
        ),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      externalMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_member_id'],
      ),
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class Member extends DataClass implements Insertable<Member> {
  final String id;
  final String organizationId;
  final String locationId;
  final String? externalMemberId;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? email;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Member({
    required this.id,
    required this.organizationId,
    required this.locationId,
    this.externalMemberId,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.email,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    if (!nullToAbsent || externalMemberId != null) {
      map['external_member_id'] = Variable<String>(externalMemberId);
    }
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      externalMemberId: externalMemberId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalMemberId),
      firstName: Value(firstName),
      lastName: Value(lastName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      externalMemberId: serializer.fromJson<String?>(json['externalMemberId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'externalMemberId': serializer.toJson<String?>(externalMemberId),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Member copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    Value<String?> externalMemberId = const Value.absent(),
    String? firstName,
    String? lastName,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Member(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    externalMemberId: externalMemberId.present
        ? externalMemberId.value
        : this.externalMemberId,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      externalMemberId: data.externalMemberId.present
          ? data.externalMemberId.value
          : this.externalMemberId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('externalMemberId: $externalMemberId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    externalMemberId,
    firstName,
    lastName,
    phone,
    email,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.externalMemberId == this.externalMemberId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String?> externalMemberId;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.externalMemberId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    this.externalMemberId = const Value.absent(),
    required String firstName,
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       firstName = Value(firstName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Member> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? externalMemberId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (externalMemberId != null) 'external_member_id': externalMemberId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String?>? externalMemberId,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      externalMemberId: externalMemberId ?? this.externalMemberId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (externalMemberId.present) {
      map['external_member_id'] = Variable<String>(externalMemberId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('externalMemberId: $externalMemberId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembershipPlansTable extends MembershipPlans
    with TableInfo<$MembershipPlansTable, MembershipPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembershipPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationDaysMeta = const VerificationMeta(
    'durationDays',
  );
  @override
  late final GeneratedColumn<int> durationDays = GeneratedColumn<int>(
    'duration_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceAmountMeta = const VerificationMeta(
    'priceAmount',
  );
  @override
  late final GeneratedColumn<double> priceAmount = GeneratedColumn<double>(
    'price_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    name,
    durationDays,
    priceAmount,
    currencyCode,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'membership_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<MembershipPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('duration_days')) {
      context.handle(
        _durationDaysMeta,
        durationDays.isAcceptableOrUnknown(
          data['duration_days']!,
          _durationDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationDaysMeta);
    }
    if (data.containsKey('price_amount')) {
      context.handle(
        _priceAmountMeta,
        priceAmount.isAcceptableOrUnknown(
          data['price_amount']!,
          _priceAmountMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MembershipPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MembershipPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      durationDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_days'],
      )!,
      priceAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_amount'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $MembershipPlansTable createAlias(String alias) {
    return $MembershipPlansTable(attachedDatabase, alias);
  }
}

class MembershipPlan extends DataClass implements Insertable<MembershipPlan> {
  final String id;
  final String organizationId;
  final String? locationId;
  final String name;
  final int durationDays;
  final double priceAmount;
  final String currencyCode;
  final bool active;
  const MembershipPlan({
    required this.id,
    required this.organizationId,
    this.locationId,
    required this.name,
    required this.durationDays,
    required this.priceAmount,
    required this.currencyCode,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<String>(locationId);
    }
    map['name'] = Variable<String>(name);
    map['duration_days'] = Variable<int>(durationDays);
    map['price_amount'] = Variable<double>(priceAmount);
    map['currency_code'] = Variable<String>(currencyCode);
    map['active'] = Variable<bool>(active);
    return map;
  }

  MembershipPlansCompanion toCompanion(bool nullToAbsent) {
    return MembershipPlansCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
      name: Value(name),
      durationDays: Value(durationDays),
      priceAmount: Value(priceAmount),
      currencyCode: Value(currencyCode),
      active: Value(active),
    );
  }

  factory MembershipPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MembershipPlan(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String?>(json['locationId']),
      name: serializer.fromJson<String>(json['name']),
      durationDays: serializer.fromJson<int>(json['durationDays']),
      priceAmount: serializer.fromJson<double>(json['priceAmount']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String?>(locationId),
      'name': serializer.toJson<String>(name),
      'durationDays': serializer.toJson<int>(durationDays),
      'priceAmount': serializer.toJson<double>(priceAmount),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'active': serializer.toJson<bool>(active),
    };
  }

  MembershipPlan copyWith({
    String? id,
    String? organizationId,
    Value<String?> locationId = const Value.absent(),
    String? name,
    int? durationDays,
    double? priceAmount,
    String? currencyCode,
    bool? active,
  }) => MembershipPlan(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId.present ? locationId.value : this.locationId,
    name: name ?? this.name,
    durationDays: durationDays ?? this.durationDays,
    priceAmount: priceAmount ?? this.priceAmount,
    currencyCode: currencyCode ?? this.currencyCode,
    active: active ?? this.active,
  );
  MembershipPlan copyWithCompanion(MembershipPlansCompanion data) {
    return MembershipPlan(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      name: data.name.present ? data.name.value : this.name,
      durationDays: data.durationDays.present
          ? data.durationDays.value
          : this.durationDays,
      priceAmount: data.priceAmount.present
          ? data.priceAmount.value
          : this.priceAmount,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MembershipPlan(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('name: $name, ')
          ..write('durationDays: $durationDays, ')
          ..write('priceAmount: $priceAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    name,
    durationDays,
    priceAmount,
    currencyCode,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MembershipPlan &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.name == this.name &&
          other.durationDays == this.durationDays &&
          other.priceAmount == this.priceAmount &&
          other.currencyCode == this.currencyCode &&
          other.active == this.active);
}

class MembershipPlansCompanion extends UpdateCompanion<MembershipPlan> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String?> locationId;
  final Value<String> name;
  final Value<int> durationDays;
  final Value<double> priceAmount;
  final Value<String> currencyCode;
  final Value<bool> active;
  final Value<int> rowid;
  const MembershipPlansCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.name = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.priceAmount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembershipPlansCompanion.insert({
    required String id,
    required String organizationId,
    this.locationId = const Value.absent(),
    required String name,
    required int durationDays,
    this.priceAmount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       name = Value(name),
       durationDays = Value(durationDays);
  static Insertable<MembershipPlan> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? name,
    Expression<int>? durationDays,
    Expression<double>? priceAmount,
    Expression<String>? currencyCode,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (name != null) 'name': name,
      if (durationDays != null) 'duration_days': durationDays,
      if (priceAmount != null) 'price_amount': priceAmount,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembershipPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String?>? locationId,
    Value<String>? name,
    Value<int>? durationDays,
    Value<double>? priceAmount,
    Value<String>? currencyCode,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return MembershipPlansCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      name: name ?? this.name,
      durationDays: durationDays ?? this.durationDays,
      priceAmount: priceAmount ?? this.priceAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (durationDays.present) {
      map['duration_days'] = Variable<int>(durationDays.value);
    }
    if (priceAmount.present) {
      map['price_amount'] = Variable<double>(priceAmount.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembershipPlansCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('name: $name, ')
          ..write('durationDays: $durationDays, ')
          ..write('priceAmount: $priceAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembershipsTable extends Memberships
    with TableInfo<$MembershipsTable, Membership> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembershipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  @override
  late final GeneratedColumn<DateTime> endAt = GeneratedColumn<DateTime>(
    'end_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceAmountMeta = const VerificationMeta(
    'priceAmount',
  );
  @override
  late final GeneratedColumn<double> priceAmount = GeneratedColumn<double>(
    'price_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    memberId,
    planId,
    startAt,
    endAt,
    status,
    priceAmount,
    currencyCode,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memberships';
  @override
  VerificationContext validateIntegrity(
    Insertable<Membership> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('price_amount')) {
      context.handle(
        _priceAmountMeta,
        priceAmount.isAcceptableOrUnknown(
          data['price_amount']!,
          _priceAmountMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Membership map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Membership(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      ),
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priceAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_amount'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MembershipsTable createAlias(String alias) {
    return $MembershipsTable(attachedDatabase, alias);
  }
}

class Membership extends DataClass implements Insertable<Membership> {
  final String id;
  final String organizationId;
  final String locationId;
  final String memberId;
  final String? planId;
  final DateTime startAt;
  final DateTime endAt;
  final String status;
  final double? priceAmount;
  final String? currencyCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Membership({
    required this.id,
    required this.organizationId,
    required this.locationId,
    required this.memberId,
    this.planId,
    required this.startAt,
    required this.endAt,
    required this.status,
    this.priceAmount,
    this.currencyCode,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['member_id'] = Variable<String>(memberId);
    if (!nullToAbsent || planId != null) {
      map['plan_id'] = Variable<String>(planId);
    }
    map['start_at'] = Variable<DateTime>(startAt);
    map['end_at'] = Variable<DateTime>(endAt);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || priceAmount != null) {
      map['price_amount'] = Variable<double>(priceAmount);
    }
    if (!nullToAbsent || currencyCode != null) {
      map['currency_code'] = Variable<String>(currencyCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MembershipsCompanion toCompanion(bool nullToAbsent) {
    return MembershipsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      memberId: Value(memberId),
      planId: planId == null && nullToAbsent
          ? const Value.absent()
          : Value(planId),
      startAt: Value(startAt),
      endAt: Value(endAt),
      status: Value(status),
      priceAmount: priceAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(priceAmount),
      currencyCode: currencyCode == null && nullToAbsent
          ? const Value.absent()
          : Value(currencyCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Membership.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Membership(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      planId: serializer.fromJson<String?>(json['planId']),
      startAt: serializer.fromJson<DateTime>(json['startAt']),
      endAt: serializer.fromJson<DateTime>(json['endAt']),
      status: serializer.fromJson<String>(json['status']),
      priceAmount: serializer.fromJson<double?>(json['priceAmount']),
      currencyCode: serializer.fromJson<String?>(json['currencyCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'memberId': serializer.toJson<String>(memberId),
      'planId': serializer.toJson<String?>(planId),
      'startAt': serializer.toJson<DateTime>(startAt),
      'endAt': serializer.toJson<DateTime>(endAt),
      'status': serializer.toJson<String>(status),
      'priceAmount': serializer.toJson<double?>(priceAmount),
      'currencyCode': serializer.toJson<String?>(currencyCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Membership copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    String? memberId,
    Value<String?> planId = const Value.absent(),
    DateTime? startAt,
    DateTime? endAt,
    String? status,
    Value<double?> priceAmount = const Value.absent(),
    Value<String?> currencyCode = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Membership(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    memberId: memberId ?? this.memberId,
    planId: planId.present ? planId.value : this.planId,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    status: status ?? this.status,
    priceAmount: priceAmount.present ? priceAmount.value : this.priceAmount,
    currencyCode: currencyCode.present ? currencyCode.value : this.currencyCode,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Membership copyWithCompanion(MembershipsCompanion data) {
    return Membership(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      planId: data.planId.present ? data.planId.value : this.planId,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      status: data.status.present ? data.status.value : this.status,
      priceAmount: data.priceAmount.present
          ? data.priceAmount.value
          : this.priceAmount,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Membership(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('planId: $planId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('status: $status, ')
          ..write('priceAmount: $priceAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    memberId,
    planId,
    startAt,
    endAt,
    status,
    priceAmount,
    currencyCode,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Membership &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.memberId == this.memberId &&
          other.planId == this.planId &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.status == this.status &&
          other.priceAmount == this.priceAmount &&
          other.currencyCode == this.currencyCode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MembershipsCompanion extends UpdateCompanion<Membership> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> memberId;
  final Value<String?> planId;
  final Value<DateTime> startAt;
  final Value<DateTime> endAt;
  final Value<String> status;
  final Value<double?> priceAmount;
  final Value<String?> currencyCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MembershipsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.planId = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.status = const Value.absent(),
    this.priceAmount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembershipsCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    required String memberId,
    this.planId = const Value.absent(),
    required DateTime startAt,
    required DateTime endAt,
    required String status,
    this.priceAmount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       memberId = Value(memberId),
       startAt = Value(startAt),
       endAt = Value(endAt),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Membership> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? memberId,
    Expression<String>? planId,
    Expression<DateTime>? startAt,
    Expression<DateTime>? endAt,
    Expression<String>? status,
    Expression<double>? priceAmount,
    Expression<String>? currencyCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (memberId != null) 'member_id': memberId,
      if (planId != null) 'plan_id': planId,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (status != null) 'status': status,
      if (priceAmount != null) 'price_amount': priceAmount,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembershipsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? memberId,
    Value<String?>? planId,
    Value<DateTime>? startAt,
    Value<DateTime>? endAt,
    Value<String>? status,
    Value<double?>? priceAmount,
    Value<String?>? currencyCode,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MembershipsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      memberId: memberId ?? this.memberId,
      planId: planId ?? this.planId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      status: status ?? this.status,
      priceAmount: priceAmount ?? this.priceAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<DateTime>(endAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priceAmount.present) {
      map['price_amount'] = Variable<double>(priceAmount.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembershipsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('planId: $planId, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('status: $status, ')
          ..write('priceAmount: $priceAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceSourcesTable extends AttendanceSources
    with TableInfo<$AttendanceSourcesTable, AttendanceSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vendorMeta = const VerificationMeta('vendor');
  @override
  late final GeneratedColumn<String> vendor = GeneratedColumn<String>(
    'vendor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalSourceIdMeta = const VerificationMeta(
    'externalSourceId',
  );
  @override
  late final GeneratedColumn<String> externalSourceId = GeneratedColumn<String>(
    'external_source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ready'),
  );
  static const VerificationMeta _lastSuccessAtMeta = const VerificationMeta(
    'lastSuccessAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>(
        'last_success_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    type,
    vendor,
    externalSourceId,
    status,
    lastSuccessAt,
    lastAttemptAt,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('vendor')) {
      context.handle(
        _vendorMeta,
        vendor.isAcceptableOrUnknown(data['vendor']!, _vendorMeta),
      );
    }
    if (data.containsKey('external_source_id')) {
      context.handle(
        _externalSourceIdMeta,
        externalSourceId.isAcceptableOrUnknown(
          data['external_source_id']!,
          _externalSourceIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
        _lastSuccessAtMeta,
        lastSuccessAt.isAcceptableOrUnknown(
          data['last_success_at']!,
          _lastSuccessAtMeta,
        ),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      vendor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor'],
      ),
      externalSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_source_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastSuccessAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_success_at'],
      ),
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
    );
  }

  @override
  $AttendanceSourcesTable createAlias(String alias) {
    return $AttendanceSourcesTable(attachedDatabase, alias);
  }
}

class AttendanceSource extends DataClass
    implements Insertable<AttendanceSource> {
  final String id;
  final String organizationId;
  final String locationId;
  final String type;
  final String? vendor;
  final String? externalSourceId;
  final String status;
  final DateTime? lastSuccessAt;
  final DateTime? lastAttemptAt;
  final String? metadataJson;
  const AttendanceSource({
    required this.id,
    required this.organizationId,
    required this.locationId,
    required this.type,
    this.vendor,
    this.externalSourceId,
    required this.status,
    this.lastSuccessAt,
    this.lastAttemptAt,
    this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || vendor != null) {
      map['vendor'] = Variable<String>(vendor);
    }
    if (!nullToAbsent || externalSourceId != null) {
      map['external_source_id'] = Variable<String>(externalSourceId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    return map;
  }

  AttendanceSourcesCompanion toCompanion(bool nullToAbsent) {
    return AttendanceSourcesCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      type: Value(type),
      vendor: vendor == null && nullToAbsent
          ? const Value.absent()
          : Value(vendor),
      externalSourceId: externalSourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalSourceId),
      status: Value(status),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
    );
  }

  factory AttendanceSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceSource(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      type: serializer.fromJson<String>(json['type']),
      vendor: serializer.fromJson<String?>(json['vendor']),
      externalSourceId: serializer.fromJson<String?>(json['externalSourceId']),
      status: serializer.fromJson<String>(json['status']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'type': serializer.toJson<String>(type),
      'vendor': serializer.toJson<String?>(vendor),
      'externalSourceId': serializer.toJson<String?>(externalSourceId),
      'status': serializer.toJson<String>(status),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'metadataJson': serializer.toJson<String?>(metadataJson),
    };
  }

  AttendanceSource copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    String? type,
    Value<String?> vendor = const Value.absent(),
    Value<String?> externalSourceId = const Value.absent(),
    String? status,
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<String?> metadataJson = const Value.absent(),
  }) => AttendanceSource(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    type: type ?? this.type,
    vendor: vendor.present ? vendor.value : this.vendor,
    externalSourceId: externalSourceId.present
        ? externalSourceId.value
        : this.externalSourceId,
    status: status ?? this.status,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
  );
  AttendanceSource copyWithCompanion(AttendanceSourcesCompanion data) {
    return AttendanceSource(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      type: data.type.present ? data.type.value : this.type,
      vendor: data.vendor.present ? data.vendor.value : this.vendor,
      externalSourceId: data.externalSourceId.present
          ? data.externalSourceId.value
          : this.externalSourceId,
      status: data.status.present ? data.status.value : this.status,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceSource(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('type: $type, ')
          ..write('vendor: $vendor, ')
          ..write('externalSourceId: $externalSourceId, ')
          ..write('status: $status, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    type,
    vendor,
    externalSourceId,
    status,
    lastSuccessAt,
    lastAttemptAt,
    metadataJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceSource &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.type == this.type &&
          other.vendor == this.vendor &&
          other.externalSourceId == this.externalSourceId &&
          other.status == this.status &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.metadataJson == this.metadataJson);
}

class AttendanceSourcesCompanion extends UpdateCompanion<AttendanceSource> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> type;
  final Value<String?> vendor;
  final Value<String?> externalSourceId;
  final Value<String> status;
  final Value<DateTime?> lastSuccessAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<String?> metadataJson;
  final Value<int> rowid;
  const AttendanceSourcesCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.type = const Value.absent(),
    this.vendor = const Value.absent(),
    this.externalSourceId = const Value.absent(),
    this.status = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceSourcesCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    required String type,
    this.vendor = const Value.absent(),
    this.externalSourceId = const Value.absent(),
    this.status = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       type = Value(type);
  static Insertable<AttendanceSource> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? type,
    Expression<String>? vendor,
    Expression<String>? externalSourceId,
    Expression<String>? status,
    Expression<DateTime>? lastSuccessAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (type != null) 'type': type,
      if (vendor != null) 'vendor': vendor,
      if (externalSourceId != null) 'external_source_id': externalSourceId,
      if (status != null) 'status': status,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceSourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? type,
    Value<String?>? vendor,
    Value<String?>? externalSourceId,
    Value<String>? status,
    Value<DateTime?>? lastSuccessAt,
    Value<DateTime?>? lastAttemptAt,
    Value<String?>? metadataJson,
    Value<int>? rowid,
  }) {
    return AttendanceSourcesCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      type: type ?? this.type,
      vendor: vendor ?? this.vendor,
      externalSourceId: externalSourceId ?? this.externalSourceId,
      status: status ?? this.status,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (vendor.present) {
      map['vendor'] = Variable<String>(vendor.value);
    }
    if (externalSourceId.present) {
      map['external_source_id'] = Variable<String>(externalSourceId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceSourcesCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('type: $type, ')
          ..write('vendor: $vendor, ')
          ..write('externalSourceId: $externalSourceId, ')
          ..write('status: $status, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceEventsTable extends AttendanceEvents
    with TableInfo<$AttendanceEventsTable, AttendanceEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalMemberIdMeta = const VerificationMeta(
    'externalMemberId',
  );
  @override
  late final GeneratedColumn<String> externalMemberId = GeneratedColumn<String>(
    'external_member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtUtcMeta = const VerificationMeta(
    'occurredAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAtUtc =
      GeneratedColumn<DateTime>(
        'occurred_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _occurredAtLocalMeta = const VerificationMeta(
    'occurredAtLocal',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAtLocal =
      GeneratedColumn<DateTime>(
        'occurred_at_local',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalEventIdMeta = const VerificationMeta(
    'externalEventId',
  );
  @override
  late final GeneratedColumn<String> externalEventId = GeneratedColumn<String>(
    'external_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawPayloadJsonMeta = const VerificationMeta(
    'rawPayloadJson',
  );
  @override
  late final GeneratedColumn<String> rawPayloadJson = GeneratedColumn<String>(
    'raw_payload_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingestedAtMeta = const VerificationMeta(
    'ingestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> ingestedAt = GeneratedColumn<DateTime>(
    'ingested_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _matchStatusMeta = const VerificationMeta(
    'matchStatus',
  );
  @override
  late final GeneratedColumn<String> matchStatus = GeneratedColumn<String>(
    'match_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unmatched'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    memberId,
    externalMemberId,
    sourceId,
    occurredAtUtc,
    occurredAtLocal,
    eventType,
    externalEventId,
    rawPayloadJson,
    ingestedAt,
    matchStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('external_member_id')) {
      context.handle(
        _externalMemberIdMeta,
        externalMemberId.isAcceptableOrUnknown(
          data['external_member_id']!,
          _externalMemberIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_externalMemberIdMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('occurred_at_utc')) {
      context.handle(
        _occurredAtUtcMeta,
        occurredAtUtc.isAcceptableOrUnknown(
          data['occurred_at_utc']!,
          _occurredAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_occurredAtUtcMeta);
    }
    if (data.containsKey('occurred_at_local')) {
      context.handle(
        _occurredAtLocalMeta,
        occurredAtLocal.isAcceptableOrUnknown(
          data['occurred_at_local']!,
          _occurredAtLocalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_occurredAtLocalMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('external_event_id')) {
      context.handle(
        _externalEventIdMeta,
        externalEventId.isAcceptableOrUnknown(
          data['external_event_id']!,
          _externalEventIdMeta,
        ),
      );
    }
    if (data.containsKey('raw_payload_json')) {
      context.handle(
        _rawPayloadJsonMeta,
        rawPayloadJson.isAcceptableOrUnknown(
          data['raw_payload_json']!,
          _rawPayloadJsonMeta,
        ),
      );
    }
    if (data.containsKey('ingested_at')) {
      context.handle(
        _ingestedAtMeta,
        ingestedAt.isAcceptableOrUnknown(data['ingested_at']!, _ingestedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_ingestedAtMeta);
    }
    if (data.containsKey('match_status')) {
      context.handle(
        _matchStatusMeta,
        matchStatus.isAcceptableOrUnknown(
          data['match_status']!,
          _matchStatusMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      ),
      externalMemberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_member_id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      occurredAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at_utc'],
      )!,
      occurredAtLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at_local'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      externalEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_event_id'],
      ),
      rawPayloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_payload_json'],
      ),
      ingestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ingested_at'],
      )!,
      matchStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_status'],
      )!,
    );
  }

  @override
  $AttendanceEventsTable createAlias(String alias) {
    return $AttendanceEventsTable(attachedDatabase, alias);
  }
}

class AttendanceEvent extends DataClass implements Insertable<AttendanceEvent> {
  final String id;
  final String organizationId;
  final String locationId;
  final String? memberId;
  final String externalMemberId;
  final String sourceId;
  final DateTime occurredAtUtc;
  final DateTime occurredAtLocal;
  final String eventType;
  final String? externalEventId;
  final String? rawPayloadJson;
  final DateTime ingestedAt;
  final String matchStatus;
  const AttendanceEvent({
    required this.id,
    required this.organizationId,
    required this.locationId,
    this.memberId,
    required this.externalMemberId,
    required this.sourceId,
    required this.occurredAtUtc,
    required this.occurredAtLocal,
    required this.eventType,
    this.externalEventId,
    this.rawPayloadJson,
    required this.ingestedAt,
    required this.matchStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    if (!nullToAbsent || memberId != null) {
      map['member_id'] = Variable<String>(memberId);
    }
    map['external_member_id'] = Variable<String>(externalMemberId);
    map['source_id'] = Variable<String>(sourceId);
    map['occurred_at_utc'] = Variable<DateTime>(occurredAtUtc);
    map['occurred_at_local'] = Variable<DateTime>(occurredAtLocal);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || externalEventId != null) {
      map['external_event_id'] = Variable<String>(externalEventId);
    }
    if (!nullToAbsent || rawPayloadJson != null) {
      map['raw_payload_json'] = Variable<String>(rawPayloadJson);
    }
    map['ingested_at'] = Variable<DateTime>(ingestedAt);
    map['match_status'] = Variable<String>(matchStatus);
    return map;
  }

  AttendanceEventsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceEventsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      memberId: memberId == null && nullToAbsent
          ? const Value.absent()
          : Value(memberId),
      externalMemberId: Value(externalMemberId),
      sourceId: Value(sourceId),
      occurredAtUtc: Value(occurredAtUtc),
      occurredAtLocal: Value(occurredAtLocal),
      eventType: Value(eventType),
      externalEventId: externalEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalEventId),
      rawPayloadJson: rawPayloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(rawPayloadJson),
      ingestedAt: Value(ingestedAt),
      matchStatus: Value(matchStatus),
    );
  }

  factory AttendanceEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceEvent(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      memberId: serializer.fromJson<String?>(json['memberId']),
      externalMemberId: serializer.fromJson<String>(json['externalMemberId']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      occurredAtUtc: serializer.fromJson<DateTime>(json['occurredAtUtc']),
      occurredAtLocal: serializer.fromJson<DateTime>(json['occurredAtLocal']),
      eventType: serializer.fromJson<String>(json['eventType']),
      externalEventId: serializer.fromJson<String?>(json['externalEventId']),
      rawPayloadJson: serializer.fromJson<String?>(json['rawPayloadJson']),
      ingestedAt: serializer.fromJson<DateTime>(json['ingestedAt']),
      matchStatus: serializer.fromJson<String>(json['matchStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'memberId': serializer.toJson<String?>(memberId),
      'externalMemberId': serializer.toJson<String>(externalMemberId),
      'sourceId': serializer.toJson<String>(sourceId),
      'occurredAtUtc': serializer.toJson<DateTime>(occurredAtUtc),
      'occurredAtLocal': serializer.toJson<DateTime>(occurredAtLocal),
      'eventType': serializer.toJson<String>(eventType),
      'externalEventId': serializer.toJson<String?>(externalEventId),
      'rawPayloadJson': serializer.toJson<String?>(rawPayloadJson),
      'ingestedAt': serializer.toJson<DateTime>(ingestedAt),
      'matchStatus': serializer.toJson<String>(matchStatus),
    };
  }

  AttendanceEvent copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    Value<String?> memberId = const Value.absent(),
    String? externalMemberId,
    String? sourceId,
    DateTime? occurredAtUtc,
    DateTime? occurredAtLocal,
    String? eventType,
    Value<String?> externalEventId = const Value.absent(),
    Value<String?> rawPayloadJson = const Value.absent(),
    DateTime? ingestedAt,
    String? matchStatus,
  }) => AttendanceEvent(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    memberId: memberId.present ? memberId.value : this.memberId,
    externalMemberId: externalMemberId ?? this.externalMemberId,
    sourceId: sourceId ?? this.sourceId,
    occurredAtUtc: occurredAtUtc ?? this.occurredAtUtc,
    occurredAtLocal: occurredAtLocal ?? this.occurredAtLocal,
    eventType: eventType ?? this.eventType,
    externalEventId: externalEventId.present
        ? externalEventId.value
        : this.externalEventId,
    rawPayloadJson: rawPayloadJson.present
        ? rawPayloadJson.value
        : this.rawPayloadJson,
    ingestedAt: ingestedAt ?? this.ingestedAt,
    matchStatus: matchStatus ?? this.matchStatus,
  );
  AttendanceEvent copyWithCompanion(AttendanceEventsCompanion data) {
    return AttendanceEvent(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      externalMemberId: data.externalMemberId.present
          ? data.externalMemberId.value
          : this.externalMemberId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      occurredAtUtc: data.occurredAtUtc.present
          ? data.occurredAtUtc.value
          : this.occurredAtUtc,
      occurredAtLocal: data.occurredAtLocal.present
          ? data.occurredAtLocal.value
          : this.occurredAtLocal,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      externalEventId: data.externalEventId.present
          ? data.externalEventId.value
          : this.externalEventId,
      rawPayloadJson: data.rawPayloadJson.present
          ? data.rawPayloadJson.value
          : this.rawPayloadJson,
      ingestedAt: data.ingestedAt.present
          ? data.ingestedAt.value
          : this.ingestedAt,
      matchStatus: data.matchStatus.present
          ? data.matchStatus.value
          : this.matchStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceEvent(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('externalMemberId: $externalMemberId, ')
          ..write('sourceId: $sourceId, ')
          ..write('occurredAtUtc: $occurredAtUtc, ')
          ..write('occurredAtLocal: $occurredAtLocal, ')
          ..write('eventType: $eventType, ')
          ..write('externalEventId: $externalEventId, ')
          ..write('rawPayloadJson: $rawPayloadJson, ')
          ..write('ingestedAt: $ingestedAt, ')
          ..write('matchStatus: $matchStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    memberId,
    externalMemberId,
    sourceId,
    occurredAtUtc,
    occurredAtLocal,
    eventType,
    externalEventId,
    rawPayloadJson,
    ingestedAt,
    matchStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceEvent &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.memberId == this.memberId &&
          other.externalMemberId == this.externalMemberId &&
          other.sourceId == this.sourceId &&
          other.occurredAtUtc == this.occurredAtUtc &&
          other.occurredAtLocal == this.occurredAtLocal &&
          other.eventType == this.eventType &&
          other.externalEventId == this.externalEventId &&
          other.rawPayloadJson == this.rawPayloadJson &&
          other.ingestedAt == this.ingestedAt &&
          other.matchStatus == this.matchStatus);
}

class AttendanceEventsCompanion extends UpdateCompanion<AttendanceEvent> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String?> memberId;
  final Value<String> externalMemberId;
  final Value<String> sourceId;
  final Value<DateTime> occurredAtUtc;
  final Value<DateTime> occurredAtLocal;
  final Value<String> eventType;
  final Value<String?> externalEventId;
  final Value<String?> rawPayloadJson;
  final Value<DateTime> ingestedAt;
  final Value<String> matchStatus;
  final Value<int> rowid;
  const AttendanceEventsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.externalMemberId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.occurredAtUtc = const Value.absent(),
    this.occurredAtLocal = const Value.absent(),
    this.eventType = const Value.absent(),
    this.externalEventId = const Value.absent(),
    this.rawPayloadJson = const Value.absent(),
    this.ingestedAt = const Value.absent(),
    this.matchStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceEventsCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    this.memberId = const Value.absent(),
    required String externalMemberId,
    required String sourceId,
    required DateTime occurredAtUtc,
    required DateTime occurredAtLocal,
    required String eventType,
    this.externalEventId = const Value.absent(),
    this.rawPayloadJson = const Value.absent(),
    required DateTime ingestedAt,
    this.matchStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       externalMemberId = Value(externalMemberId),
       sourceId = Value(sourceId),
       occurredAtUtc = Value(occurredAtUtc),
       occurredAtLocal = Value(occurredAtLocal),
       eventType = Value(eventType),
       ingestedAt = Value(ingestedAt);
  static Insertable<AttendanceEvent> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? memberId,
    Expression<String>? externalMemberId,
    Expression<String>? sourceId,
    Expression<DateTime>? occurredAtUtc,
    Expression<DateTime>? occurredAtLocal,
    Expression<String>? eventType,
    Expression<String>? externalEventId,
    Expression<String>? rawPayloadJson,
    Expression<DateTime>? ingestedAt,
    Expression<String>? matchStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (memberId != null) 'member_id': memberId,
      if (externalMemberId != null) 'external_member_id': externalMemberId,
      if (sourceId != null) 'source_id': sourceId,
      if (occurredAtUtc != null) 'occurred_at_utc': occurredAtUtc,
      if (occurredAtLocal != null) 'occurred_at_local': occurredAtLocal,
      if (eventType != null) 'event_type': eventType,
      if (externalEventId != null) 'external_event_id': externalEventId,
      if (rawPayloadJson != null) 'raw_payload_json': rawPayloadJson,
      if (ingestedAt != null) 'ingested_at': ingestedAt,
      if (matchStatus != null) 'match_status': matchStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String?>? memberId,
    Value<String>? externalMemberId,
    Value<String>? sourceId,
    Value<DateTime>? occurredAtUtc,
    Value<DateTime>? occurredAtLocal,
    Value<String>? eventType,
    Value<String?>? externalEventId,
    Value<String?>? rawPayloadJson,
    Value<DateTime>? ingestedAt,
    Value<String>? matchStatus,
    Value<int>? rowid,
  }) {
    return AttendanceEventsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      memberId: memberId ?? this.memberId,
      externalMemberId: externalMemberId ?? this.externalMemberId,
      sourceId: sourceId ?? this.sourceId,
      occurredAtUtc: occurredAtUtc ?? this.occurredAtUtc,
      occurredAtLocal: occurredAtLocal ?? this.occurredAtLocal,
      eventType: eventType ?? this.eventType,
      externalEventId: externalEventId ?? this.externalEventId,
      rawPayloadJson: rawPayloadJson ?? this.rawPayloadJson,
      ingestedAt: ingestedAt ?? this.ingestedAt,
      matchStatus: matchStatus ?? this.matchStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (externalMemberId.present) {
      map['external_member_id'] = Variable<String>(externalMemberId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (occurredAtUtc.present) {
      map['occurred_at_utc'] = Variable<DateTime>(occurredAtUtc.value);
    }
    if (occurredAtLocal.present) {
      map['occurred_at_local'] = Variable<DateTime>(occurredAtLocal.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (externalEventId.present) {
      map['external_event_id'] = Variable<String>(externalEventId.value);
    }
    if (rawPayloadJson.present) {
      map['raw_payload_json'] = Variable<String>(rawPayloadJson.value);
    }
    if (ingestedAt.present) {
      map['ingested_at'] = Variable<DateTime>(ingestedAt.value);
    }
    if (matchStatus.present) {
      map['match_status'] = Variable<String>(matchStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceEventsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('externalMemberId: $externalMemberId, ')
          ..write('sourceId: $sourceId, ')
          ..write('occurredAtUtc: $occurredAtUtc, ')
          ..write('occurredAtLocal: $occurredAtLocal, ')
          ..write('eventType: $eventType, ')
          ..write('externalEventId: $externalEventId, ')
          ..write('rawPayloadJson: $rawPayloadJson, ')
          ..write('ingestedAt: $ingestedAt, ')
          ..write('matchStatus: $matchStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrialsTable extends Trials with TableInfo<$TrialsTable, Trial> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
    'ends_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _convertedAtMeta = const VerificationMeta(
    'convertedAt',
  );
  @override
  late final GeneratedColumn<DateTime> convertedAt = GeneratedColumn<DateTime>(
    'converted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    memberId,
    startedAt,
    endsAt,
    convertedAt,
    status,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trials';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trial> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ends_at')) {
      context.handle(
        _endsAtMeta,
        endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endsAtMeta);
    }
    if (data.containsKey('converted_at')) {
      context.handle(
        _convertedAtMeta,
        convertedAt.isAcceptableOrUnknown(
          data['converted_at']!,
          _convertedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trial map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trial(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ends_at'],
      )!,
      convertedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}converted_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
    );
  }

  @override
  $TrialsTable createAlias(String alias) {
    return $TrialsTable(attachedDatabase, alias);
  }
}

class Trial extends DataClass implements Insertable<Trial> {
  final String id;
  final String organizationId;
  final String locationId;
  final String memberId;
  final DateTime startedAt;
  final DateTime endsAt;
  final DateTime? convertedAt;
  final String status;
  final String? source;
  const Trial({
    required this.id,
    required this.organizationId,
    required this.locationId,
    required this.memberId,
    required this.startedAt,
    required this.endsAt,
    this.convertedAt,
    required this.status,
    this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['member_id'] = Variable<String>(memberId);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ends_at'] = Variable<DateTime>(endsAt);
    if (!nullToAbsent || convertedAt != null) {
      map['converted_at'] = Variable<DateTime>(convertedAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    return map;
  }

  TrialsCompanion toCompanion(bool nullToAbsent) {
    return TrialsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      memberId: Value(memberId),
      startedAt: Value(startedAt),
      endsAt: Value(endsAt),
      convertedAt: convertedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(convertedAt),
      status: Value(status),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
    );
  }

  factory Trial.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trial(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endsAt: serializer.fromJson<DateTime>(json['endsAt']),
      convertedAt: serializer.fromJson<DateTime?>(json['convertedAt']),
      status: serializer.fromJson<String>(json['status']),
      source: serializer.fromJson<String?>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'memberId': serializer.toJson<String>(memberId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endsAt': serializer.toJson<DateTime>(endsAt),
      'convertedAt': serializer.toJson<DateTime?>(convertedAt),
      'status': serializer.toJson<String>(status),
      'source': serializer.toJson<String?>(source),
    };
  }

  Trial copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    String? memberId,
    DateTime? startedAt,
    DateTime? endsAt,
    Value<DateTime?> convertedAt = const Value.absent(),
    String? status,
    Value<String?> source = const Value.absent(),
  }) => Trial(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    memberId: memberId ?? this.memberId,
    startedAt: startedAt ?? this.startedAt,
    endsAt: endsAt ?? this.endsAt,
    convertedAt: convertedAt.present ? convertedAt.value : this.convertedAt,
    status: status ?? this.status,
    source: source.present ? source.value : this.source,
  );
  Trial copyWithCompanion(TrialsCompanion data) {
    return Trial(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      convertedAt: data.convertedAt.present
          ? data.convertedAt.value
          : this.convertedAt,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trial(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('convertedAt: $convertedAt, ')
          ..write('status: $status, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    memberId,
    startedAt,
    endsAt,
    convertedAt,
    status,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trial &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.memberId == this.memberId &&
          other.startedAt == this.startedAt &&
          other.endsAt == this.endsAt &&
          other.convertedAt == this.convertedAt &&
          other.status == this.status &&
          other.source == this.source);
}

class TrialsCompanion extends UpdateCompanion<Trial> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> memberId;
  final Value<DateTime> startedAt;
  final Value<DateTime> endsAt;
  final Value<DateTime?> convertedAt;
  final Value<String> status;
  final Value<String?> source;
  final Value<int> rowid;
  const TrialsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.convertedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrialsCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    required String memberId,
    required DateTime startedAt,
    required DateTime endsAt,
    this.convertedAt = const Value.absent(),
    required String status,
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       memberId = Value(memberId),
       startedAt = Value(startedAt),
       endsAt = Value(endsAt),
       status = Value(status);
  static Insertable<Trial> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? memberId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endsAt,
    Expression<DateTime>? convertedAt,
    Expression<String>? status,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (memberId != null) 'member_id': memberId,
      if (startedAt != null) 'started_at': startedAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (convertedAt != null) 'converted_at': convertedAt,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrialsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? memberId,
    Value<DateTime>? startedAt,
    Value<DateTime>? endsAt,
    Value<DateTime?>? convertedAt,
    Value<String>? status,
    Value<String?>? source,
    Value<int>? rowid,
  }) {
    return TrialsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      memberId: memberId ?? this.memberId,
      startedAt: startedAt ?? this.startedAt,
      endsAt: endsAt ?? this.endsAt,
      convertedAt: convertedAt ?? this.convertedAt,
      status: status ?? this.status,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (convertedAt.present) {
      map['converted_at'] = Variable<DateTime>(convertedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrialsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('convertedAt: $convertedAt, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FollowUpsTable extends FollowUps
    with TableInfo<$FollowUpsTable, FollowUp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FollowUpsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assignedToMeta = const VerificationMeta(
    'assignedTo',
  );
  @override
  late final GeneratedColumn<String> assignedTo = GeneratedColumn<String>(
    'assigned_to',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactChannelMeta = const VerificationMeta(
    'contactChannel',
  );
  @override
  late final GeneratedColumn<String> contactChannel = GeneratedColumn<String>(
    'contact_channel',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageTemplateIdMeta = const VerificationMeta(
    'messageTemplateId',
  );
  @override
  late final GeneratedColumn<String> messageTemplateId =
      GeneratedColumn<String>(
        'message_template_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _resolutionNoteMeta = const VerificationMeta(
    'resolutionNote',
  );
  @override
  late final GeneratedColumn<String> resolutionNote = GeneratedColumn<String>(
    'resolution_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    memberId,
    type,
    priority,
    reason,
    status,
    dueAt,
    assignedTo,
    contactChannel,
    messageTemplateId,
    resolutionNote,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'follow_ups';
  @override
  VerificationContext validateIntegrity(
    Insertable<FollowUp> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('assigned_to')) {
      context.handle(
        _assignedToMeta,
        assignedTo.isAcceptableOrUnknown(data['assigned_to']!, _assignedToMeta),
      );
    }
    if (data.containsKey('contact_channel')) {
      context.handle(
        _contactChannelMeta,
        contactChannel.isAcceptableOrUnknown(
          data['contact_channel']!,
          _contactChannelMeta,
        ),
      );
    }
    if (data.containsKey('message_template_id')) {
      context.handle(
        _messageTemplateIdMeta,
        messageTemplateId.isAcceptableOrUnknown(
          data['message_template_id']!,
          _messageTemplateIdMeta,
        ),
      );
    }
    if (data.containsKey('resolution_note')) {
      context.handle(
        _resolutionNoteMeta,
        resolutionNote.isAcceptableOrUnknown(
          data['resolution_note']!,
          _resolutionNoteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FollowUp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FollowUp(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      assignedTo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_to'],
      ),
      contactChannel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_channel'],
      ),
      messageTemplateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_template_id'],
      ),
      resolutionNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolution_note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FollowUpsTable createAlias(String alias) {
    return $FollowUpsTable(attachedDatabase, alias);
  }
}

class FollowUp extends DataClass implements Insertable<FollowUp> {
  final String id;
  final String organizationId;
  final String locationId;
  final String memberId;
  final String type;
  final int priority;
  final String reason;
  final String status;
  final DateTime? dueAt;
  final String? assignedTo;
  final String? contactChannel;
  final String? messageTemplateId;
  final String? resolutionNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FollowUp({
    required this.id,
    required this.organizationId,
    required this.locationId,
    required this.memberId,
    required this.type,
    required this.priority,
    required this.reason,
    required this.status,
    this.dueAt,
    this.assignedTo,
    this.contactChannel,
    this.messageTemplateId,
    this.resolutionNote,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['member_id'] = Variable<String>(memberId);
    map['type'] = Variable<String>(type);
    map['priority'] = Variable<int>(priority);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    if (!nullToAbsent || assignedTo != null) {
      map['assigned_to'] = Variable<String>(assignedTo);
    }
    if (!nullToAbsent || contactChannel != null) {
      map['contact_channel'] = Variable<String>(contactChannel);
    }
    if (!nullToAbsent || messageTemplateId != null) {
      map['message_template_id'] = Variable<String>(messageTemplateId);
    }
    if (!nullToAbsent || resolutionNote != null) {
      map['resolution_note'] = Variable<String>(resolutionNote);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FollowUpsCompanion toCompanion(bool nullToAbsent) {
    return FollowUpsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      memberId: Value(memberId),
      type: Value(type),
      priority: Value(priority),
      reason: Value(reason),
      status: Value(status),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      assignedTo: assignedTo == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedTo),
      contactChannel: contactChannel == null && nullToAbsent
          ? const Value.absent()
          : Value(contactChannel),
      messageTemplateId: messageTemplateId == null && nullToAbsent
          ? const Value.absent()
          : Value(messageTemplateId),
      resolutionNote: resolutionNote == null && nullToAbsent
          ? const Value.absent()
          : Value(resolutionNote),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FollowUp.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FollowUp(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      type: serializer.fromJson<String>(json['type']),
      priority: serializer.fromJson<int>(json['priority']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      assignedTo: serializer.fromJson<String?>(json['assignedTo']),
      contactChannel: serializer.fromJson<String?>(json['contactChannel']),
      messageTemplateId: serializer.fromJson<String?>(
        json['messageTemplateId'],
      ),
      resolutionNote: serializer.fromJson<String?>(json['resolutionNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'memberId': serializer.toJson<String>(memberId),
      'type': serializer.toJson<String>(type),
      'priority': serializer.toJson<int>(priority),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'assignedTo': serializer.toJson<String?>(assignedTo),
      'contactChannel': serializer.toJson<String?>(contactChannel),
      'messageTemplateId': serializer.toJson<String?>(messageTemplateId),
      'resolutionNote': serializer.toJson<String?>(resolutionNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FollowUp copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    String? memberId,
    String? type,
    int? priority,
    String? reason,
    String? status,
    Value<DateTime?> dueAt = const Value.absent(),
    Value<String?> assignedTo = const Value.absent(),
    Value<String?> contactChannel = const Value.absent(),
    Value<String?> messageTemplateId = const Value.absent(),
    Value<String?> resolutionNote = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FollowUp(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    memberId: memberId ?? this.memberId,
    type: type ?? this.type,
    priority: priority ?? this.priority,
    reason: reason ?? this.reason,
    status: status ?? this.status,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    assignedTo: assignedTo.present ? assignedTo.value : this.assignedTo,
    contactChannel: contactChannel.present
        ? contactChannel.value
        : this.contactChannel,
    messageTemplateId: messageTemplateId.present
        ? messageTemplateId.value
        : this.messageTemplateId,
    resolutionNote: resolutionNote.present
        ? resolutionNote.value
        : this.resolutionNote,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FollowUp copyWithCompanion(FollowUpsCompanion data) {
    return FollowUp(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      type: data.type.present ? data.type.value : this.type,
      priority: data.priority.present ? data.priority.value : this.priority,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      assignedTo: data.assignedTo.present
          ? data.assignedTo.value
          : this.assignedTo,
      contactChannel: data.contactChannel.present
          ? data.contactChannel.value
          : this.contactChannel,
      messageTemplateId: data.messageTemplateId.present
          ? data.messageTemplateId.value
          : this.messageTemplateId,
      resolutionNote: data.resolutionNote.present
          ? data.resolutionNote.value
          : this.resolutionNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FollowUp(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('type: $type, ')
          ..write('priority: $priority, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('dueAt: $dueAt, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('contactChannel: $contactChannel, ')
          ..write('messageTemplateId: $messageTemplateId, ')
          ..write('resolutionNote: $resolutionNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    memberId,
    type,
    priority,
    reason,
    status,
    dueAt,
    assignedTo,
    contactChannel,
    messageTemplateId,
    resolutionNote,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FollowUp &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.memberId == this.memberId &&
          other.type == this.type &&
          other.priority == this.priority &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.dueAt == this.dueAt &&
          other.assignedTo == this.assignedTo &&
          other.contactChannel == this.contactChannel &&
          other.messageTemplateId == this.messageTemplateId &&
          other.resolutionNote == this.resolutionNote &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FollowUpsCompanion extends UpdateCompanion<FollowUp> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> memberId;
  final Value<String> type;
  final Value<int> priority;
  final Value<String> reason;
  final Value<String> status;
  final Value<DateTime?> dueAt;
  final Value<String?> assignedTo;
  final Value<String?> contactChannel;
  final Value<String?> messageTemplateId;
  final Value<String?> resolutionNote;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FollowUpsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.type = const Value.absent(),
    this.priority = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.contactChannel = const Value.absent(),
    this.messageTemplateId = const Value.absent(),
    this.resolutionNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FollowUpsCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    required String memberId,
    required String type,
    this.priority = const Value.absent(),
    required String reason,
    required String status,
    this.dueAt = const Value.absent(),
    this.assignedTo = const Value.absent(),
    this.contactChannel = const Value.absent(),
    this.messageTemplateId = const Value.absent(),
    this.resolutionNote = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       memberId = Value(memberId),
       type = Value(type),
       reason = Value(reason),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FollowUp> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? memberId,
    Expression<String>? type,
    Expression<int>? priority,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<DateTime>? dueAt,
    Expression<String>? assignedTo,
    Expression<String>? contactChannel,
    Expression<String>? messageTemplateId,
    Expression<String>? resolutionNote,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (memberId != null) 'member_id': memberId,
      if (type != null) 'type': type,
      if (priority != null) 'priority': priority,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (dueAt != null) 'due_at': dueAt,
      if (assignedTo != null) 'assigned_to': assignedTo,
      if (contactChannel != null) 'contact_channel': contactChannel,
      if (messageTemplateId != null) 'message_template_id': messageTemplateId,
      if (resolutionNote != null) 'resolution_note': resolutionNote,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FollowUpsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? memberId,
    Value<String>? type,
    Value<int>? priority,
    Value<String>? reason,
    Value<String>? status,
    Value<DateTime?>? dueAt,
    Value<String?>? assignedTo,
    Value<String?>? contactChannel,
    Value<String?>? messageTemplateId,
    Value<String?>? resolutionNote,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FollowUpsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      memberId: memberId ?? this.memberId,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      dueAt: dueAt ?? this.dueAt,
      assignedTo: assignedTo ?? this.assignedTo,
      contactChannel: contactChannel ?? this.contactChannel,
      messageTemplateId: messageTemplateId ?? this.messageTemplateId,
      resolutionNote: resolutionNote ?? this.resolutionNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (assignedTo.present) {
      map['assigned_to'] = Variable<String>(assignedTo.value);
    }
    if (contactChannel.present) {
      map['contact_channel'] = Variable<String>(contactChannel.value);
    }
    if (messageTemplateId.present) {
      map['message_template_id'] = Variable<String>(messageTemplateId.value);
    }
    if (resolutionNote.present) {
      map['resolution_note'] = Variable<String>(resolutionNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FollowUpsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('type: $type, ')
          ..write('priority: $priority, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('dueAt: $dueAt, ')
          ..write('assignedTo: $assignedTo, ')
          ..write('contactChannel: $contactChannel, ')
          ..write('messageTemplateId: $messageTemplateId, ')
          ..write('resolutionNote: $resolutionNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageTemplatesTable extends MessageTemplates
    with TableInfo<$MessageTemplatesTable, MessageTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _channelMeta = const VerificationMeta(
    'channel',
  );
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
    'channel',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('whatsapp'),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    key,
    body,
    channel,
    active,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('channel')) {
      context.handle(
        _channelMeta,
        channel.isAcceptableOrUnknown(data['channel']!, _channelMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageTemplate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      ),
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      channel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MessageTemplatesTable createAlias(String alias) {
    return $MessageTemplatesTable(attachedDatabase, alias);
  }
}

class MessageTemplate extends DataClass implements Insertable<MessageTemplate> {
  final String id;
  final String organizationId;
  final String? locationId;
  final String key;
  final String body;
  final String channel;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MessageTemplate({
    required this.id,
    required this.organizationId,
    this.locationId,
    required this.key,
    required this.body,
    required this.channel,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<String>(locationId);
    }
    map['key'] = Variable<String>(key);
    map['body'] = Variable<String>(body);
    map['channel'] = Variable<String>(channel);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MessageTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MessageTemplatesCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
      key: Value(key),
      body: Value(body),
      channel: Value(channel),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MessageTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageTemplate(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String?>(json['locationId']),
      key: serializer.fromJson<String>(json['key']),
      body: serializer.fromJson<String>(json['body']),
      channel: serializer.fromJson<String>(json['channel']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String?>(locationId),
      'key': serializer.toJson<String>(key),
      'body': serializer.toJson<String>(body),
      'channel': serializer.toJson<String>(channel),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MessageTemplate copyWith({
    String? id,
    String? organizationId,
    Value<String?> locationId = const Value.absent(),
    String? key,
    String? body,
    String? channel,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MessageTemplate(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId.present ? locationId.value : this.locationId,
    key: key ?? this.key,
    body: body ?? this.body,
    channel: channel ?? this.channel,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MessageTemplate copyWithCompanion(MessageTemplatesCompanion data) {
    return MessageTemplate(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      key: data.key.present ? data.key.value : this.key,
      body: data.body.present ? data.body.value : this.body,
      channel: data.channel.present ? data.channel.value : this.channel,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageTemplate(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('key: $key, ')
          ..write('body: $body, ')
          ..write('channel: $channel, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    key,
    body,
    channel,
    active,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageTemplate &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.key == this.key &&
          other.body == this.body &&
          other.channel == this.channel &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MessageTemplatesCompanion extends UpdateCompanion<MessageTemplate> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String?> locationId;
  final Value<String> key;
  final Value<String> body;
  final Value<String> channel;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MessageTemplatesCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.key = const Value.absent(),
    this.body = const Value.absent(),
    this.channel = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageTemplatesCompanion.insert({
    required String id,
    required String organizationId,
    this.locationId = const Value.absent(),
    required String key,
    required String body,
    this.channel = const Value.absent(),
    this.active = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       key = Value(key),
       body = Value(body),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MessageTemplate> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? key,
    Expression<String>? body,
    Expression<String>? channel,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (key != null) 'key': key,
      if (body != null) 'body': body,
      if (channel != null) 'channel': channel,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String?>? locationId,
    Value<String>? key,
    Value<String>? body,
    Value<String>? channel,
    Value<bool>? active,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MessageTemplatesCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      key: key ?? this.key,
      body: body ?? this.body,
      channel: channel ?? this.channel,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('key: $key, ')
          ..write('body: $body, ')
          ..write('channel: $channel, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CancellationEventsTable extends CancellationEvents
    with TableInfo<$CancellationEventsTable, CancellationEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CancellationEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonCodeMeta = const VerificationMeta(
    'reasonCode',
  );
  @override
  late final GeneratedColumn<String> reasonCode = GeneratedColumn<String>(
    'reason_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonTextMeta = const VerificationMeta(
    'reasonText',
  );
  @override
  late final GeneratedColumn<String> reasonText = GeneratedColumn<String>(
    'reason_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    memberId,
    occurredAt,
    reasonCode,
    reasonText,
    source,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cancellation_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<CancellationEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('reason_code')) {
      context.handle(
        _reasonCodeMeta,
        reasonCode.isAcceptableOrUnknown(data['reason_code']!, _reasonCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonCodeMeta);
    }
    if (data.containsKey('reason_text')) {
      context.handle(
        _reasonTextMeta,
        reasonText.isAcceptableOrUnknown(data['reason_text']!, _reasonTextMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CancellationEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CancellationEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      reasonCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason_code'],
      )!,
      reasonText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason_text'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CancellationEventsTable createAlias(String alias) {
    return $CancellationEventsTable(attachedDatabase, alias);
  }
}

class CancellationEvent extends DataClass
    implements Insertable<CancellationEvent> {
  final String id;
  final String organizationId;
  final String locationId;
  final String memberId;
  final DateTime occurredAt;
  final String reasonCode;
  final String? reasonText;
  final String? source;
  final DateTime createdAt;
  const CancellationEvent({
    required this.id,
    required this.organizationId,
    required this.locationId,
    required this.memberId,
    required this.occurredAt,
    required this.reasonCode,
    this.reasonText,
    this.source,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['member_id'] = Variable<String>(memberId);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['reason_code'] = Variable<String>(reasonCode);
    if (!nullToAbsent || reasonText != null) {
      map['reason_text'] = Variable<String>(reasonText);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CancellationEventsCompanion toCompanion(bool nullToAbsent) {
    return CancellationEventsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      memberId: Value(memberId),
      occurredAt: Value(occurredAt),
      reasonCode: Value(reasonCode),
      reasonText: reasonText == null && nullToAbsent
          ? const Value.absent()
          : Value(reasonText),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
      createdAt: Value(createdAt),
    );
  }

  factory CancellationEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CancellationEvent(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      reasonCode: serializer.fromJson<String>(json['reasonCode']),
      reasonText: serializer.fromJson<String?>(json['reasonText']),
      source: serializer.fromJson<String?>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'memberId': serializer.toJson<String>(memberId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'reasonCode': serializer.toJson<String>(reasonCode),
      'reasonText': serializer.toJson<String?>(reasonText),
      'source': serializer.toJson<String?>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CancellationEvent copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    String? memberId,
    DateTime? occurredAt,
    String? reasonCode,
    Value<String?> reasonText = const Value.absent(),
    Value<String?> source = const Value.absent(),
    DateTime? createdAt,
  }) => CancellationEvent(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    memberId: memberId ?? this.memberId,
    occurredAt: occurredAt ?? this.occurredAt,
    reasonCode: reasonCode ?? this.reasonCode,
    reasonText: reasonText.present ? reasonText.value : this.reasonText,
    source: source.present ? source.value : this.source,
    createdAt: createdAt ?? this.createdAt,
  );
  CancellationEvent copyWithCompanion(CancellationEventsCompanion data) {
    return CancellationEvent(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      reasonCode: data.reasonCode.present
          ? data.reasonCode.value
          : this.reasonCode,
      reasonText: data.reasonText.present
          ? data.reasonText.value
          : this.reasonText,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CancellationEvent(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('reasonCode: $reasonCode, ')
          ..write('reasonText: $reasonText, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    memberId,
    occurredAt,
    reasonCode,
    reasonText,
    source,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CancellationEvent &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.memberId == this.memberId &&
          other.occurredAt == this.occurredAt &&
          other.reasonCode == this.reasonCode &&
          other.reasonText == this.reasonText &&
          other.source == this.source &&
          other.createdAt == this.createdAt);
}

class CancellationEventsCompanion extends UpdateCompanion<CancellationEvent> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> memberId;
  final Value<DateTime> occurredAt;
  final Value<String> reasonCode;
  final Value<String?> reasonText;
  final Value<String?> source;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CancellationEventsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.reasonCode = const Value.absent(),
    this.reasonText = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CancellationEventsCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    required String memberId,
    required DateTime occurredAt,
    required String reasonCode,
    this.reasonText = const Value.absent(),
    this.source = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       memberId = Value(memberId),
       occurredAt = Value(occurredAt),
       reasonCode = Value(reasonCode),
       createdAt = Value(createdAt);
  static Insertable<CancellationEvent> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? memberId,
    Expression<DateTime>? occurredAt,
    Expression<String>? reasonCode,
    Expression<String>? reasonText,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (memberId != null) 'member_id': memberId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (reasonCode != null) 'reason_code': reasonCode,
      if (reasonText != null) 'reason_text': reasonText,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CancellationEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? memberId,
    Value<DateTime>? occurredAt,
    Value<String>? reasonCode,
    Value<String?>? reasonText,
    Value<String?>? source,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CancellationEventsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      memberId: memberId ?? this.memberId,
      occurredAt: occurredAt ?? this.occurredAt,
      reasonCode: reasonCode ?? this.reasonCode,
      reasonText: reasonText ?? this.reasonText,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (reasonCode.present) {
      map['reason_code'] = Variable<String>(reasonCode.value);
    }
    if (reasonText.present) {
      map['reason_text'] = Variable<String>(reasonText.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CancellationEventsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('reasonCode: $reasonCode, ')
          ..write('reasonText: $reasonText, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RiskScoresTable extends RiskScores
    with TableInfo<$RiskScoresTable, RiskScore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RiskScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskLevelMeta = const VerificationMeta(
    'riskLevel',
  );
  @override
  late final GeneratedColumn<String> riskLevel = GeneratedColumn<String>(
    'risk_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calculatedAtMeta = const VerificationMeta(
    'calculatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> calculatedAt = GeneratedColumn<DateTime>(
    'calculated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorsJsonMeta = const VerificationMeta(
    'factorsJson',
  );
  @override
  late final GeneratedColumn<String> factorsJson = GeneratedColumn<String>(
    'factors_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    memberId,
    score,
    riskLevel,
    confidence,
    calculatedAt,
    factorsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'risk_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<RiskScore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('risk_level')) {
      context.handle(
        _riskLevelMeta,
        riskLevel.isAcceptableOrUnknown(data['risk_level']!, _riskLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_riskLevelMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('calculated_at')) {
      context.handle(
        _calculatedAtMeta,
        calculatedAt.isAcceptableOrUnknown(
          data['calculated_at']!,
          _calculatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculatedAtMeta);
    }
    if (data.containsKey('factors_json')) {
      context.handle(
        _factorsJsonMeta,
        factorsJson.isAcceptableOrUnknown(
          data['factors_json']!,
          _factorsJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RiskScore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RiskScore(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      riskLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_level'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      calculatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}calculated_at'],
      )!,
      factorsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}factors_json'],
      ),
    );
  }

  @override
  $RiskScoresTable createAlias(String alias) {
    return $RiskScoresTable(attachedDatabase, alias);
  }
}

class RiskScore extends DataClass implements Insertable<RiskScore> {
  final String id;
  final String organizationId;
  final String locationId;
  final String memberId;
  final int score;
  final String riskLevel;
  final double confidence;
  final DateTime calculatedAt;
  final String? factorsJson;
  const RiskScore({
    required this.id,
    required this.organizationId,
    required this.locationId,
    required this.memberId,
    required this.score,
    required this.riskLevel,
    required this.confidence,
    required this.calculatedAt,
    this.factorsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['member_id'] = Variable<String>(memberId);
    map['score'] = Variable<int>(score);
    map['risk_level'] = Variable<String>(riskLevel);
    map['confidence'] = Variable<double>(confidence);
    map['calculated_at'] = Variable<DateTime>(calculatedAt);
    if (!nullToAbsent || factorsJson != null) {
      map['factors_json'] = Variable<String>(factorsJson);
    }
    return map;
  }

  RiskScoresCompanion toCompanion(bool nullToAbsent) {
    return RiskScoresCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      memberId: Value(memberId),
      score: Value(score),
      riskLevel: Value(riskLevel),
      confidence: Value(confidence),
      calculatedAt: Value(calculatedAt),
      factorsJson: factorsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(factorsJson),
    );
  }

  factory RiskScore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RiskScore(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      score: serializer.fromJson<int>(json['score']),
      riskLevel: serializer.fromJson<String>(json['riskLevel']),
      confidence: serializer.fromJson<double>(json['confidence']),
      calculatedAt: serializer.fromJson<DateTime>(json['calculatedAt']),
      factorsJson: serializer.fromJson<String?>(json['factorsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'memberId': serializer.toJson<String>(memberId),
      'score': serializer.toJson<int>(score),
      'riskLevel': serializer.toJson<String>(riskLevel),
      'confidence': serializer.toJson<double>(confidence),
      'calculatedAt': serializer.toJson<DateTime>(calculatedAt),
      'factorsJson': serializer.toJson<String?>(factorsJson),
    };
  }

  RiskScore copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    String? memberId,
    int? score,
    String? riskLevel,
    double? confidence,
    DateTime? calculatedAt,
    Value<String?> factorsJson = const Value.absent(),
  }) => RiskScore(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    memberId: memberId ?? this.memberId,
    score: score ?? this.score,
    riskLevel: riskLevel ?? this.riskLevel,
    confidence: confidence ?? this.confidence,
    calculatedAt: calculatedAt ?? this.calculatedAt,
    factorsJson: factorsJson.present ? factorsJson.value : this.factorsJson,
  );
  RiskScore copyWithCompanion(RiskScoresCompanion data) {
    return RiskScore(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      score: data.score.present ? data.score.value : this.score,
      riskLevel: data.riskLevel.present ? data.riskLevel.value : this.riskLevel,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      calculatedAt: data.calculatedAt.present
          ? data.calculatedAt.value
          : this.calculatedAt,
      factorsJson: data.factorsJson.present
          ? data.factorsJson.value
          : this.factorsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RiskScore(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('score: $score, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('confidence: $confidence, ')
          ..write('calculatedAt: $calculatedAt, ')
          ..write('factorsJson: $factorsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    memberId,
    score,
    riskLevel,
    confidence,
    calculatedAt,
    factorsJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RiskScore &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.memberId == this.memberId &&
          other.score == this.score &&
          other.riskLevel == this.riskLevel &&
          other.confidence == this.confidence &&
          other.calculatedAt == this.calculatedAt &&
          other.factorsJson == this.factorsJson);
}

class RiskScoresCompanion extends UpdateCompanion<RiskScore> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> memberId;
  final Value<int> score;
  final Value<String> riskLevel;
  final Value<double> confidence;
  final Value<DateTime> calculatedAt;
  final Value<String?> factorsJson;
  final Value<int> rowid;
  const RiskScoresCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.score = const Value.absent(),
    this.riskLevel = const Value.absent(),
    this.confidence = const Value.absent(),
    this.calculatedAt = const Value.absent(),
    this.factorsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RiskScoresCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    required String memberId,
    required int score,
    required String riskLevel,
    required double confidence,
    required DateTime calculatedAt,
    this.factorsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       memberId = Value(memberId),
       score = Value(score),
       riskLevel = Value(riskLevel),
       confidence = Value(confidence),
       calculatedAt = Value(calculatedAt);
  static Insertable<RiskScore> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? memberId,
    Expression<int>? score,
    Expression<String>? riskLevel,
    Expression<double>? confidence,
    Expression<DateTime>? calculatedAt,
    Expression<String>? factorsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (memberId != null) 'member_id': memberId,
      if (score != null) 'score': score,
      if (riskLevel != null) 'risk_level': riskLevel,
      if (confidence != null) 'confidence': confidence,
      if (calculatedAt != null) 'calculated_at': calculatedAt,
      if (factorsJson != null) 'factors_json': factorsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RiskScoresCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? memberId,
    Value<int>? score,
    Value<String>? riskLevel,
    Value<double>? confidence,
    Value<DateTime>? calculatedAt,
    Value<String?>? factorsJson,
    Value<int>? rowid,
  }) {
    return RiskScoresCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      memberId: memberId ?? this.memberId,
      score: score ?? this.score,
      riskLevel: riskLevel ?? this.riskLevel,
      confidence: confidence ?? this.confidence,
      calculatedAt: calculatedAt ?? this.calculatedAt,
      factorsJson: factorsJson ?? this.factorsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (riskLevel.present) {
      map['risk_level'] = Variable<String>(riskLevel.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (calculatedAt.present) {
      map['calculated_at'] = Variable<DateTime>(calculatedAt.value);
    }
    if (factorsJson.present) {
      map['factors_json'] = Variable<String>(factorsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RiskScoresCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('score: $score, ')
          ..write('riskLevel: $riskLevel, ')
          ..write('confidence: $confidence, ')
          ..write('calculatedAt: $calculatedAt, ')
          ..write('factorsJson: $factorsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyMemberMetricsTable extends DailyMemberMetrics
    with TableInfo<$DailyMemberMetricsTable, DailyMemberMetric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyMemberMetricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visitsMeta = const VerificationMeta('visits');
  @override
  late final GeneratedColumn<int> visits = GeneratedColumn<int>(
    'visits',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _daysSinceLastVisitMeta =
      const VerificationMeta('daysSinceLastVisit');
  @override
  late final GeneratedColumn<int> daysSinceLastVisit = GeneratedColumn<int>(
    'days_since_last_visit',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rolling7dVisitsMeta = const VerificationMeta(
    'rolling7dVisits',
  );
  @override
  late final GeneratedColumn<double> rolling7dVisits = GeneratedColumn<double>(
    'rolling7d_visits',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rolling30dVisitsMeta = const VerificationMeta(
    'rolling30dVisits',
  );
  @override
  late final GeneratedColumn<double> rolling30dVisits = GeneratedColumn<double>(
    'rolling30d_visits',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attendanceChangeMeta = const VerificationMeta(
    'attendanceChange',
  );
  @override
  late final GeneratedColumn<double> attendanceChange = GeneratedColumn<double>(
    'attendance_change',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _membershipDaysRemainingMeta =
      const VerificationMeta('membershipDaysRemaining');
  @override
  late final GeneratedColumn<int> membershipDaysRemaining =
      GeneratedColumn<int>(
        'membership_days_remaining',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    organizationId,
    locationId,
    memberId,
    date,
    visits,
    daysSinceLastVisit,
    rolling7dVisits,
    rolling30dVisits,
    attendanceChange,
    membershipDaysRemaining,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_member_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyMemberMetric> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('visits')) {
      context.handle(
        _visitsMeta,
        visits.isAcceptableOrUnknown(data['visits']!, _visitsMeta),
      );
    }
    if (data.containsKey('days_since_last_visit')) {
      context.handle(
        _daysSinceLastVisitMeta,
        daysSinceLastVisit.isAcceptableOrUnknown(
          data['days_since_last_visit']!,
          _daysSinceLastVisitMeta,
        ),
      );
    }
    if (data.containsKey('rolling7d_visits')) {
      context.handle(
        _rolling7dVisitsMeta,
        rolling7dVisits.isAcceptableOrUnknown(
          data['rolling7d_visits']!,
          _rolling7dVisitsMeta,
        ),
      );
    }
    if (data.containsKey('rolling30d_visits')) {
      context.handle(
        _rolling30dVisitsMeta,
        rolling30dVisits.isAcceptableOrUnknown(
          data['rolling30d_visits']!,
          _rolling30dVisitsMeta,
        ),
      );
    }
    if (data.containsKey('attendance_change')) {
      context.handle(
        _attendanceChangeMeta,
        attendanceChange.isAcceptableOrUnknown(
          data['attendance_change']!,
          _attendanceChangeMeta,
        ),
      );
    }
    if (data.containsKey('membership_days_remaining')) {
      context.handle(
        _membershipDaysRemainingMeta,
        membershipDaysRemaining.isAcceptableOrUnknown(
          data['membership_days_remaining']!,
          _membershipDaysRemainingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    organizationId,
    locationId,
    memberId,
    date,
  };
  @override
  DailyMemberMetric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyMemberMetric(
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      visits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}visits'],
      )!,
      daysSinceLastVisit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}days_since_last_visit'],
      ),
      rolling7dVisits: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rolling7d_visits'],
      ),
      rolling30dVisits: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rolling30d_visits'],
      ),
      attendanceChange: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}attendance_change'],
      ),
      membershipDaysRemaining: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}membership_days_remaining'],
      ),
    );
  }

  @override
  $DailyMemberMetricsTable createAlias(String alias) {
    return $DailyMemberMetricsTable(attachedDatabase, alias);
  }
}

class DailyMemberMetric extends DataClass
    implements Insertable<DailyMemberMetric> {
  final String organizationId;
  final String locationId;
  final String memberId;
  final DateTime date;
  final int visits;
  final int? daysSinceLastVisit;
  final double? rolling7dVisits;
  final double? rolling30dVisits;
  final double? attendanceChange;
  final int? membershipDaysRemaining;
  const DailyMemberMetric({
    required this.organizationId,
    required this.locationId,
    required this.memberId,
    required this.date,
    required this.visits,
    this.daysSinceLastVisit,
    this.rolling7dVisits,
    this.rolling30dVisits,
    this.attendanceChange,
    this.membershipDaysRemaining,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['member_id'] = Variable<String>(memberId);
    map['date'] = Variable<DateTime>(date);
    map['visits'] = Variable<int>(visits);
    if (!nullToAbsent || daysSinceLastVisit != null) {
      map['days_since_last_visit'] = Variable<int>(daysSinceLastVisit);
    }
    if (!nullToAbsent || rolling7dVisits != null) {
      map['rolling7d_visits'] = Variable<double>(rolling7dVisits);
    }
    if (!nullToAbsent || rolling30dVisits != null) {
      map['rolling30d_visits'] = Variable<double>(rolling30dVisits);
    }
    if (!nullToAbsent || attendanceChange != null) {
      map['attendance_change'] = Variable<double>(attendanceChange);
    }
    if (!nullToAbsent || membershipDaysRemaining != null) {
      map['membership_days_remaining'] = Variable<int>(membershipDaysRemaining);
    }
    return map;
  }

  DailyMemberMetricsCompanion toCompanion(bool nullToAbsent) {
    return DailyMemberMetricsCompanion(
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      memberId: Value(memberId),
      date: Value(date),
      visits: Value(visits),
      daysSinceLastVisit: daysSinceLastVisit == null && nullToAbsent
          ? const Value.absent()
          : Value(daysSinceLastVisit),
      rolling7dVisits: rolling7dVisits == null && nullToAbsent
          ? const Value.absent()
          : Value(rolling7dVisits),
      rolling30dVisits: rolling30dVisits == null && nullToAbsent
          ? const Value.absent()
          : Value(rolling30dVisits),
      attendanceChange: attendanceChange == null && nullToAbsent
          ? const Value.absent()
          : Value(attendanceChange),
      membershipDaysRemaining: membershipDaysRemaining == null && nullToAbsent
          ? const Value.absent()
          : Value(membershipDaysRemaining),
    );
  }

  factory DailyMemberMetric.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyMemberMetric(
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      date: serializer.fromJson<DateTime>(json['date']),
      visits: serializer.fromJson<int>(json['visits']),
      daysSinceLastVisit: serializer.fromJson<int?>(json['daysSinceLastVisit']),
      rolling7dVisits: serializer.fromJson<double?>(json['rolling7dVisits']),
      rolling30dVisits: serializer.fromJson<double?>(json['rolling30dVisits']),
      attendanceChange: serializer.fromJson<double?>(json['attendanceChange']),
      membershipDaysRemaining: serializer.fromJson<int?>(
        json['membershipDaysRemaining'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'memberId': serializer.toJson<String>(memberId),
      'date': serializer.toJson<DateTime>(date),
      'visits': serializer.toJson<int>(visits),
      'daysSinceLastVisit': serializer.toJson<int?>(daysSinceLastVisit),
      'rolling7dVisits': serializer.toJson<double?>(rolling7dVisits),
      'rolling30dVisits': serializer.toJson<double?>(rolling30dVisits),
      'attendanceChange': serializer.toJson<double?>(attendanceChange),
      'membershipDaysRemaining': serializer.toJson<int?>(
        membershipDaysRemaining,
      ),
    };
  }

  DailyMemberMetric copyWith({
    String? organizationId,
    String? locationId,
    String? memberId,
    DateTime? date,
    int? visits,
    Value<int?> daysSinceLastVisit = const Value.absent(),
    Value<double?> rolling7dVisits = const Value.absent(),
    Value<double?> rolling30dVisits = const Value.absent(),
    Value<double?> attendanceChange = const Value.absent(),
    Value<int?> membershipDaysRemaining = const Value.absent(),
  }) => DailyMemberMetric(
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    memberId: memberId ?? this.memberId,
    date: date ?? this.date,
    visits: visits ?? this.visits,
    daysSinceLastVisit: daysSinceLastVisit.present
        ? daysSinceLastVisit.value
        : this.daysSinceLastVisit,
    rolling7dVisits: rolling7dVisits.present
        ? rolling7dVisits.value
        : this.rolling7dVisits,
    rolling30dVisits: rolling30dVisits.present
        ? rolling30dVisits.value
        : this.rolling30dVisits,
    attendanceChange: attendanceChange.present
        ? attendanceChange.value
        : this.attendanceChange,
    membershipDaysRemaining: membershipDaysRemaining.present
        ? membershipDaysRemaining.value
        : this.membershipDaysRemaining,
  );
  DailyMemberMetric copyWithCompanion(DailyMemberMetricsCompanion data) {
    return DailyMemberMetric(
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      date: data.date.present ? data.date.value : this.date,
      visits: data.visits.present ? data.visits.value : this.visits,
      daysSinceLastVisit: data.daysSinceLastVisit.present
          ? data.daysSinceLastVisit.value
          : this.daysSinceLastVisit,
      rolling7dVisits: data.rolling7dVisits.present
          ? data.rolling7dVisits.value
          : this.rolling7dVisits,
      rolling30dVisits: data.rolling30dVisits.present
          ? data.rolling30dVisits.value
          : this.rolling30dVisits,
      attendanceChange: data.attendanceChange.present
          ? data.attendanceChange.value
          : this.attendanceChange,
      membershipDaysRemaining: data.membershipDaysRemaining.present
          ? data.membershipDaysRemaining.value
          : this.membershipDaysRemaining,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyMemberMetric(')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('date: $date, ')
          ..write('visits: $visits, ')
          ..write('daysSinceLastVisit: $daysSinceLastVisit, ')
          ..write('rolling7dVisits: $rolling7dVisits, ')
          ..write('rolling30dVisits: $rolling30dVisits, ')
          ..write('attendanceChange: $attendanceChange, ')
          ..write('membershipDaysRemaining: $membershipDaysRemaining')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    organizationId,
    locationId,
    memberId,
    date,
    visits,
    daysSinceLastVisit,
    rolling7dVisits,
    rolling30dVisits,
    attendanceChange,
    membershipDaysRemaining,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyMemberMetric &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.memberId == this.memberId &&
          other.date == this.date &&
          other.visits == this.visits &&
          other.daysSinceLastVisit == this.daysSinceLastVisit &&
          other.rolling7dVisits == this.rolling7dVisits &&
          other.rolling30dVisits == this.rolling30dVisits &&
          other.attendanceChange == this.attendanceChange &&
          other.membershipDaysRemaining == this.membershipDaysRemaining);
}

class DailyMemberMetricsCompanion extends UpdateCompanion<DailyMemberMetric> {
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> memberId;
  final Value<DateTime> date;
  final Value<int> visits;
  final Value<int?> daysSinceLastVisit;
  final Value<double?> rolling7dVisits;
  final Value<double?> rolling30dVisits;
  final Value<double?> attendanceChange;
  final Value<int?> membershipDaysRemaining;
  final Value<int> rowid;
  const DailyMemberMetricsCompanion({
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.date = const Value.absent(),
    this.visits = const Value.absent(),
    this.daysSinceLastVisit = const Value.absent(),
    this.rolling7dVisits = const Value.absent(),
    this.rolling30dVisits = const Value.absent(),
    this.attendanceChange = const Value.absent(),
    this.membershipDaysRemaining = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyMemberMetricsCompanion.insert({
    required String organizationId,
    required String locationId,
    required String memberId,
    required DateTime date,
    this.visits = const Value.absent(),
    this.daysSinceLastVisit = const Value.absent(),
    this.rolling7dVisits = const Value.absent(),
    this.rolling30dVisits = const Value.absent(),
    this.attendanceChange = const Value.absent(),
    this.membershipDaysRemaining = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : organizationId = Value(organizationId),
       locationId = Value(locationId),
       memberId = Value(memberId),
       date = Value(date);
  static Insertable<DailyMemberMetric> custom({
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? memberId,
    Expression<DateTime>? date,
    Expression<int>? visits,
    Expression<int>? daysSinceLastVisit,
    Expression<double>? rolling7dVisits,
    Expression<double>? rolling30dVisits,
    Expression<double>? attendanceChange,
    Expression<int>? membershipDaysRemaining,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (memberId != null) 'member_id': memberId,
      if (date != null) 'date': date,
      if (visits != null) 'visits': visits,
      if (daysSinceLastVisit != null)
        'days_since_last_visit': daysSinceLastVisit,
      if (rolling7dVisits != null) 'rolling7d_visits': rolling7dVisits,
      if (rolling30dVisits != null) 'rolling30d_visits': rolling30dVisits,
      if (attendanceChange != null) 'attendance_change': attendanceChange,
      if (membershipDaysRemaining != null)
        'membership_days_remaining': membershipDaysRemaining,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyMemberMetricsCompanion copyWith({
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? memberId,
    Value<DateTime>? date,
    Value<int>? visits,
    Value<int?>? daysSinceLastVisit,
    Value<double?>? rolling7dVisits,
    Value<double?>? rolling30dVisits,
    Value<double?>? attendanceChange,
    Value<int?>? membershipDaysRemaining,
    Value<int>? rowid,
  }) {
    return DailyMemberMetricsCompanion(
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      memberId: memberId ?? this.memberId,
      date: date ?? this.date,
      visits: visits ?? this.visits,
      daysSinceLastVisit: daysSinceLastVisit ?? this.daysSinceLastVisit,
      rolling7dVisits: rolling7dVisits ?? this.rolling7dVisits,
      rolling30dVisits: rolling30dVisits ?? this.rolling30dVisits,
      attendanceChange: attendanceChange ?? this.attendanceChange,
      membershipDaysRemaining:
          membershipDaysRemaining ?? this.membershipDaysRemaining,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (visits.present) {
      map['visits'] = Variable<int>(visits.value);
    }
    if (daysSinceLastVisit.present) {
      map['days_since_last_visit'] = Variable<int>(daysSinceLastVisit.value);
    }
    if (rolling7dVisits.present) {
      map['rolling7d_visits'] = Variable<double>(rolling7dVisits.value);
    }
    if (rolling30dVisits.present) {
      map['rolling30d_visits'] = Variable<double>(rolling30dVisits.value);
    }
    if (attendanceChange.present) {
      map['attendance_change'] = Variable<double>(attendanceChange.value);
    }
    if (membershipDaysRemaining.present) {
      map['membership_days_remaining'] = Variable<int>(
        membershipDaysRemaining.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyMemberMetricsCompanion(')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('memberId: $memberId, ')
          ..write('date: $date, ')
          ..write('visits: $visits, ')
          ..write('daysSinceLastVisit: $daysSinceLastVisit, ')
          ..write('rolling7dVisits: $rolling7dVisits, ')
          ..write('rolling30dVisits: $rolling30dVisits, ')
          ..write('attendanceChange: $attendanceChange, ')
          ..write('membershipDaysRemaining: $membershipDaysRemaining, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GymDailyMetricsTable extends GymDailyMetrics
    with TableInfo<$GymDailyMetricsTable, GymDailyMetric> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GymDailyMetricsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMembersMeta = const VerificationMeta(
    'activeMembers',
  );
  @override
  late final GeneratedColumn<int> activeMembers = GeneratedColumn<int>(
    'active_members',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _visitsMeta = const VerificationMeta('visits');
  @override
  late final GeneratedColumn<int> visits = GeneratedColumn<int>(
    'visits',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _uniqueVisitorsMeta = const VerificationMeta(
    'uniqueVisitors',
  );
  @override
  late final GeneratedColumn<int> uniqueVisitors = GeneratedColumn<int>(
    'unique_visitors',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _trialsMeta = const VerificationMeta('trials');
  @override
  late final GeneratedColumn<int> trials = GeneratedColumn<int>(
    'trials',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _trialConversionsMeta = const VerificationMeta(
    'trialConversions',
  );
  @override
  late final GeneratedColumn<int> trialConversions = GeneratedColumn<int>(
    'trial_conversions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _renewalsMeta = const VerificationMeta(
    'renewals',
  );
  @override
  late final GeneratedColumn<int> renewals = GeneratedColumn<int>(
    'renewals',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cancellationsMeta = const VerificationMeta(
    'cancellations',
  );
  @override
  late final GeneratedColumn<int> cancellations = GeneratedColumn<int>(
    'cancellations',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    organizationId,
    locationId,
    date,
    activeMembers,
    visits,
    uniqueVisitors,
    trials,
    trialConversions,
    renewals,
    cancellations,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gym_daily_metrics';
  @override
  VerificationContext validateIntegrity(
    Insertable<GymDailyMetric> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('active_members')) {
      context.handle(
        _activeMembersMeta,
        activeMembers.isAcceptableOrUnknown(
          data['active_members']!,
          _activeMembersMeta,
        ),
      );
    }
    if (data.containsKey('visits')) {
      context.handle(
        _visitsMeta,
        visits.isAcceptableOrUnknown(data['visits']!, _visitsMeta),
      );
    }
    if (data.containsKey('unique_visitors')) {
      context.handle(
        _uniqueVisitorsMeta,
        uniqueVisitors.isAcceptableOrUnknown(
          data['unique_visitors']!,
          _uniqueVisitorsMeta,
        ),
      );
    }
    if (data.containsKey('trials')) {
      context.handle(
        _trialsMeta,
        trials.isAcceptableOrUnknown(data['trials']!, _trialsMeta),
      );
    }
    if (data.containsKey('trial_conversions')) {
      context.handle(
        _trialConversionsMeta,
        trialConversions.isAcceptableOrUnknown(
          data['trial_conversions']!,
          _trialConversionsMeta,
        ),
      );
    }
    if (data.containsKey('renewals')) {
      context.handle(
        _renewalsMeta,
        renewals.isAcceptableOrUnknown(data['renewals']!, _renewalsMeta),
      );
    }
    if (data.containsKey('cancellations')) {
      context.handle(
        _cancellationsMeta,
        cancellations.isAcceptableOrUnknown(
          data['cancellations']!,
          _cancellationsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {organizationId, locationId, date};
  @override
  GymDailyMetric map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GymDailyMetric(
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      activeMembers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_members'],
      )!,
      visits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}visits'],
      )!,
      uniqueVisitors: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unique_visitors'],
      )!,
      trials: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trials'],
      )!,
      trialConversions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trial_conversions'],
      )!,
      renewals: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}renewals'],
      )!,
      cancellations: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cancellations'],
      )!,
    );
  }

  @override
  $GymDailyMetricsTable createAlias(String alias) {
    return $GymDailyMetricsTable(attachedDatabase, alias);
  }
}

class GymDailyMetric extends DataClass implements Insertable<GymDailyMetric> {
  final String organizationId;
  final String locationId;
  final DateTime date;
  final int activeMembers;
  final int visits;
  final int uniqueVisitors;
  final int trials;
  final int trialConversions;
  final int renewals;
  final int cancellations;
  const GymDailyMetric({
    required this.organizationId,
    required this.locationId,
    required this.date,
    required this.activeMembers,
    required this.visits,
    required this.uniqueVisitors,
    required this.trials,
    required this.trialConversions,
    required this.renewals,
    required this.cancellations,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['date'] = Variable<DateTime>(date);
    map['active_members'] = Variable<int>(activeMembers);
    map['visits'] = Variable<int>(visits);
    map['unique_visitors'] = Variable<int>(uniqueVisitors);
    map['trials'] = Variable<int>(trials);
    map['trial_conversions'] = Variable<int>(trialConversions);
    map['renewals'] = Variable<int>(renewals);
    map['cancellations'] = Variable<int>(cancellations);
    return map;
  }

  GymDailyMetricsCompanion toCompanion(bool nullToAbsent) {
    return GymDailyMetricsCompanion(
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      date: Value(date),
      activeMembers: Value(activeMembers),
      visits: Value(visits),
      uniqueVisitors: Value(uniqueVisitors),
      trials: Value(trials),
      trialConversions: Value(trialConversions),
      renewals: Value(renewals),
      cancellations: Value(cancellations),
    );
  }

  factory GymDailyMetric.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GymDailyMetric(
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      date: serializer.fromJson<DateTime>(json['date']),
      activeMembers: serializer.fromJson<int>(json['activeMembers']),
      visits: serializer.fromJson<int>(json['visits']),
      uniqueVisitors: serializer.fromJson<int>(json['uniqueVisitors']),
      trials: serializer.fromJson<int>(json['trials']),
      trialConversions: serializer.fromJson<int>(json['trialConversions']),
      renewals: serializer.fromJson<int>(json['renewals']),
      cancellations: serializer.fromJson<int>(json['cancellations']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'date': serializer.toJson<DateTime>(date),
      'activeMembers': serializer.toJson<int>(activeMembers),
      'visits': serializer.toJson<int>(visits),
      'uniqueVisitors': serializer.toJson<int>(uniqueVisitors),
      'trials': serializer.toJson<int>(trials),
      'trialConversions': serializer.toJson<int>(trialConversions),
      'renewals': serializer.toJson<int>(renewals),
      'cancellations': serializer.toJson<int>(cancellations),
    };
  }

  GymDailyMetric copyWith({
    String? organizationId,
    String? locationId,
    DateTime? date,
    int? activeMembers,
    int? visits,
    int? uniqueVisitors,
    int? trials,
    int? trialConversions,
    int? renewals,
    int? cancellations,
  }) => GymDailyMetric(
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    date: date ?? this.date,
    activeMembers: activeMembers ?? this.activeMembers,
    visits: visits ?? this.visits,
    uniqueVisitors: uniqueVisitors ?? this.uniqueVisitors,
    trials: trials ?? this.trials,
    trialConversions: trialConversions ?? this.trialConversions,
    renewals: renewals ?? this.renewals,
    cancellations: cancellations ?? this.cancellations,
  );
  GymDailyMetric copyWithCompanion(GymDailyMetricsCompanion data) {
    return GymDailyMetric(
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      date: data.date.present ? data.date.value : this.date,
      activeMembers: data.activeMembers.present
          ? data.activeMembers.value
          : this.activeMembers,
      visits: data.visits.present ? data.visits.value : this.visits,
      uniqueVisitors: data.uniqueVisitors.present
          ? data.uniqueVisitors.value
          : this.uniqueVisitors,
      trials: data.trials.present ? data.trials.value : this.trials,
      trialConversions: data.trialConversions.present
          ? data.trialConversions.value
          : this.trialConversions,
      renewals: data.renewals.present ? data.renewals.value : this.renewals,
      cancellations: data.cancellations.present
          ? data.cancellations.value
          : this.cancellations,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GymDailyMetric(')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('date: $date, ')
          ..write('activeMembers: $activeMembers, ')
          ..write('visits: $visits, ')
          ..write('uniqueVisitors: $uniqueVisitors, ')
          ..write('trials: $trials, ')
          ..write('trialConversions: $trialConversions, ')
          ..write('renewals: $renewals, ')
          ..write('cancellations: $cancellations')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    organizationId,
    locationId,
    date,
    activeMembers,
    visits,
    uniqueVisitors,
    trials,
    trialConversions,
    renewals,
    cancellations,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GymDailyMetric &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.date == this.date &&
          other.activeMembers == this.activeMembers &&
          other.visits == this.visits &&
          other.uniqueVisitors == this.uniqueVisitors &&
          other.trials == this.trials &&
          other.trialConversions == this.trialConversions &&
          other.renewals == this.renewals &&
          other.cancellations == this.cancellations);
}

class GymDailyMetricsCompanion extends UpdateCompanion<GymDailyMetric> {
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<DateTime> date;
  final Value<int> activeMembers;
  final Value<int> visits;
  final Value<int> uniqueVisitors;
  final Value<int> trials;
  final Value<int> trialConversions;
  final Value<int> renewals;
  final Value<int> cancellations;
  final Value<int> rowid;
  const GymDailyMetricsCompanion({
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.date = const Value.absent(),
    this.activeMembers = const Value.absent(),
    this.visits = const Value.absent(),
    this.uniqueVisitors = const Value.absent(),
    this.trials = const Value.absent(),
    this.trialConversions = const Value.absent(),
    this.renewals = const Value.absent(),
    this.cancellations = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GymDailyMetricsCompanion.insert({
    required String organizationId,
    required String locationId,
    required DateTime date,
    this.activeMembers = const Value.absent(),
    this.visits = const Value.absent(),
    this.uniqueVisitors = const Value.absent(),
    this.trials = const Value.absent(),
    this.trialConversions = const Value.absent(),
    this.renewals = const Value.absent(),
    this.cancellations = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : organizationId = Value(organizationId),
       locationId = Value(locationId),
       date = Value(date);
  static Insertable<GymDailyMetric> custom({
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<DateTime>? date,
    Expression<int>? activeMembers,
    Expression<int>? visits,
    Expression<int>? uniqueVisitors,
    Expression<int>? trials,
    Expression<int>? trialConversions,
    Expression<int>? renewals,
    Expression<int>? cancellations,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (date != null) 'date': date,
      if (activeMembers != null) 'active_members': activeMembers,
      if (visits != null) 'visits': visits,
      if (uniqueVisitors != null) 'unique_visitors': uniqueVisitors,
      if (trials != null) 'trials': trials,
      if (trialConversions != null) 'trial_conversions': trialConversions,
      if (renewals != null) 'renewals': renewals,
      if (cancellations != null) 'cancellations': cancellations,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GymDailyMetricsCompanion copyWith({
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<DateTime>? date,
    Value<int>? activeMembers,
    Value<int>? visits,
    Value<int>? uniqueVisitors,
    Value<int>? trials,
    Value<int>? trialConversions,
    Value<int>? renewals,
    Value<int>? cancellations,
    Value<int>? rowid,
  }) {
    return GymDailyMetricsCompanion(
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      date: date ?? this.date,
      activeMembers: activeMembers ?? this.activeMembers,
      visits: visits ?? this.visits,
      uniqueVisitors: uniqueVisitors ?? this.uniqueVisitors,
      trials: trials ?? this.trials,
      trialConversions: trialConversions ?? this.trialConversions,
      renewals: renewals ?? this.renewals,
      cancellations: cancellations ?? this.cancellations,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (activeMembers.present) {
      map['active_members'] = Variable<int>(activeMembers.value);
    }
    if (visits.present) {
      map['visits'] = Variable<int>(visits.value);
    }
    if (uniqueVisitors.present) {
      map['unique_visitors'] = Variable<int>(uniqueVisitors.value);
    }
    if (trials.present) {
      map['trials'] = Variable<int>(trials.value);
    }
    if (trialConversions.present) {
      map['trial_conversions'] = Variable<int>(trialConversions.value);
    }
    if (renewals.present) {
      map['renewals'] = Variable<int>(renewals.value);
    }
    if (cancellations.present) {
      map['cancellations'] = Variable<int>(cancellations.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GymDailyMetricsCompanion(')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('date: $date, ')
          ..write('activeMembers: $activeMembers, ')
          ..write('visits: $visits, ')
          ..write('uniqueVisitors: $uniqueVisitors, ')
          ..write('trials: $trials, ')
          ..write('trialConversions: $trialConversions, ')
          ..write('renewals: $renewals, ')
          ..write('cancellations: $cancellations, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IntegrationSyncRunsTable extends IntegrationSyncRuns
    with TableInfo<$IntegrationSyncRunsTable, IntegrationSyncRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IntegrationSyncRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordsReadMeta = const VerificationMeta(
    'recordsRead',
  );
  @override
  late final GeneratedColumn<int> recordsRead = GeneratedColumn<int>(
    'records_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recordsCreatedMeta = const VerificationMeta(
    'recordsCreated',
  );
  @override
  late final GeneratedColumn<int> recordsCreated = GeneratedColumn<int>(
    'records_created',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recordsUpdatedMeta = const VerificationMeta(
    'recordsUpdated',
  );
  @override
  late final GeneratedColumn<int> recordsUpdated = GeneratedColumn<int>(
    'records_updated',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recordsSkippedMeta = const VerificationMeta(
    'recordsSkipped',
  );
  @override
  late final GeneratedColumn<int> recordsSkipped = GeneratedColumn<int>(
    'records_skipped',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _errorCountMeta = const VerificationMeta(
    'errorCount',
  );
  @override
  late final GeneratedColumn<int> errorCount = GeneratedColumn<int>(
    'error_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _errorSummaryMeta = const VerificationMeta(
    'errorSummary',
  );
  @override
  late final GeneratedColumn<String> errorSummary = GeneratedColumn<String>(
    'error_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    locationId,
    sourceId,
    startedAt,
    completedAt,
    status,
    recordsRead,
    recordsCreated,
    recordsUpdated,
    recordsSkipped,
    errorCount,
    errorSummary,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'integration_sync_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<IntegrationSyncRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('records_read')) {
      context.handle(
        _recordsReadMeta,
        recordsRead.isAcceptableOrUnknown(
          data['records_read']!,
          _recordsReadMeta,
        ),
      );
    }
    if (data.containsKey('records_created')) {
      context.handle(
        _recordsCreatedMeta,
        recordsCreated.isAcceptableOrUnknown(
          data['records_created']!,
          _recordsCreatedMeta,
        ),
      );
    }
    if (data.containsKey('records_updated')) {
      context.handle(
        _recordsUpdatedMeta,
        recordsUpdated.isAcceptableOrUnknown(
          data['records_updated']!,
          _recordsUpdatedMeta,
        ),
      );
    }
    if (data.containsKey('records_skipped')) {
      context.handle(
        _recordsSkippedMeta,
        recordsSkipped.isAcceptableOrUnknown(
          data['records_skipped']!,
          _recordsSkippedMeta,
        ),
      );
    }
    if (data.containsKey('error_count')) {
      context.handle(
        _errorCountMeta,
        errorCount.isAcceptableOrUnknown(data['error_count']!, _errorCountMeta),
      );
    }
    if (data.containsKey('error_summary')) {
      context.handle(
        _errorSummaryMeta,
        errorSummary.isAcceptableOrUnknown(
          data['error_summary']!,
          _errorSummaryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IntegrationSyncRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IntegrationSyncRun(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      recordsRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}records_read'],
      )!,
      recordsCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}records_created'],
      )!,
      recordsUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}records_updated'],
      )!,
      recordsSkipped: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}records_skipped'],
      )!,
      errorCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}error_count'],
      )!,
      errorSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_summary'],
      ),
    );
  }

  @override
  $IntegrationSyncRunsTable createAlias(String alias) {
    return $IntegrationSyncRunsTable(attachedDatabase, alias);
  }
}

class IntegrationSyncRun extends DataClass
    implements Insertable<IntegrationSyncRun> {
  final String id;
  final String organizationId;
  final String locationId;
  final String sourceId;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String status;
  final int recordsRead;
  final int recordsCreated;
  final int recordsUpdated;
  final int recordsSkipped;
  final int errorCount;
  final String? errorSummary;
  const IntegrationSyncRun({
    required this.id,
    required this.organizationId,
    required this.locationId,
    required this.sourceId,
    required this.startedAt,
    this.completedAt,
    required this.status,
    required this.recordsRead,
    required this.recordsCreated,
    required this.recordsUpdated,
    required this.recordsSkipped,
    required this.errorCount,
    this.errorSummary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['organization_id'] = Variable<String>(organizationId);
    map['location_id'] = Variable<String>(locationId);
    map['source_id'] = Variable<String>(sourceId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    map['records_read'] = Variable<int>(recordsRead);
    map['records_created'] = Variable<int>(recordsCreated);
    map['records_updated'] = Variable<int>(recordsUpdated);
    map['records_skipped'] = Variable<int>(recordsSkipped);
    map['error_count'] = Variable<int>(errorCount);
    if (!nullToAbsent || errorSummary != null) {
      map['error_summary'] = Variable<String>(errorSummary);
    }
    return map;
  }

  IntegrationSyncRunsCompanion toCompanion(bool nullToAbsent) {
    return IntegrationSyncRunsCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      locationId: Value(locationId),
      sourceId: Value(sourceId),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
      recordsRead: Value(recordsRead),
      recordsCreated: Value(recordsCreated),
      recordsUpdated: Value(recordsUpdated),
      recordsSkipped: Value(recordsSkipped),
      errorCount: Value(errorCount),
      errorSummary: errorSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(errorSummary),
    );
  }

  factory IntegrationSyncRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IntegrationSyncRun(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      locationId: serializer.fromJson<String>(json['locationId']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
      recordsRead: serializer.fromJson<int>(json['recordsRead']),
      recordsCreated: serializer.fromJson<int>(json['recordsCreated']),
      recordsUpdated: serializer.fromJson<int>(json['recordsUpdated']),
      recordsSkipped: serializer.fromJson<int>(json['recordsSkipped']),
      errorCount: serializer.fromJson<int>(json['errorCount']),
      errorSummary: serializer.fromJson<String?>(json['errorSummary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String>(organizationId),
      'locationId': serializer.toJson<String>(locationId),
      'sourceId': serializer.toJson<String>(sourceId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
      'recordsRead': serializer.toJson<int>(recordsRead),
      'recordsCreated': serializer.toJson<int>(recordsCreated),
      'recordsUpdated': serializer.toJson<int>(recordsUpdated),
      'recordsSkipped': serializer.toJson<int>(recordsSkipped),
      'errorCount': serializer.toJson<int>(errorCount),
      'errorSummary': serializer.toJson<String?>(errorSummary),
    };
  }

  IntegrationSyncRun copyWith({
    String? id,
    String? organizationId,
    String? locationId,
    String? sourceId,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? status,
    int? recordsRead,
    int? recordsCreated,
    int? recordsUpdated,
    int? recordsSkipped,
    int? errorCount,
    Value<String?> errorSummary = const Value.absent(),
  }) => IntegrationSyncRun(
    id: id ?? this.id,
    organizationId: organizationId ?? this.organizationId,
    locationId: locationId ?? this.locationId,
    sourceId: sourceId ?? this.sourceId,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    status: status ?? this.status,
    recordsRead: recordsRead ?? this.recordsRead,
    recordsCreated: recordsCreated ?? this.recordsCreated,
    recordsUpdated: recordsUpdated ?? this.recordsUpdated,
    recordsSkipped: recordsSkipped ?? this.recordsSkipped,
    errorCount: errorCount ?? this.errorCount,
    errorSummary: errorSummary.present ? errorSummary.value : this.errorSummary,
  );
  IntegrationSyncRun copyWithCompanion(IntegrationSyncRunsCompanion data) {
    return IntegrationSyncRun(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
      recordsRead: data.recordsRead.present
          ? data.recordsRead.value
          : this.recordsRead,
      recordsCreated: data.recordsCreated.present
          ? data.recordsCreated.value
          : this.recordsCreated,
      recordsUpdated: data.recordsUpdated.present
          ? data.recordsUpdated.value
          : this.recordsUpdated,
      recordsSkipped: data.recordsSkipped.present
          ? data.recordsSkipped.value
          : this.recordsSkipped,
      errorCount: data.errorCount.present
          ? data.errorCount.value
          : this.errorCount,
      errorSummary: data.errorSummary.present
          ? data.errorSummary.value
          : this.errorSummary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IntegrationSyncRun(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('sourceId: $sourceId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('recordsRead: $recordsRead, ')
          ..write('recordsCreated: $recordsCreated, ')
          ..write('recordsUpdated: $recordsUpdated, ')
          ..write('recordsSkipped: $recordsSkipped, ')
          ..write('errorCount: $errorCount, ')
          ..write('errorSummary: $errorSummary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    locationId,
    sourceId,
    startedAt,
    completedAt,
    status,
    recordsRead,
    recordsCreated,
    recordsUpdated,
    recordsSkipped,
    errorCount,
    errorSummary,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IntegrationSyncRun &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.locationId == this.locationId &&
          other.sourceId == this.sourceId &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status &&
          other.recordsRead == this.recordsRead &&
          other.recordsCreated == this.recordsCreated &&
          other.recordsUpdated == this.recordsUpdated &&
          other.recordsSkipped == this.recordsSkipped &&
          other.errorCount == this.errorCount &&
          other.errorSummary == this.errorSummary);
}

class IntegrationSyncRunsCompanion extends UpdateCompanion<IntegrationSyncRun> {
  final Value<String> id;
  final Value<String> organizationId;
  final Value<String> locationId;
  final Value<String> sourceId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  final Value<int> recordsRead;
  final Value<int> recordsCreated;
  final Value<int> recordsUpdated;
  final Value<int> recordsSkipped;
  final Value<int> errorCount;
  final Value<String?> errorSummary;
  final Value<int> rowid;
  const IntegrationSyncRunsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.locationId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.recordsRead = const Value.absent(),
    this.recordsCreated = const Value.absent(),
    this.recordsUpdated = const Value.absent(),
    this.recordsSkipped = const Value.absent(),
    this.errorCount = const Value.absent(),
    this.errorSummary = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IntegrationSyncRunsCompanion.insert({
    required String id,
    required String organizationId,
    required String locationId,
    required String sourceId,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required String status,
    this.recordsRead = const Value.absent(),
    this.recordsCreated = const Value.absent(),
    this.recordsUpdated = const Value.absent(),
    this.recordsSkipped = const Value.absent(),
    this.errorCount = const Value.absent(),
    this.errorSummary = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       organizationId = Value(organizationId),
       locationId = Value(locationId),
       sourceId = Value(sourceId),
       startedAt = Value(startedAt),
       status = Value(status);
  static Insertable<IntegrationSyncRun> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? locationId,
    Expression<String>? sourceId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
    Expression<int>? recordsRead,
    Expression<int>? recordsCreated,
    Expression<int>? recordsUpdated,
    Expression<int>? recordsSkipped,
    Expression<int>? errorCount,
    Expression<String>? errorSummary,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (locationId != null) 'location_id': locationId,
      if (sourceId != null) 'source_id': sourceId,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (recordsRead != null) 'records_read': recordsRead,
      if (recordsCreated != null) 'records_created': recordsCreated,
      if (recordsUpdated != null) 'records_updated': recordsUpdated,
      if (recordsSkipped != null) 'records_skipped': recordsSkipped,
      if (errorCount != null) 'error_count': errorCount,
      if (errorSummary != null) 'error_summary': errorSummary,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IntegrationSyncRunsCompanion copyWith({
    Value<String>? id,
    Value<String>? organizationId,
    Value<String>? locationId,
    Value<String>? sourceId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String>? status,
    Value<int>? recordsRead,
    Value<int>? recordsCreated,
    Value<int>? recordsUpdated,
    Value<int>? recordsSkipped,
    Value<int>? errorCount,
    Value<String?>? errorSummary,
    Value<int>? rowid,
  }) {
    return IntegrationSyncRunsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      locationId: locationId ?? this.locationId,
      sourceId: sourceId ?? this.sourceId,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      recordsRead: recordsRead ?? this.recordsRead,
      recordsCreated: recordsCreated ?? this.recordsCreated,
      recordsUpdated: recordsUpdated ?? this.recordsUpdated,
      recordsSkipped: recordsSkipped ?? this.recordsSkipped,
      errorCount: errorCount ?? this.errorCount,
      errorSummary: errorSummary ?? this.errorSummary,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (recordsRead.present) {
      map['records_read'] = Variable<int>(recordsRead.value);
    }
    if (recordsCreated.present) {
      map['records_created'] = Variable<int>(recordsCreated.value);
    }
    if (recordsUpdated.present) {
      map['records_updated'] = Variable<int>(recordsUpdated.value);
    }
    if (recordsSkipped.present) {
      map['records_skipped'] = Variable<int>(recordsSkipped.value);
    }
    if (errorCount.present) {
      map['error_count'] = Variable<int>(errorCount.value);
    }
    if (errorSummary.present) {
      map['error_summary'] = Variable<String>(errorSummary.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IntegrationSyncRunsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('locationId: $locationId, ')
          ..write('sourceId: $sourceId, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('recordsRead: $recordsRead, ')
          ..write('recordsCreated: $recordsCreated, ')
          ..write('recordsUpdated: $recordsUpdated, ')
          ..write('recordsSkipped: $recordsSkipped, ')
          ..write('errorCount: $errorCount, ')
          ..write('errorSummary: $errorSummary, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationPreferencesTable extends NotificationPreferences
    with TableInfo<$NotificationPreferencesTable, NotificationPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    organizationId,
    userId,
    key,
    enabled,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {organizationId, userId, key};
  @override
  NotificationPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPreference(
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationPreferencesTable createAlias(String alias) {
    return $NotificationPreferencesTable(attachedDatabase, alias);
  }
}

class NotificationPreference extends DataClass
    implements Insertable<NotificationPreference> {
  final String organizationId;
  final String userId;
  final String key;
  final bool enabled;
  final DateTime updatedAt;
  const NotificationPreference({
    required this.organizationId,
    required this.userId,
    required this.key,
    required this.enabled,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['organization_id'] = Variable<String>(organizationId);
    map['user_id'] = Variable<String>(userId);
    map['key'] = Variable<String>(key);
    map['enabled'] = Variable<bool>(enabled);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotificationPreferencesCompanion toCompanion(bool nullToAbsent) {
    return NotificationPreferencesCompanion(
      organizationId: Value(organizationId),
      userId: Value(userId),
      key: Value(key),
      enabled: Value(enabled),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPreference(
      organizationId: serializer.fromJson<String>(json['organizationId']),
      userId: serializer.fromJson<String>(json['userId']),
      key: serializer.fromJson<String>(json['key']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'organizationId': serializer.toJson<String>(organizationId),
      'userId': serializer.toJson<String>(userId),
      'key': serializer.toJson<String>(key),
      'enabled': serializer.toJson<bool>(enabled),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotificationPreference copyWith({
    String? organizationId,
    String? userId,
    String? key,
    bool? enabled,
    DateTime? updatedAt,
  }) => NotificationPreference(
    organizationId: organizationId ?? this.organizationId,
    userId: userId ?? this.userId,
    key: key ?? this.key,
    enabled: enabled ?? this.enabled,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationPreference copyWithCompanion(
    NotificationPreferencesCompanion data,
  ) {
    return NotificationPreference(
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      key: data.key.present ? data.key.value : this.key,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreference(')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('key: $key, ')
          ..write('enabled: $enabled, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(organizationId, userId, key, enabled, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPreference &&
          other.organizationId == this.organizationId &&
          other.userId == this.userId &&
          other.key == this.key &&
          other.enabled == this.enabled &&
          other.updatedAt == this.updatedAt);
}

class NotificationPreferencesCompanion
    extends UpdateCompanion<NotificationPreference> {
  final Value<String> organizationId;
  final Value<String> userId;
  final Value<String> key;
  final Value<bool> enabled;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NotificationPreferencesCompanion({
    this.organizationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.key = const Value.absent(),
    this.enabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationPreferencesCompanion.insert({
    required String organizationId,
    required String userId,
    required String key,
    this.enabled = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : organizationId = Value(organizationId),
       userId = Value(userId),
       key = Value(key),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationPreference> custom({
    Expression<String>? organizationId,
    Expression<String>? userId,
    Expression<String>? key,
    Expression<bool>? enabled,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (organizationId != null) 'organization_id': organizationId,
      if (userId != null) 'user_id': userId,
      if (key != null) 'key': key,
      if (enabled != null) 'enabled': enabled,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationPreferencesCompanion copyWith({
    Value<String>? organizationId,
    Value<String>? userId,
    Value<String>? key,
    Value<bool>? enabled,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationPreferencesCompanion(
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      key: key ?? this.key,
      enabled: enabled ?? this.enabled,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesCompanion(')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('key: $key, ')
          ..write('enabled: $enabled, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    userId,
    action,
    entityType,
    entityId,
    occurredAt,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      ),
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final String id;
  final String? organizationId;
  final String? userId;
  final String action;
  final String? entityType;
  final String? entityId;
  final DateTime occurredAt;
  final String? metadataJson;
  const AuditLog({
    required this.id,
    this.organizationId,
    this.userId,
    required this.action,
    this.entityType,
    this.entityId,
    required this.occurredAt,
    this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || organizationId != null) {
      map['organization_id'] = Variable<String>(organizationId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || entityType != null) {
      map['entity_type'] = Variable<String>(entityType);
    }
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      organizationId: organizationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organizationId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      action: Value(action),
      entityType: entityType == null && nullToAbsent
          ? const Value.absent()
          : Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      occurredAt: Value(occurredAt),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String?>(json['organizationId']),
      userId: serializer.fromJson<String?>(json['userId']),
      action: serializer.fromJson<String>(json['action']),
      entityType: serializer.fromJson<String?>(json['entityType']),
      entityId: serializer.fromJson<String?>(json['entityId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String?>(organizationId),
      'userId': serializer.toJson<String?>(userId),
      'action': serializer.toJson<String>(action),
      'entityType': serializer.toJson<String?>(entityType),
      'entityId': serializer.toJson<String?>(entityId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'metadataJson': serializer.toJson<String?>(metadataJson),
    };
  }

  AuditLog copyWith({
    String? id,
    Value<String?> organizationId = const Value.absent(),
    Value<String?> userId = const Value.absent(),
    String? action,
    Value<String?> entityType = const Value.absent(),
    Value<String?> entityId = const Value.absent(),
    DateTime? occurredAt,
    Value<String?> metadataJson = const Value.absent(),
  }) => AuditLog(
    id: id ?? this.id,
    organizationId: organizationId.present
        ? organizationId.value
        : this.organizationId,
    userId: userId.present ? userId.value : this.userId,
    action: action ?? this.action,
    entityType: entityType.present ? entityType.value : this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    occurredAt: occurredAt ?? this.occurredAt,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      action: data.action.present ? data.action.value : this.action,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    userId,
    action,
    entityType,
    entityId,
    occurredAt,
    metadataJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.userId == this.userId &&
          other.action == this.action &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.occurredAt == this.occurredAt &&
          other.metadataJson == this.metadataJson);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<String> id;
  final Value<String?> organizationId;
  final Value<String?> userId;
  final Value<String> action;
  final Value<String?> entityType;
  final Value<String?> entityId;
  final Value<DateTime> occurredAt;
  final Value<String?> metadataJson;
  final Value<int> rowid;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.action = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    required String id,
    this.organizationId = const Value.absent(),
    this.userId = const Value.absent(),
    required String action,
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    required DateTime occurredAt,
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       action = Value(action),
       occurredAt = Value(occurredAt);
  static Insertable<AuditLog> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<String>? userId,
    Expression<String>? action,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<DateTime>? occurredAt,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (userId != null) 'user_id': userId,
      if (action != null) 'action': action,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsCompanion copyWith({
    Value<String>? id,
    Value<String?>? organizationId,
    Value<String?>? userId,
    Value<String>? action,
    Value<String?>? entityType,
    Value<String?>? entityId,
    Value<DateTime>? occurredAt,
    Value<String?>? metadataJson,
    Value<int>? rowid,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      occurredAt: occurredAt ?? this.occurredAt,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('userId: $userId, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetaEntriesTable extends AppMetaEntries
    with TableInfo<$AppMetaEntriesTable, AppMetaEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppMetaEntriesTable createAlias(String alias) {
    return $AppMetaEntriesTable(attachedDatabase, alias);
  }
}

class AppMetaEntry extends DataClass implements Insertable<AppMetaEntry> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppMetaEntry({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppMetaEntriesCompanion toCompanion(bool nullToAbsent) {
    return AppMetaEntriesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppMetaEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaEntry(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppMetaEntry copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppMetaEntry(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppMetaEntry copyWithCompanion(AppMetaEntriesCompanion data) {
    return AppMetaEntry(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaEntry(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaEntry &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppMetaEntriesCompanion extends UpdateCompanion<AppMetaEntry> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppMetaEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaEntriesCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<AppMetaEntry> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaEntriesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppMetaEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SecurityStatesTable extends SecurityStates
    with TableInfo<$SecurityStatesTable, SecurityState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SecurityStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinSaltMeta = const VerificationMeta(
    'pinSalt',
  );
  @override
  late final GeneratedColumn<String> pinSalt = GeneratedColumn<String>(
    'pin_salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinAlgoMeta = const VerificationMeta(
    'pinAlgo',
  );
  @override
  late final GeneratedColumn<String> pinAlgo = GeneratedColumn<String>(
    'pin_algo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _failedAttemptsMeta = const VerificationMeta(
    'failedAttempts',
  );
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
    'failed_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lockoutUntilUtcMeta = const VerificationMeta(
    'lockoutUntilUtc',
  );
  @override
  late final GeneratedColumn<DateTime> lockoutUntilUtc =
      GeneratedColumn<DateTime>(
        'lockout_until_utc',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _biometricUnlockEnabledMeta =
      const VerificationMeta('biometricUnlockEnabled');
  @override
  late final GeneratedColumn<bool> biometricUnlockEnabled =
      GeneratedColumn<bool>(
        'biometric_unlock_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("biometric_unlock_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _autoLockSecondsMeta = const VerificationMeta(
    'autoLockSeconds',
  );
  @override
  late final GeneratedColumn<int> autoLockSeconds = GeneratedColumn<int>(
    'auto_lock_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(120),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pinHash,
    pinSalt,
    pinAlgo,
    failedAttempts,
    lockoutUntilUtc,
    biometricUnlockEnabled,
    autoLockSeconds,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'security_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<SecurityState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('pin_salt')) {
      context.handle(
        _pinSaltMeta,
        pinSalt.isAcceptableOrUnknown(data['pin_salt']!, _pinSaltMeta),
      );
    } else if (isInserting) {
      context.missing(_pinSaltMeta);
    }
    if (data.containsKey('pin_algo')) {
      context.handle(
        _pinAlgoMeta,
        pinAlgo.isAcceptableOrUnknown(data['pin_algo']!, _pinAlgoMeta),
      );
    } else if (isInserting) {
      context.missing(_pinAlgoMeta);
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
        _failedAttemptsMeta,
        failedAttempts.isAcceptableOrUnknown(
          data['failed_attempts']!,
          _failedAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('lockout_until_utc')) {
      context.handle(
        _lockoutUntilUtcMeta,
        lockoutUntilUtc.isAcceptableOrUnknown(
          data['lockout_until_utc']!,
          _lockoutUntilUtcMeta,
        ),
      );
    }
    if (data.containsKey('biometric_unlock_enabled')) {
      context.handle(
        _biometricUnlockEnabledMeta,
        biometricUnlockEnabled.isAcceptableOrUnknown(
          data['biometric_unlock_enabled']!,
          _biometricUnlockEnabledMeta,
        ),
      );
    }
    if (data.containsKey('auto_lock_seconds')) {
      context.handle(
        _autoLockSecondsMeta,
        autoLockSeconds.isAcceptableOrUnknown(
          data['auto_lock_seconds']!,
          _autoLockSecondsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SecurityState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SecurityState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      )!,
      pinSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_salt'],
      )!,
      pinAlgo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_algo'],
      )!,
      failedAttempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}failed_attempts'],
      )!,
      lockoutUntilUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}lockout_until_utc'],
      ),
      biometricUnlockEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}biometric_unlock_enabled'],
      )!,
      autoLockSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_lock_seconds'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SecurityStatesTable createAlias(String alias) {
    return $SecurityStatesTable(attachedDatabase, alias);
  }
}

class SecurityState extends DataClass implements Insertable<SecurityState> {
  final String id;
  final String pinHash;
  final String pinSalt;
  final String pinAlgo;
  final int failedAttempts;
  final DateTime? lockoutUntilUtc;
  final bool biometricUnlockEnabled;
  final int autoLockSeconds;
  final DateTime updatedAt;
  const SecurityState({
    required this.id,
    required this.pinHash,
    required this.pinSalt,
    required this.pinAlgo,
    required this.failedAttempts,
    this.lockoutUntilUtc,
    required this.biometricUnlockEnabled,
    required this.autoLockSeconds,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pin_hash'] = Variable<String>(pinHash);
    map['pin_salt'] = Variable<String>(pinSalt);
    map['pin_algo'] = Variable<String>(pinAlgo);
    map['failed_attempts'] = Variable<int>(failedAttempts);
    if (!nullToAbsent || lockoutUntilUtc != null) {
      map['lockout_until_utc'] = Variable<DateTime>(lockoutUntilUtc);
    }
    map['biometric_unlock_enabled'] = Variable<bool>(biometricUnlockEnabled);
    map['auto_lock_seconds'] = Variable<int>(autoLockSeconds);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SecurityStatesCompanion toCompanion(bool nullToAbsent) {
    return SecurityStatesCompanion(
      id: Value(id),
      pinHash: Value(pinHash),
      pinSalt: Value(pinSalt),
      pinAlgo: Value(pinAlgo),
      failedAttempts: Value(failedAttempts),
      lockoutUntilUtc: lockoutUntilUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(lockoutUntilUtc),
      biometricUnlockEnabled: Value(biometricUnlockEnabled),
      autoLockSeconds: Value(autoLockSeconds),
      updatedAt: Value(updatedAt),
    );
  }

  factory SecurityState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SecurityState(
      id: serializer.fromJson<String>(json['id']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      pinSalt: serializer.fromJson<String>(json['pinSalt']),
      pinAlgo: serializer.fromJson<String>(json['pinAlgo']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
      lockoutUntilUtc: serializer.fromJson<DateTime?>(json['lockoutUntilUtc']),
      biometricUnlockEnabled: serializer.fromJson<bool>(
        json['biometricUnlockEnabled'],
      ),
      autoLockSeconds: serializer.fromJson<int>(json['autoLockSeconds']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pinHash': serializer.toJson<String>(pinHash),
      'pinSalt': serializer.toJson<String>(pinSalt),
      'pinAlgo': serializer.toJson<String>(pinAlgo),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
      'lockoutUntilUtc': serializer.toJson<DateTime?>(lockoutUntilUtc),
      'biometricUnlockEnabled': serializer.toJson<bool>(biometricUnlockEnabled),
      'autoLockSeconds': serializer.toJson<int>(autoLockSeconds),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SecurityState copyWith({
    String? id,
    String? pinHash,
    String? pinSalt,
    String? pinAlgo,
    int? failedAttempts,
    Value<DateTime?> lockoutUntilUtc = const Value.absent(),
    bool? biometricUnlockEnabled,
    int? autoLockSeconds,
    DateTime? updatedAt,
  }) => SecurityState(
    id: id ?? this.id,
    pinHash: pinHash ?? this.pinHash,
    pinSalt: pinSalt ?? this.pinSalt,
    pinAlgo: pinAlgo ?? this.pinAlgo,
    failedAttempts: failedAttempts ?? this.failedAttempts,
    lockoutUntilUtc: lockoutUntilUtc.present
        ? lockoutUntilUtc.value
        : this.lockoutUntilUtc,
    biometricUnlockEnabled:
        biometricUnlockEnabled ?? this.biometricUnlockEnabled,
    autoLockSeconds: autoLockSeconds ?? this.autoLockSeconds,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SecurityState copyWithCompanion(SecurityStatesCompanion data) {
    return SecurityState(
      id: data.id.present ? data.id.value : this.id,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      pinSalt: data.pinSalt.present ? data.pinSalt.value : this.pinSalt,
      pinAlgo: data.pinAlgo.present ? data.pinAlgo.value : this.pinAlgo,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
      lockoutUntilUtc: data.lockoutUntilUtc.present
          ? data.lockoutUntilUtc.value
          : this.lockoutUntilUtc,
      biometricUnlockEnabled: data.biometricUnlockEnabled.present
          ? data.biometricUnlockEnabled.value
          : this.biometricUnlockEnabled,
      autoLockSeconds: data.autoLockSeconds.present
          ? data.autoLockSeconds.value
          : this.autoLockSeconds,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SecurityState(')
          ..write('id: $id, ')
          ..write('pinHash: $pinHash, ')
          ..write('pinSalt: $pinSalt, ')
          ..write('pinAlgo: $pinAlgo, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('lockoutUntilUtc: $lockoutUntilUtc, ')
          ..write('biometricUnlockEnabled: $biometricUnlockEnabled, ')
          ..write('autoLockSeconds: $autoLockSeconds, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pinHash,
    pinSalt,
    pinAlgo,
    failedAttempts,
    lockoutUntilUtc,
    biometricUnlockEnabled,
    autoLockSeconds,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SecurityState &&
          other.id == this.id &&
          other.pinHash == this.pinHash &&
          other.pinSalt == this.pinSalt &&
          other.pinAlgo == this.pinAlgo &&
          other.failedAttempts == this.failedAttempts &&
          other.lockoutUntilUtc == this.lockoutUntilUtc &&
          other.biometricUnlockEnabled == this.biometricUnlockEnabled &&
          other.autoLockSeconds == this.autoLockSeconds &&
          other.updatedAt == this.updatedAt);
}

class SecurityStatesCompanion extends UpdateCompanion<SecurityState> {
  final Value<String> id;
  final Value<String> pinHash;
  final Value<String> pinSalt;
  final Value<String> pinAlgo;
  final Value<int> failedAttempts;
  final Value<DateTime?> lockoutUntilUtc;
  final Value<bool> biometricUnlockEnabled;
  final Value<int> autoLockSeconds;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SecurityStatesCompanion({
    this.id = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.pinSalt = const Value.absent(),
    this.pinAlgo = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.lockoutUntilUtc = const Value.absent(),
    this.biometricUnlockEnabled = const Value.absent(),
    this.autoLockSeconds = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SecurityStatesCompanion.insert({
    required String id,
    required String pinHash,
    required String pinSalt,
    required String pinAlgo,
    this.failedAttempts = const Value.absent(),
    this.lockoutUntilUtc = const Value.absent(),
    this.biometricUnlockEnabled = const Value.absent(),
    this.autoLockSeconds = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pinHash = Value(pinHash),
       pinSalt = Value(pinSalt),
       pinAlgo = Value(pinAlgo),
       updatedAt = Value(updatedAt);
  static Insertable<SecurityState> custom({
    Expression<String>? id,
    Expression<String>? pinHash,
    Expression<String>? pinSalt,
    Expression<String>? pinAlgo,
    Expression<int>? failedAttempts,
    Expression<DateTime>? lockoutUntilUtc,
    Expression<bool>? biometricUnlockEnabled,
    Expression<int>? autoLockSeconds,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pinHash != null) 'pin_hash': pinHash,
      if (pinSalt != null) 'pin_salt': pinSalt,
      if (pinAlgo != null) 'pin_algo': pinAlgo,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (lockoutUntilUtc != null) 'lockout_until_utc': lockoutUntilUtc,
      if (biometricUnlockEnabled != null)
        'biometric_unlock_enabled': biometricUnlockEnabled,
      if (autoLockSeconds != null) 'auto_lock_seconds': autoLockSeconds,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SecurityStatesCompanion copyWith({
    Value<String>? id,
    Value<String>? pinHash,
    Value<String>? pinSalt,
    Value<String>? pinAlgo,
    Value<int>? failedAttempts,
    Value<DateTime?>? lockoutUntilUtc,
    Value<bool>? biometricUnlockEnabled,
    Value<int>? autoLockSeconds,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SecurityStatesCompanion(
      id: id ?? this.id,
      pinHash: pinHash ?? this.pinHash,
      pinSalt: pinSalt ?? this.pinSalt,
      pinAlgo: pinAlgo ?? this.pinAlgo,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      lockoutUntilUtc: lockoutUntilUtc ?? this.lockoutUntilUtc,
      biometricUnlockEnabled:
          biometricUnlockEnabled ?? this.biometricUnlockEnabled,
      autoLockSeconds: autoLockSeconds ?? this.autoLockSeconds,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (pinSalt.present) {
      map['pin_salt'] = Variable<String>(pinSalt.value);
    }
    if (pinAlgo.present) {
      map['pin_algo'] = Variable<String>(pinAlgo.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (lockoutUntilUtc.present) {
      map['lockout_until_utc'] = Variable<DateTime>(lockoutUntilUtc.value);
    }
    if (biometricUnlockEnabled.present) {
      map['biometric_unlock_enabled'] = Variable<bool>(
        biometricUnlockEnabled.value,
      );
    }
    if (autoLockSeconds.present) {
      map['auto_lock_seconds'] = Variable<int>(autoLockSeconds.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SecurityStatesCompanion(')
          ..write('id: $id, ')
          ..write('pinHash: $pinHash, ')
          ..write('pinSalt: $pinSalt, ')
          ..write('pinAlgo: $pinAlgo, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('lockoutUntilUtc: $lockoutUntilUtc, ')
          ..write('biometricUnlockEnabled: $biometricUnlockEnabled, ')
          ..write('autoLockSeconds: $autoLockSeconds, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupRunsTable extends BackupRuns
    with TableInfo<$BackupRunsTable, BackupRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formatVersionMeta = const VerificationMeta(
    'formatVersion',
  );
  @override
  late final GeneratedColumn<String> formatVersion = GeneratedColumn<String>(
    'format_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checksumMeta = const VerificationMeta(
    'checksum',
  );
  @override
  late final GeneratedColumn<String> checksum = GeneratedColumn<String>(
    'checksum',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appVersionMeta = const VerificationMeta(
    'appVersion',
  );
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
    'app_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorCodeMeta = const VerificationMeta(
    'errorCode',
  );
  @override
  late final GeneratedColumn<String> errorCode = GeneratedColumn<String>(
    'error_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorSummaryMeta = const VerificationMeta(
    'errorSummary',
  );
  @override
  late final GeneratedColumn<String> errorSummary = GeneratedColumn<String>(
    'error_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdByUserIdMeta = const VerificationMeta(
    'createdByUserId',
  );
  @override
  late final GeneratedColumn<String> createdByUserId = GeneratedColumn<String>(
    'created_by_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    organizationId,
    createdAt,
    completedAt,
    direction,
    status,
    fileName,
    formatVersion,
    checksum,
    appVersion,
    errorCode,
    errorSummary,
    createdByUserId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    }
    if (data.containsKey('format_version')) {
      context.handle(
        _formatVersionMeta,
        formatVersion.isAcceptableOrUnknown(
          data['format_version']!,
          _formatVersionMeta,
        ),
      );
    }
    if (data.containsKey('checksum')) {
      context.handle(
        _checksumMeta,
        checksum.isAcceptableOrUnknown(data['checksum']!, _checksumMeta),
      );
    }
    if (data.containsKey('app_version')) {
      context.handle(
        _appVersionMeta,
        appVersion.isAcceptableOrUnknown(data['app_version']!, _appVersionMeta),
      );
    }
    if (data.containsKey('error_code')) {
      context.handle(
        _errorCodeMeta,
        errorCode.isAcceptableOrUnknown(data['error_code']!, _errorCodeMeta),
      );
    }
    if (data.containsKey('error_summary')) {
      context.handle(
        _errorSummaryMeta,
        errorSummary.isAcceptableOrUnknown(
          data['error_summary']!,
          _errorSummaryMeta,
        ),
      );
    }
    if (data.containsKey('created_by_user_id')) {
      context.handle(
        _createdByUserIdMeta,
        createdByUserId.isAcceptableOrUnknown(
          data['created_by_user_id']!,
          _createdByUserIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupRun(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      ),
      formatVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format_version'],
      ),
      checksum: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checksum'],
      ),
      appVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_version'],
      ),
      errorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_code'],
      ),
      errorSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_summary'],
      ),
      createdByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by_user_id'],
      ),
    );
  }

  @override
  $BackupRunsTable createAlias(String alias) {
    return $BackupRunsTable(attachedDatabase, alias);
  }
}

class BackupRun extends DataClass implements Insertable<BackupRun> {
  final String id;
  final String? organizationId;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String direction;
  final String status;
  final String? fileName;
  final String? formatVersion;
  final String? checksum;
  final String? appVersion;
  final String? errorCode;
  final String? errorSummary;
  final String? createdByUserId;
  const BackupRun({
    required this.id,
    this.organizationId,
    required this.createdAt,
    this.completedAt,
    required this.direction,
    required this.status,
    this.fileName,
    this.formatVersion,
    this.checksum,
    this.appVersion,
    this.errorCode,
    this.errorSummary,
    this.createdByUserId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || organizationId != null) {
      map['organization_id'] = Variable<String>(organizationId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['direction'] = Variable<String>(direction);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    if (!nullToAbsent || formatVersion != null) {
      map['format_version'] = Variable<String>(formatVersion);
    }
    if (!nullToAbsent || checksum != null) {
      map['checksum'] = Variable<String>(checksum);
    }
    if (!nullToAbsent || appVersion != null) {
      map['app_version'] = Variable<String>(appVersion);
    }
    if (!nullToAbsent || errorCode != null) {
      map['error_code'] = Variable<String>(errorCode);
    }
    if (!nullToAbsent || errorSummary != null) {
      map['error_summary'] = Variable<String>(errorSummary);
    }
    if (!nullToAbsent || createdByUserId != null) {
      map['created_by_user_id'] = Variable<String>(createdByUserId);
    }
    return map;
  }

  BackupRunsCompanion toCompanion(bool nullToAbsent) {
    return BackupRunsCompanion(
      id: Value(id),
      organizationId: organizationId == null && nullToAbsent
          ? const Value.absent()
          : Value(organizationId),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      direction: Value(direction),
      status: Value(status),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
      formatVersion: formatVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(formatVersion),
      checksum: checksum == null && nullToAbsent
          ? const Value.absent()
          : Value(checksum),
      appVersion: appVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(appVersion),
      errorCode: errorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(errorCode),
      errorSummary: errorSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(errorSummary),
      createdByUserId: createdByUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(createdByUserId),
    );
  }

  factory BackupRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupRun(
      id: serializer.fromJson<String>(json['id']),
      organizationId: serializer.fromJson<String?>(json['organizationId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      direction: serializer.fromJson<String>(json['direction']),
      status: serializer.fromJson<String>(json['status']),
      fileName: serializer.fromJson<String?>(json['fileName']),
      formatVersion: serializer.fromJson<String?>(json['formatVersion']),
      checksum: serializer.fromJson<String?>(json['checksum']),
      appVersion: serializer.fromJson<String?>(json['appVersion']),
      errorCode: serializer.fromJson<String?>(json['errorCode']),
      errorSummary: serializer.fromJson<String?>(json['errorSummary']),
      createdByUserId: serializer.fromJson<String?>(json['createdByUserId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'organizationId': serializer.toJson<String?>(organizationId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'direction': serializer.toJson<String>(direction),
      'status': serializer.toJson<String>(status),
      'fileName': serializer.toJson<String?>(fileName),
      'formatVersion': serializer.toJson<String?>(formatVersion),
      'checksum': serializer.toJson<String?>(checksum),
      'appVersion': serializer.toJson<String?>(appVersion),
      'errorCode': serializer.toJson<String?>(errorCode),
      'errorSummary': serializer.toJson<String?>(errorSummary),
      'createdByUserId': serializer.toJson<String?>(createdByUserId),
    };
  }

  BackupRun copyWith({
    String? id,
    Value<String?> organizationId = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? direction,
    String? status,
    Value<String?> fileName = const Value.absent(),
    Value<String?> formatVersion = const Value.absent(),
    Value<String?> checksum = const Value.absent(),
    Value<String?> appVersion = const Value.absent(),
    Value<String?> errorCode = const Value.absent(),
    Value<String?> errorSummary = const Value.absent(),
    Value<String?> createdByUserId = const Value.absent(),
  }) => BackupRun(
    id: id ?? this.id,
    organizationId: organizationId.present
        ? organizationId.value
        : this.organizationId,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    direction: direction ?? this.direction,
    status: status ?? this.status,
    fileName: fileName.present ? fileName.value : this.fileName,
    formatVersion: formatVersion.present
        ? formatVersion.value
        : this.formatVersion,
    checksum: checksum.present ? checksum.value : this.checksum,
    appVersion: appVersion.present ? appVersion.value : this.appVersion,
    errorCode: errorCode.present ? errorCode.value : this.errorCode,
    errorSummary: errorSummary.present ? errorSummary.value : this.errorSummary,
    createdByUserId: createdByUserId.present
        ? createdByUserId.value
        : this.createdByUserId,
  );
  BackupRun copyWithCompanion(BackupRunsCompanion data) {
    return BackupRun(
      id: data.id.present ? data.id.value : this.id,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      direction: data.direction.present ? data.direction.value : this.direction,
      status: data.status.present ? data.status.value : this.status,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      formatVersion: data.formatVersion.present
          ? data.formatVersion.value
          : this.formatVersion,
      checksum: data.checksum.present ? data.checksum.value : this.checksum,
      appVersion: data.appVersion.present
          ? data.appVersion.value
          : this.appVersion,
      errorCode: data.errorCode.present ? data.errorCode.value : this.errorCode,
      errorSummary: data.errorSummary.present
          ? data.errorSummary.value
          : this.errorSummary,
      createdByUserId: data.createdByUserId.present
          ? data.createdByUserId.value
          : this.createdByUserId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupRun(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('fileName: $fileName, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('checksum: $checksum, ')
          ..write('appVersion: $appVersion, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorSummary: $errorSummary, ')
          ..write('createdByUserId: $createdByUserId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    organizationId,
    createdAt,
    completedAt,
    direction,
    status,
    fileName,
    formatVersion,
    checksum,
    appVersion,
    errorCode,
    errorSummary,
    createdByUserId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupRun &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt &&
          other.direction == this.direction &&
          other.status == this.status &&
          other.fileName == this.fileName &&
          other.formatVersion == this.formatVersion &&
          other.checksum == this.checksum &&
          other.appVersion == this.appVersion &&
          other.errorCode == this.errorCode &&
          other.errorSummary == this.errorSummary &&
          other.createdByUserId == this.createdByUserId);
}

class BackupRunsCompanion extends UpdateCompanion<BackupRun> {
  final Value<String> id;
  final Value<String?> organizationId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<String> direction;
  final Value<String> status;
  final Value<String?> fileName;
  final Value<String?> formatVersion;
  final Value<String?> checksum;
  final Value<String?> appVersion;
  final Value<String?> errorCode;
  final Value<String?> errorSummary;
  final Value<String?> createdByUserId;
  final Value<int> rowid;
  const BackupRunsCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.direction = const Value.absent(),
    this.status = const Value.absent(),
    this.fileName = const Value.absent(),
    this.formatVersion = const Value.absent(),
    this.checksum = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.errorSummary = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupRunsCompanion.insert({
    required String id,
    this.organizationId = const Value.absent(),
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
    required String direction,
    required String status,
    this.fileName = const Value.absent(),
    this.formatVersion = const Value.absent(),
    this.checksum = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.errorCode = const Value.absent(),
    this.errorSummary = const Value.absent(),
    this.createdByUserId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       direction = Value(direction),
       status = Value(status);
  static Insertable<BackupRun> custom({
    Expression<String>? id,
    Expression<String>? organizationId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<String>? direction,
    Expression<String>? status,
    Expression<String>? fileName,
    Expression<String>? formatVersion,
    Expression<String>? checksum,
    Expression<String>? appVersion,
    Expression<String>? errorCode,
    Expression<String>? errorSummary,
    Expression<String>? createdByUserId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (direction != null) 'direction': direction,
      if (status != null) 'status': status,
      if (fileName != null) 'file_name': fileName,
      if (formatVersion != null) 'format_version': formatVersion,
      if (checksum != null) 'checksum': checksum,
      if (appVersion != null) 'app_version': appVersion,
      if (errorCode != null) 'error_code': errorCode,
      if (errorSummary != null) 'error_summary': errorSummary,
      if (createdByUserId != null) 'created_by_user_id': createdByUserId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupRunsCompanion copyWith({
    Value<String>? id,
    Value<String?>? organizationId,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
    Value<String>? direction,
    Value<String>? status,
    Value<String?>? fileName,
    Value<String?>? formatVersion,
    Value<String?>? checksum,
    Value<String?>? appVersion,
    Value<String?>? errorCode,
    Value<String?>? errorSummary,
    Value<String?>? createdByUserId,
    Value<int>? rowid,
  }) {
    return BackupRunsCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      direction: direction ?? this.direction,
      status: status ?? this.status,
      fileName: fileName ?? this.fileName,
      formatVersion: formatVersion ?? this.formatVersion,
      checksum: checksum ?? this.checksum,
      appVersion: appVersion ?? this.appVersion,
      errorCode: errorCode ?? this.errorCode,
      errorSummary: errorSummary ?? this.errorSummary,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (formatVersion.present) {
      map['format_version'] = Variable<String>(formatVersion.value);
    }
    if (checksum.present) {
      map['checksum'] = Variable<String>(checksum.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (errorCode.present) {
      map['error_code'] = Variable<String>(errorCode.value);
    }
    if (errorSummary.present) {
      map['error_summary'] = Variable<String>(errorSummary.value);
    }
    if (createdByUserId.present) {
      map['created_by_user_id'] = Variable<String>(createdByUserId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupRunsCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('fileName: $fileName, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('checksum: $checksum, ')
          ..write('appVersion: $appVersion, ')
          ..write('errorCode: $errorCode, ')
          ..write('errorSummary: $errorSummary, ')
          ..write('createdByUserId: $createdByUserId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupReminderSettingsTable extends BackupReminderSettings
    with TableInfo<$BackupReminderSettingsTable, BackupReminderSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupReminderSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _organizationIdMeta = const VerificationMeta(
    'organizationId',
  );
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
    'organization_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastRemindedAtMeta = const VerificationMeta(
    'lastRemindedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastRemindedAt =
      GeneratedColumn<DateTime>(
        'last_reminded_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    organizationId,
    intervalDays,
    enabled,
    lastRemindedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_reminder_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupReminderSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('organization_id')) {
      context.handle(
        _organizationIdMeta,
        organizationId.isAcceptableOrUnknown(
          data['organization_id']!,
          _organizationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('last_reminded_at')) {
      context.handle(
        _lastRemindedAtMeta,
        lastRemindedAt.isAcceptableOrUnknown(
          data['last_reminded_at']!,
          _lastRemindedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {organizationId};
  @override
  BackupReminderSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupReminderSetting(
      organizationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_id'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      lastRemindedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reminded_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BackupReminderSettingsTable createAlias(String alias) {
    return $BackupReminderSettingsTable(attachedDatabase, alias);
  }
}

class BackupReminderSetting extends DataClass
    implements Insertable<BackupReminderSetting> {
  final String organizationId;
  final int intervalDays;
  final bool enabled;
  final DateTime? lastRemindedAt;
  final DateTime updatedAt;
  const BackupReminderSetting({
    required this.organizationId,
    required this.intervalDays,
    required this.enabled,
    this.lastRemindedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['organization_id'] = Variable<String>(organizationId);
    map['interval_days'] = Variable<int>(intervalDays);
    map['enabled'] = Variable<bool>(enabled);
    if (!nullToAbsent || lastRemindedAt != null) {
      map['last_reminded_at'] = Variable<DateTime>(lastRemindedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BackupReminderSettingsCompanion toCompanion(bool nullToAbsent) {
    return BackupReminderSettingsCompanion(
      organizationId: Value(organizationId),
      intervalDays: Value(intervalDays),
      enabled: Value(enabled),
      lastRemindedAt: lastRemindedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRemindedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BackupReminderSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupReminderSetting(
      organizationId: serializer.fromJson<String>(json['organizationId']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      lastRemindedAt: serializer.fromJson<DateTime?>(json['lastRemindedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'organizationId': serializer.toJson<String>(organizationId),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'enabled': serializer.toJson<bool>(enabled),
      'lastRemindedAt': serializer.toJson<DateTime?>(lastRemindedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BackupReminderSetting copyWith({
    String? organizationId,
    int? intervalDays,
    bool? enabled,
    Value<DateTime?> lastRemindedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => BackupReminderSetting(
    organizationId: organizationId ?? this.organizationId,
    intervalDays: intervalDays ?? this.intervalDays,
    enabled: enabled ?? this.enabled,
    lastRemindedAt: lastRemindedAt.present
        ? lastRemindedAt.value
        : this.lastRemindedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BackupReminderSetting copyWithCompanion(
    BackupReminderSettingsCompanion data,
  ) {
    return BackupReminderSetting(
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      lastRemindedAt: data.lastRemindedAt.present
          ? data.lastRemindedAt.value
          : this.lastRemindedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupReminderSetting(')
          ..write('organizationId: $organizationId, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('enabled: $enabled, ')
          ..write('lastRemindedAt: $lastRemindedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    organizationId,
    intervalDays,
    enabled,
    lastRemindedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupReminderSetting &&
          other.organizationId == this.organizationId &&
          other.intervalDays == this.intervalDays &&
          other.enabled == this.enabled &&
          other.lastRemindedAt == this.lastRemindedAt &&
          other.updatedAt == this.updatedAt);
}

class BackupReminderSettingsCompanion
    extends UpdateCompanion<BackupReminderSetting> {
  final Value<String> organizationId;
  final Value<int> intervalDays;
  final Value<bool> enabled;
  final Value<DateTime?> lastRemindedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BackupReminderSettingsCompanion({
    this.organizationId = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.enabled = const Value.absent(),
    this.lastRemindedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupReminderSettingsCompanion.insert({
    required String organizationId,
    this.intervalDays = const Value.absent(),
    this.enabled = const Value.absent(),
    this.lastRemindedAt = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : organizationId = Value(organizationId),
       updatedAt = Value(updatedAt);
  static Insertable<BackupReminderSetting> custom({
    Expression<String>? organizationId,
    Expression<int>? intervalDays,
    Expression<bool>? enabled,
    Expression<DateTime>? lastRemindedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (organizationId != null) 'organization_id': organizationId,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (enabled != null) 'enabled': enabled,
      if (lastRemindedAt != null) 'last_reminded_at': lastRemindedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupReminderSettingsCompanion copyWith({
    Value<String>? organizationId,
    Value<int>? intervalDays,
    Value<bool>? enabled,
    Value<DateTime?>? lastRemindedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BackupReminderSettingsCompanion(
      organizationId: organizationId ?? this.organizationId,
      intervalDays: intervalDays ?? this.intervalDays,
      enabled: enabled ?? this.enabled,
      lastRemindedAt: lastRemindedAt ?? this.lastRemindedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (lastRemindedAt.present) {
      map['last_reminded_at'] = Variable<DateTime>(lastRemindedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupReminderSettingsCompanion(')
          ..write('organizationId: $organizationId, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('enabled: $enabled, ')
          ..write('lastRemindedAt: $lastRemindedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationSettingsTable extends LocationSettings
    with TableInfo<$LocationSettingsTable, LocationSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inactivityMonitorDaysMeta =
      const VerificationMeta('inactivityMonitorDays');
  @override
  late final GeneratedColumn<int> inactivityMonitorDays = GeneratedColumn<int>(
    'inactivity_monitor_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _inactivityFollowUpDaysMeta =
      const VerificationMeta('inactivityFollowUpDays');
  @override
  late final GeneratedColumn<int> inactivityFollowUpDays = GeneratedColumn<int>(
    'inactivity_follow_up_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _inactivityHighRiskDaysMeta =
      const VerificationMeta('inactivityHighRiskDays');
  @override
  late final GeneratedColumn<int> inactivityHighRiskDays = GeneratedColumn<int>(
    'inactivity_high_risk_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(21),
  );
  static const VerificationMeta _inactivityCriticalDaysMeta =
      const VerificationMeta('inactivityCriticalDays');
  @override
  late final GeneratedColumn<int> inactivityCriticalDays = GeneratedColumn<int>(
    'inactivity_critical_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _staleImportHoursMeta = const VerificationMeta(
    'staleImportHours',
  );
  @override
  late final GeneratedColumn<int> staleImportHours = GeneratedColumn<int>(
    'stale_import_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(24),
  );
  static const VerificationMeta _gymPhoneMeta = const VerificationMeta(
    'gymPhone',
  );
  @override
  late final GeneratedColumn<String> gymPhone = GeneratedColumn<String>(
    'gym_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _peakHighAttendanceMeta =
      const VerificationMeta('peakHighAttendance');
  @override
  late final GeneratedColumn<int> peakHighAttendance = GeneratedColumn<int>(
    'peak_high_attendance',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _closureDatesJsonMeta = const VerificationMeta(
    'closureDatesJson',
  );
  @override
  late final GeneratedColumn<String> closureDatesJson = GeneratedColumn<String>(
    'closure_dates_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _riskWeightsJsonMeta = const VerificationMeta(
    'riskWeightsJson',
  );
  @override
  late final GeneratedColumn<String> riskWeightsJson = GeneratedColumn<String>(
    'risk_weights_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trialDefaultDaysMeta = const VerificationMeta(
    'trialDefaultDays',
  );
  @override
  late final GeneratedColumn<int> trialDefaultDays = GeneratedColumn<int>(
    'trial_default_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    locationId,
    inactivityMonitorDays,
    inactivityFollowUpDays,
    inactivityHighRiskDays,
    inactivityCriticalDays,
    staleImportHours,
    gymPhone,
    peakHighAttendance,
    closureDatesJson,
    riskWeightsJson,
    trialDefaultDays,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('inactivity_monitor_days')) {
      context.handle(
        _inactivityMonitorDaysMeta,
        inactivityMonitorDays.isAcceptableOrUnknown(
          data['inactivity_monitor_days']!,
          _inactivityMonitorDaysMeta,
        ),
      );
    }
    if (data.containsKey('inactivity_follow_up_days')) {
      context.handle(
        _inactivityFollowUpDaysMeta,
        inactivityFollowUpDays.isAcceptableOrUnknown(
          data['inactivity_follow_up_days']!,
          _inactivityFollowUpDaysMeta,
        ),
      );
    }
    if (data.containsKey('inactivity_high_risk_days')) {
      context.handle(
        _inactivityHighRiskDaysMeta,
        inactivityHighRiskDays.isAcceptableOrUnknown(
          data['inactivity_high_risk_days']!,
          _inactivityHighRiskDaysMeta,
        ),
      );
    }
    if (data.containsKey('inactivity_critical_days')) {
      context.handle(
        _inactivityCriticalDaysMeta,
        inactivityCriticalDays.isAcceptableOrUnknown(
          data['inactivity_critical_days']!,
          _inactivityCriticalDaysMeta,
        ),
      );
    }
    if (data.containsKey('stale_import_hours')) {
      context.handle(
        _staleImportHoursMeta,
        staleImportHours.isAcceptableOrUnknown(
          data['stale_import_hours']!,
          _staleImportHoursMeta,
        ),
      );
    }
    if (data.containsKey('gym_phone')) {
      context.handle(
        _gymPhoneMeta,
        gymPhone.isAcceptableOrUnknown(data['gym_phone']!, _gymPhoneMeta),
      );
    }
    if (data.containsKey('peak_high_attendance')) {
      context.handle(
        _peakHighAttendanceMeta,
        peakHighAttendance.isAcceptableOrUnknown(
          data['peak_high_attendance']!,
          _peakHighAttendanceMeta,
        ),
      );
    }
    if (data.containsKey('closure_dates_json')) {
      context.handle(
        _closureDatesJsonMeta,
        closureDatesJson.isAcceptableOrUnknown(
          data['closure_dates_json']!,
          _closureDatesJsonMeta,
        ),
      );
    }
    if (data.containsKey('risk_weights_json')) {
      context.handle(
        _riskWeightsJsonMeta,
        riskWeightsJson.isAcceptableOrUnknown(
          data['risk_weights_json']!,
          _riskWeightsJsonMeta,
        ),
      );
    }
    if (data.containsKey('trial_default_days')) {
      context.handle(
        _trialDefaultDaysMeta,
        trialDefaultDays.isAcceptableOrUnknown(
          data['trial_default_days']!,
          _trialDefaultDaysMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {locationId};
  @override
  LocationSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationSetting(
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      inactivityMonitorDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inactivity_monitor_days'],
      )!,
      inactivityFollowUpDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inactivity_follow_up_days'],
      )!,
      inactivityHighRiskDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inactivity_high_risk_days'],
      )!,
      inactivityCriticalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inactivity_critical_days'],
      )!,
      staleImportHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stale_import_hours'],
      )!,
      gymPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gym_phone'],
      ),
      peakHighAttendance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}peak_high_attendance'],
      ),
      closureDatesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}closure_dates_json'],
      ),
      riskWeightsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_weights_json'],
      ),
      trialDefaultDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trial_default_days'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocationSettingsTable createAlias(String alias) {
    return $LocationSettingsTable(attachedDatabase, alias);
  }
}

class LocationSetting extends DataClass implements Insertable<LocationSetting> {
  final String locationId;
  final int inactivityMonitorDays;
  final int inactivityFollowUpDays;
  final int inactivityHighRiskDays;
  final int inactivityCriticalDays;
  final int staleImportHours;
  final String? gymPhone;
  final int? peakHighAttendance;
  final String? closureDatesJson;
  final String? riskWeightsJson;
  final int trialDefaultDays;
  final DateTime updatedAt;
  const LocationSetting({
    required this.locationId,
    required this.inactivityMonitorDays,
    required this.inactivityFollowUpDays,
    required this.inactivityHighRiskDays,
    required this.inactivityCriticalDays,
    required this.staleImportHours,
    this.gymPhone,
    this.peakHighAttendance,
    this.closureDatesJson,
    this.riskWeightsJson,
    required this.trialDefaultDays,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['location_id'] = Variable<String>(locationId);
    map['inactivity_monitor_days'] = Variable<int>(inactivityMonitorDays);
    map['inactivity_follow_up_days'] = Variable<int>(inactivityFollowUpDays);
    map['inactivity_high_risk_days'] = Variable<int>(inactivityHighRiskDays);
    map['inactivity_critical_days'] = Variable<int>(inactivityCriticalDays);
    map['stale_import_hours'] = Variable<int>(staleImportHours);
    if (!nullToAbsent || gymPhone != null) {
      map['gym_phone'] = Variable<String>(gymPhone);
    }
    if (!nullToAbsent || peakHighAttendance != null) {
      map['peak_high_attendance'] = Variable<int>(peakHighAttendance);
    }
    if (!nullToAbsent || closureDatesJson != null) {
      map['closure_dates_json'] = Variable<String>(closureDatesJson);
    }
    if (!nullToAbsent || riskWeightsJson != null) {
      map['risk_weights_json'] = Variable<String>(riskWeightsJson);
    }
    map['trial_default_days'] = Variable<int>(trialDefaultDays);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocationSettingsCompanion toCompanion(bool nullToAbsent) {
    return LocationSettingsCompanion(
      locationId: Value(locationId),
      inactivityMonitorDays: Value(inactivityMonitorDays),
      inactivityFollowUpDays: Value(inactivityFollowUpDays),
      inactivityHighRiskDays: Value(inactivityHighRiskDays),
      inactivityCriticalDays: Value(inactivityCriticalDays),
      staleImportHours: Value(staleImportHours),
      gymPhone: gymPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(gymPhone),
      peakHighAttendance: peakHighAttendance == null && nullToAbsent
          ? const Value.absent()
          : Value(peakHighAttendance),
      closureDatesJson: closureDatesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(closureDatesJson),
      riskWeightsJson: riskWeightsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(riskWeightsJson),
      trialDefaultDays: Value(trialDefaultDays),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocationSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationSetting(
      locationId: serializer.fromJson<String>(json['locationId']),
      inactivityMonitorDays: serializer.fromJson<int>(
        json['inactivityMonitorDays'],
      ),
      inactivityFollowUpDays: serializer.fromJson<int>(
        json['inactivityFollowUpDays'],
      ),
      inactivityHighRiskDays: serializer.fromJson<int>(
        json['inactivityHighRiskDays'],
      ),
      inactivityCriticalDays: serializer.fromJson<int>(
        json['inactivityCriticalDays'],
      ),
      staleImportHours: serializer.fromJson<int>(json['staleImportHours']),
      gymPhone: serializer.fromJson<String?>(json['gymPhone']),
      peakHighAttendance: serializer.fromJson<int?>(json['peakHighAttendance']),
      closureDatesJson: serializer.fromJson<String?>(json['closureDatesJson']),
      riskWeightsJson: serializer.fromJson<String?>(json['riskWeightsJson']),
      trialDefaultDays: serializer.fromJson<int>(json['trialDefaultDays']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'locationId': serializer.toJson<String>(locationId),
      'inactivityMonitorDays': serializer.toJson<int>(inactivityMonitorDays),
      'inactivityFollowUpDays': serializer.toJson<int>(inactivityFollowUpDays),
      'inactivityHighRiskDays': serializer.toJson<int>(inactivityHighRiskDays),
      'inactivityCriticalDays': serializer.toJson<int>(inactivityCriticalDays),
      'staleImportHours': serializer.toJson<int>(staleImportHours),
      'gymPhone': serializer.toJson<String?>(gymPhone),
      'peakHighAttendance': serializer.toJson<int?>(peakHighAttendance),
      'closureDatesJson': serializer.toJson<String?>(closureDatesJson),
      'riskWeightsJson': serializer.toJson<String?>(riskWeightsJson),
      'trialDefaultDays': serializer.toJson<int>(trialDefaultDays),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocationSetting copyWith({
    String? locationId,
    int? inactivityMonitorDays,
    int? inactivityFollowUpDays,
    int? inactivityHighRiskDays,
    int? inactivityCriticalDays,
    int? staleImportHours,
    Value<String?> gymPhone = const Value.absent(),
    Value<int?> peakHighAttendance = const Value.absent(),
    Value<String?> closureDatesJson = const Value.absent(),
    Value<String?> riskWeightsJson = const Value.absent(),
    int? trialDefaultDays,
    DateTime? updatedAt,
  }) => LocationSetting(
    locationId: locationId ?? this.locationId,
    inactivityMonitorDays: inactivityMonitorDays ?? this.inactivityMonitorDays,
    inactivityFollowUpDays:
        inactivityFollowUpDays ?? this.inactivityFollowUpDays,
    inactivityHighRiskDays:
        inactivityHighRiskDays ?? this.inactivityHighRiskDays,
    inactivityCriticalDays:
        inactivityCriticalDays ?? this.inactivityCriticalDays,
    staleImportHours: staleImportHours ?? this.staleImportHours,
    gymPhone: gymPhone.present ? gymPhone.value : this.gymPhone,
    peakHighAttendance: peakHighAttendance.present
        ? peakHighAttendance.value
        : this.peakHighAttendance,
    closureDatesJson: closureDatesJson.present
        ? closureDatesJson.value
        : this.closureDatesJson,
    riskWeightsJson: riskWeightsJson.present
        ? riskWeightsJson.value
        : this.riskWeightsJson,
    trialDefaultDays: trialDefaultDays ?? this.trialDefaultDays,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocationSetting copyWithCompanion(LocationSettingsCompanion data) {
    return LocationSetting(
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      inactivityMonitorDays: data.inactivityMonitorDays.present
          ? data.inactivityMonitorDays.value
          : this.inactivityMonitorDays,
      inactivityFollowUpDays: data.inactivityFollowUpDays.present
          ? data.inactivityFollowUpDays.value
          : this.inactivityFollowUpDays,
      inactivityHighRiskDays: data.inactivityHighRiskDays.present
          ? data.inactivityHighRiskDays.value
          : this.inactivityHighRiskDays,
      inactivityCriticalDays: data.inactivityCriticalDays.present
          ? data.inactivityCriticalDays.value
          : this.inactivityCriticalDays,
      staleImportHours: data.staleImportHours.present
          ? data.staleImportHours.value
          : this.staleImportHours,
      gymPhone: data.gymPhone.present ? data.gymPhone.value : this.gymPhone,
      peakHighAttendance: data.peakHighAttendance.present
          ? data.peakHighAttendance.value
          : this.peakHighAttendance,
      closureDatesJson: data.closureDatesJson.present
          ? data.closureDatesJson.value
          : this.closureDatesJson,
      riskWeightsJson: data.riskWeightsJson.present
          ? data.riskWeightsJson.value
          : this.riskWeightsJson,
      trialDefaultDays: data.trialDefaultDays.present
          ? data.trialDefaultDays.value
          : this.trialDefaultDays,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationSetting(')
          ..write('locationId: $locationId, ')
          ..write('inactivityMonitorDays: $inactivityMonitorDays, ')
          ..write('inactivityFollowUpDays: $inactivityFollowUpDays, ')
          ..write('inactivityHighRiskDays: $inactivityHighRiskDays, ')
          ..write('inactivityCriticalDays: $inactivityCriticalDays, ')
          ..write('staleImportHours: $staleImportHours, ')
          ..write('gymPhone: $gymPhone, ')
          ..write('peakHighAttendance: $peakHighAttendance, ')
          ..write('closureDatesJson: $closureDatesJson, ')
          ..write('riskWeightsJson: $riskWeightsJson, ')
          ..write('trialDefaultDays: $trialDefaultDays, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    locationId,
    inactivityMonitorDays,
    inactivityFollowUpDays,
    inactivityHighRiskDays,
    inactivityCriticalDays,
    staleImportHours,
    gymPhone,
    peakHighAttendance,
    closureDatesJson,
    riskWeightsJson,
    trialDefaultDays,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationSetting &&
          other.locationId == this.locationId &&
          other.inactivityMonitorDays == this.inactivityMonitorDays &&
          other.inactivityFollowUpDays == this.inactivityFollowUpDays &&
          other.inactivityHighRiskDays == this.inactivityHighRiskDays &&
          other.inactivityCriticalDays == this.inactivityCriticalDays &&
          other.staleImportHours == this.staleImportHours &&
          other.gymPhone == this.gymPhone &&
          other.peakHighAttendance == this.peakHighAttendance &&
          other.closureDatesJson == this.closureDatesJson &&
          other.riskWeightsJson == this.riskWeightsJson &&
          other.trialDefaultDays == this.trialDefaultDays &&
          other.updatedAt == this.updatedAt);
}

class LocationSettingsCompanion extends UpdateCompanion<LocationSetting> {
  final Value<String> locationId;
  final Value<int> inactivityMonitorDays;
  final Value<int> inactivityFollowUpDays;
  final Value<int> inactivityHighRiskDays;
  final Value<int> inactivityCriticalDays;
  final Value<int> staleImportHours;
  final Value<String?> gymPhone;
  final Value<int?> peakHighAttendance;
  final Value<String?> closureDatesJson;
  final Value<String?> riskWeightsJson;
  final Value<int> trialDefaultDays;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocationSettingsCompanion({
    this.locationId = const Value.absent(),
    this.inactivityMonitorDays = const Value.absent(),
    this.inactivityFollowUpDays = const Value.absent(),
    this.inactivityHighRiskDays = const Value.absent(),
    this.inactivityCriticalDays = const Value.absent(),
    this.staleImportHours = const Value.absent(),
    this.gymPhone = const Value.absent(),
    this.peakHighAttendance = const Value.absent(),
    this.closureDatesJson = const Value.absent(),
    this.riskWeightsJson = const Value.absent(),
    this.trialDefaultDays = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationSettingsCompanion.insert({
    required String locationId,
    this.inactivityMonitorDays = const Value.absent(),
    this.inactivityFollowUpDays = const Value.absent(),
    this.inactivityHighRiskDays = const Value.absent(),
    this.inactivityCriticalDays = const Value.absent(),
    this.staleImportHours = const Value.absent(),
    this.gymPhone = const Value.absent(),
    this.peakHighAttendance = const Value.absent(),
    this.closureDatesJson = const Value.absent(),
    this.riskWeightsJson = const Value.absent(),
    this.trialDefaultDays = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : locationId = Value(locationId),
       updatedAt = Value(updatedAt);
  static Insertable<LocationSetting> custom({
    Expression<String>? locationId,
    Expression<int>? inactivityMonitorDays,
    Expression<int>? inactivityFollowUpDays,
    Expression<int>? inactivityHighRiskDays,
    Expression<int>? inactivityCriticalDays,
    Expression<int>? staleImportHours,
    Expression<String>? gymPhone,
    Expression<int>? peakHighAttendance,
    Expression<String>? closureDatesJson,
    Expression<String>? riskWeightsJson,
    Expression<int>? trialDefaultDays,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (locationId != null) 'location_id': locationId,
      if (inactivityMonitorDays != null)
        'inactivity_monitor_days': inactivityMonitorDays,
      if (inactivityFollowUpDays != null)
        'inactivity_follow_up_days': inactivityFollowUpDays,
      if (inactivityHighRiskDays != null)
        'inactivity_high_risk_days': inactivityHighRiskDays,
      if (inactivityCriticalDays != null)
        'inactivity_critical_days': inactivityCriticalDays,
      if (staleImportHours != null) 'stale_import_hours': staleImportHours,
      if (gymPhone != null) 'gym_phone': gymPhone,
      if (peakHighAttendance != null)
        'peak_high_attendance': peakHighAttendance,
      if (closureDatesJson != null) 'closure_dates_json': closureDatesJson,
      if (riskWeightsJson != null) 'risk_weights_json': riskWeightsJson,
      if (trialDefaultDays != null) 'trial_default_days': trialDefaultDays,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationSettingsCompanion copyWith({
    Value<String>? locationId,
    Value<int>? inactivityMonitorDays,
    Value<int>? inactivityFollowUpDays,
    Value<int>? inactivityHighRiskDays,
    Value<int>? inactivityCriticalDays,
    Value<int>? staleImportHours,
    Value<String?>? gymPhone,
    Value<int?>? peakHighAttendance,
    Value<String?>? closureDatesJson,
    Value<String?>? riskWeightsJson,
    Value<int>? trialDefaultDays,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocationSettingsCompanion(
      locationId: locationId ?? this.locationId,
      inactivityMonitorDays:
          inactivityMonitorDays ?? this.inactivityMonitorDays,
      inactivityFollowUpDays:
          inactivityFollowUpDays ?? this.inactivityFollowUpDays,
      inactivityHighRiskDays:
          inactivityHighRiskDays ?? this.inactivityHighRiskDays,
      inactivityCriticalDays:
          inactivityCriticalDays ?? this.inactivityCriticalDays,
      staleImportHours: staleImportHours ?? this.staleImportHours,
      gymPhone: gymPhone ?? this.gymPhone,
      peakHighAttendance: peakHighAttendance ?? this.peakHighAttendance,
      closureDatesJson: closureDatesJson ?? this.closureDatesJson,
      riskWeightsJson: riskWeightsJson ?? this.riskWeightsJson,
      trialDefaultDays: trialDefaultDays ?? this.trialDefaultDays,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (inactivityMonitorDays.present) {
      map['inactivity_monitor_days'] = Variable<int>(
        inactivityMonitorDays.value,
      );
    }
    if (inactivityFollowUpDays.present) {
      map['inactivity_follow_up_days'] = Variable<int>(
        inactivityFollowUpDays.value,
      );
    }
    if (inactivityHighRiskDays.present) {
      map['inactivity_high_risk_days'] = Variable<int>(
        inactivityHighRiskDays.value,
      );
    }
    if (inactivityCriticalDays.present) {
      map['inactivity_critical_days'] = Variable<int>(
        inactivityCriticalDays.value,
      );
    }
    if (staleImportHours.present) {
      map['stale_import_hours'] = Variable<int>(staleImportHours.value);
    }
    if (gymPhone.present) {
      map['gym_phone'] = Variable<String>(gymPhone.value);
    }
    if (peakHighAttendance.present) {
      map['peak_high_attendance'] = Variable<int>(peakHighAttendance.value);
    }
    if (closureDatesJson.present) {
      map['closure_dates_json'] = Variable<String>(closureDatesJson.value);
    }
    if (riskWeightsJson.present) {
      map['risk_weights_json'] = Variable<String>(riskWeightsJson.value);
    }
    if (trialDefaultDays.present) {
      map['trial_default_days'] = Variable<int>(trialDefaultDays.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationSettingsCompanion(')
          ..write('locationId: $locationId, ')
          ..write('inactivityMonitorDays: $inactivityMonitorDays, ')
          ..write('inactivityFollowUpDays: $inactivityFollowUpDays, ')
          ..write('inactivityHighRiskDays: $inactivityHighRiskDays, ')
          ..write('inactivityCriticalDays: $inactivityCriticalDays, ')
          ..write('staleImportHours: $staleImportHours, ')
          ..write('gymPhone: $gymPhone, ')
          ..write('peakHighAttendance: $peakHighAttendance, ')
          ..write('closureDatesJson: $closureDatesJson, ')
          ..write('riskWeightsJson: $riskWeightsJson, ')
          ..write('trialDefaultDays: $trialDefaultDays, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OrganizationsTable organizations = $OrganizationsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $OrganizationMembersTable organizationMembers =
      $OrganizationMembersTable(this);
  late final $LocationAccessTable locationAccess = $LocationAccessTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $MembershipPlansTable membershipPlans = $MembershipPlansTable(
    this,
  );
  late final $MembershipsTable memberships = $MembershipsTable(this);
  late final $AttendanceSourcesTable attendanceSources =
      $AttendanceSourcesTable(this);
  late final $AttendanceEventsTable attendanceEvents = $AttendanceEventsTable(
    this,
  );
  late final $TrialsTable trials = $TrialsTable(this);
  late final $FollowUpsTable followUps = $FollowUpsTable(this);
  late final $MessageTemplatesTable messageTemplates = $MessageTemplatesTable(
    this,
  );
  late final $CancellationEventsTable cancellationEvents =
      $CancellationEventsTable(this);
  late final $RiskScoresTable riskScores = $RiskScoresTable(this);
  late final $DailyMemberMetricsTable dailyMemberMetrics =
      $DailyMemberMetricsTable(this);
  late final $GymDailyMetricsTable gymDailyMetrics = $GymDailyMetricsTable(
    this,
  );
  late final $IntegrationSyncRunsTable integrationSyncRuns =
      $IntegrationSyncRunsTable(this);
  late final $NotificationPreferencesTable notificationPreferences =
      $NotificationPreferencesTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $AppMetaEntriesTable appMetaEntries = $AppMetaEntriesTable(this);
  late final $SecurityStatesTable securityStates = $SecurityStatesTable(this);
  late final $BackupRunsTable backupRuns = $BackupRunsTable(this);
  late final $BackupReminderSettingsTable backupReminderSettings =
      $BackupReminderSettingsTable(this);
  late final $LocationSettingsTable locationSettings = $LocationSettingsTable(
    this,
  );
  late final Index membersOrgExternalUidx = Index(
    'members_org_external_uidx',
    'CREATE UNIQUE INDEX members_org_external_uidx ON members (organization_id, external_member_id)',
  );
  late final Index membersOrgLocationIdx = Index(
    'members_org_location_idx',
    'CREATE INDEX members_org_location_idx ON members (organization_id, location_id)',
  );
  late final Index attendanceSourceEventUidx = Index(
    'attendance_source_event_uidx',
    'CREATE UNIQUE INDEX attendance_source_event_uidx ON attendance_events (source_id, external_event_id)',
  );
  late final Index attendanceOrgLocationTimeIdx = Index(
    'attendance_org_location_time_idx',
    'CREATE INDEX attendance_org_location_time_idx ON attendance_events (organization_id, location_id, occurred_at_utc)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    organizations,
    locations,
    localUsers,
    organizationMembers,
    locationAccess,
    members,
    membershipPlans,
    memberships,
    attendanceSources,
    attendanceEvents,
    trials,
    followUps,
    messageTemplates,
    cancellationEvents,
    riskScores,
    dailyMemberMetrics,
    gymDailyMetrics,
    integrationSyncRuns,
    notificationPreferences,
    auditLogs,
    appMetaEntries,
    securityStates,
    backupRuns,
    backupReminderSettings,
    locationSettings,
    membersOrgExternalUidx,
    membersOrgLocationIdx,
    attendanceSourceEventUidx,
    attendanceOrgLocationTimeIdx,
  ];
}

typedef $$OrganizationsTableCreateCompanionBuilder =
    OrganizationsCompanion Function({
      required String id,
      required String name,
      Value<String> countryCode,
      Value<String> defaultCurrency,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$OrganizationsTableUpdateCompanionBuilder =
    OrganizationsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> countryCode,
      Value<String> defaultCurrency,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$OrganizationsTableFilterComposer
    extends Composer<_$AppDatabase, $OrganizationsTable> {
  $$OrganizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrganizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrganizationsTable> {
  $$OrganizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrganizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrganizationsTable> {
  $$OrganizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OrganizationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrganizationsTable,
          Organization,
          $$OrganizationsTableFilterComposer,
          $$OrganizationsTableOrderingComposer,
          $$OrganizationsTableAnnotationComposer,
          $$OrganizationsTableCreateCompanionBuilder,
          $$OrganizationsTableUpdateCompanionBuilder,
          (
            Organization,
            BaseReferences<_$AppDatabase, $OrganizationsTable, Organization>,
          ),
          Organization,
          PrefetchHooks Function()
        > {
  $$OrganizationsTableTableManager(_$AppDatabase db, $OrganizationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrganizationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrganizationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrganizationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrganizationsCompanion(
                id: id,
                name: name,
                countryCode: countryCode,
                defaultCurrency: defaultCurrency,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> countryCode = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => OrganizationsCompanion.insert(
                id: id,
                name: name,
                countryCode: countryCode,
                defaultCurrency: defaultCurrency,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrganizationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrganizationsTable,
      Organization,
      $$OrganizationsTableFilterComposer,
      $$OrganizationsTableOrderingComposer,
      $$OrganizationsTableAnnotationComposer,
      $$OrganizationsTableCreateCompanionBuilder,
      $$OrganizationsTableUpdateCompanionBuilder,
      (
        Organization,
        BaseReferences<_$AppDatabase, $OrganizationsTable, Organization>,
      ),
      Organization,
      PrefetchHooks Function()
    >;
typedef $$LocationsTableCreateCompanionBuilder =
    LocationsCompanion Function({
      required String id,
      required String organizationId,
      required String name,
      Value<String> timezone,
      Value<String> countryCode,
      Value<String> currencyCode,
      Value<String?> addressJson,
      Value<int?> capacity,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$LocationsTableUpdateCompanionBuilder =
    LocationsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> name,
      Value<String> timezone,
      Value<String> countryCode,
      Value<String> currencyCode,
      Value<String?> addressJson,
      Value<int?> capacity,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressJson => $composableBuilder(
    column: $table.addressJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressJson => $composableBuilder(
    column: $table.addressJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressJson => $composableBuilder(
    column: $table.addressJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get capacity =>
      $composableBuilder(column: $table.capacity, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationsTable,
          Location,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
          Location,
          PrefetchHooks Function()
        > {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> timezone = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String?> addressJson = const Value.absent(),
                Value<int?> capacity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion(
                id: id,
                organizationId: organizationId,
                name: name,
                timezone: timezone,
                countryCode: countryCode,
                currencyCode: currencyCode,
                addressJson: addressJson,
                capacity: capacity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String name,
                Value<String> timezone = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String?> addressJson = const Value.absent(),
                Value<int?> capacity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion.insert(
                id: id,
                organizationId: organizationId,
                name: name,
                timezone: timezone,
                countryCode: countryCode,
                currencyCode: currencyCode,
                addressJson: addressJson,
                capacity: capacity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationsTable,
      Location,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
      Location,
      PrefetchHooks Function()
    >;
typedef $$LocalUsersTableCreateCompanionBuilder =
    LocalUsersCompanion Function({
      required String id,
      required String displayName,
      Value<String?> roleDefault,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$LocalUsersTableUpdateCompanionBuilder =
    LocalUsersCompanion Function({
      Value<String> id,
      Value<String> displayName,
      Value<String?> roleDefault,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$LocalUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roleDefault => $composableBuilder(
    column: $table.roleDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roleDefault => $composableBuilder(
    column: $table.roleDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roleDefault => $composableBuilder(
    column: $table.roleDefault,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalUsersTable,
          LocalUser,
          $$LocalUsersTableFilterComposer,
          $$LocalUsersTableOrderingComposer,
          $$LocalUsersTableAnnotationComposer,
          $$LocalUsersTableCreateCompanionBuilder,
          $$LocalUsersTableUpdateCompanionBuilder,
          (
            LocalUser,
            BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>,
          ),
          LocalUser,
          PrefetchHooks Function()
        > {
  $$LocalUsersTableTableManager(_$AppDatabase db, $LocalUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> roleDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion(
                id: id,
                displayName: displayName,
                roleDefault: roleDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                Value<String?> roleDefault = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion.insert(
                id: id,
                displayName: displayName,
                roleDefault: roleDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalUsersTable,
      LocalUser,
      $$LocalUsersTableFilterComposer,
      $$LocalUsersTableOrderingComposer,
      $$LocalUsersTableAnnotationComposer,
      $$LocalUsersTableCreateCompanionBuilder,
      $$LocalUsersTableUpdateCompanionBuilder,
      (LocalUser, BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser>),
      LocalUser,
      PrefetchHooks Function()
    >;
typedef $$OrganizationMembersTableCreateCompanionBuilder =
    OrganizationMembersCompanion Function({
      required String organizationId,
      required String userId,
      required String role,
      Value<String> status,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$OrganizationMembersTableUpdateCompanionBuilder =
    OrganizationMembersCompanion Function({
      Value<String> organizationId,
      Value<String> userId,
      Value<String> role,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$OrganizationMembersTableFilterComposer
    extends Composer<_$AppDatabase, $OrganizationMembersTable> {
  $$OrganizationMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrganizationMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrganizationMembersTable> {
  $$OrganizationMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrganizationMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrganizationMembersTable> {
  $$OrganizationMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OrganizationMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrganizationMembersTable,
          OrganizationMember,
          $$OrganizationMembersTableFilterComposer,
          $$OrganizationMembersTableOrderingComposer,
          $$OrganizationMembersTableAnnotationComposer,
          $$OrganizationMembersTableCreateCompanionBuilder,
          $$OrganizationMembersTableUpdateCompanionBuilder,
          (
            OrganizationMember,
            BaseReferences<
              _$AppDatabase,
              $OrganizationMembersTable,
              OrganizationMember
            >,
          ),
          OrganizationMember,
          PrefetchHooks Function()
        > {
  $$OrganizationMembersTableTableManager(
    _$AppDatabase db,
    $OrganizationMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrganizationMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrganizationMembersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$OrganizationMembersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> organizationId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrganizationMembersCompanion(
                organizationId: organizationId,
                userId: userId,
                role: role,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String organizationId,
                required String userId,
                required String role,
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => OrganizationMembersCompanion.insert(
                organizationId: organizationId,
                userId: userId,
                role: role,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrganizationMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrganizationMembersTable,
      OrganizationMember,
      $$OrganizationMembersTableFilterComposer,
      $$OrganizationMembersTableOrderingComposer,
      $$OrganizationMembersTableAnnotationComposer,
      $$OrganizationMembersTableCreateCompanionBuilder,
      $$OrganizationMembersTableUpdateCompanionBuilder,
      (
        OrganizationMember,
        BaseReferences<
          _$AppDatabase,
          $OrganizationMembersTable,
          OrganizationMember
        >,
      ),
      OrganizationMember,
      PrefetchHooks Function()
    >;
typedef $$LocationAccessTableCreateCompanionBuilder =
    LocationAccessCompanion Function({
      required String organizationId,
      required String locationId,
      required String userId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$LocationAccessTableUpdateCompanionBuilder =
    LocationAccessCompanion Function({
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> userId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LocationAccessTableFilterComposer
    extends Composer<_$AppDatabase, $LocationAccessTable> {
  $$LocationAccessTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationAccessTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationAccessTable> {
  $$LocationAccessTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationAccessTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationAccessTable> {
  $$LocationAccessTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocationAccessTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationAccessTable,
          LocationAccessData,
          $$LocationAccessTableFilterComposer,
          $$LocationAccessTableOrderingComposer,
          $$LocationAccessTableAnnotationComposer,
          $$LocationAccessTableCreateCompanionBuilder,
          $$LocationAccessTableUpdateCompanionBuilder,
          (
            LocationAccessData,
            BaseReferences<
              _$AppDatabase,
              $LocationAccessTable,
              LocationAccessData
            >,
          ),
          LocationAccessData,
          PrefetchHooks Function()
        > {
  $$LocationAccessTableTableManager(
    _$AppDatabase db,
    $LocationAccessTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationAccessTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationAccessTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationAccessTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationAccessCompanion(
                organizationId: organizationId,
                locationId: locationId,
                userId: userId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String organizationId,
                required String locationId,
                required String userId,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LocationAccessCompanion.insert(
                organizationId: organizationId,
                locationId: locationId,
                userId: userId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationAccessTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationAccessTable,
      LocationAccessData,
      $$LocationAccessTableFilterComposer,
      $$LocationAccessTableOrderingComposer,
      $$LocationAccessTableAnnotationComposer,
      $$LocationAccessTableCreateCompanionBuilder,
      $$LocationAccessTableUpdateCompanionBuilder,
      (
        LocationAccessData,
        BaseReferences<_$AppDatabase, $LocationAccessTable, LocationAccessData>,
      ),
      LocationAccessData,
      PrefetchHooks Function()
    >;
typedef $$MembersTableCreateCompanionBuilder =
    MembersCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      Value<String?> externalMemberId,
      required String firstName,
      Value<String> lastName,
      Value<String?> phone,
      Value<String?> email,
      Value<String> status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MembersTableUpdateCompanionBuilder =
    MembersCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String?> externalMemberId,
      Value<String> firstName,
      Value<String> lastName,
      Value<String?> phone,
      Value<String?> email,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalMemberId => $composableBuilder(
    column: $table.externalMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalMemberId => $composableBuilder(
    column: $table.externalMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalMemberId => $composableBuilder(
    column: $table.externalMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          Member,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
          Member,
          PrefetchHooks Function()
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String?> externalMemberId = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                externalMemberId: externalMemberId,
                firstName: firstName,
                lastName: lastName,
                phone: phone,
                email: email,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                Value<String?> externalMemberId = const Value.absent(),
                required String firstName,
                Value<String> lastName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                externalMemberId: externalMemberId,
                firstName: firstName,
                lastName: lastName,
                phone: phone,
                email: email,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      Member,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
      Member,
      PrefetchHooks Function()
    >;
typedef $$MembershipPlansTableCreateCompanionBuilder =
    MembershipPlansCompanion Function({
      required String id,
      required String organizationId,
      Value<String?> locationId,
      required String name,
      required int durationDays,
      Value<double> priceAmount,
      Value<String> currencyCode,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$MembershipPlansTableUpdateCompanionBuilder =
    MembershipPlansCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String?> locationId,
      Value<String> name,
      Value<int> durationDays,
      Value<double> priceAmount,
      Value<String> currencyCode,
      Value<bool> active,
      Value<int> rowid,
    });

class $$MembershipPlansTableFilterComposer
    extends Composer<_$AppDatabase, $MembershipPlansTable> {
  $$MembershipPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceAmount => $composableBuilder(
    column: $table.priceAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembershipPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $MembershipPlansTable> {
  $$MembershipPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceAmount => $composableBuilder(
    column: $table.priceAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembershipPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembershipPlansTable> {
  $$MembershipPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get priceAmount => $composableBuilder(
    column: $table.priceAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$MembershipPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembershipPlansTable,
          MembershipPlan,
          $$MembershipPlansTableFilterComposer,
          $$MembershipPlansTableOrderingComposer,
          $$MembershipPlansTableAnnotationComposer,
          $$MembershipPlansTableCreateCompanionBuilder,
          $$MembershipPlansTableUpdateCompanionBuilder,
          (
            MembershipPlan,
            BaseReferences<
              _$AppDatabase,
              $MembershipPlansTable,
              MembershipPlan
            >,
          ),
          MembershipPlan,
          PrefetchHooks Function()
        > {
  $$MembershipPlansTableTableManager(
    _$AppDatabase db,
    $MembershipPlansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembershipPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembershipPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembershipPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String?> locationId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> durationDays = const Value.absent(),
                Value<double> priceAmount = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipPlansCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                name: name,
                durationDays: durationDays,
                priceAmount: priceAmount,
                currencyCode: currencyCode,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                Value<String?> locationId = const Value.absent(),
                required String name,
                required int durationDays,
                Value<double> priceAmount = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipPlansCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                name: name,
                durationDays: durationDays,
                priceAmount: priceAmount,
                currencyCode: currencyCode,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembershipPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembershipPlansTable,
      MembershipPlan,
      $$MembershipPlansTableFilterComposer,
      $$MembershipPlansTableOrderingComposer,
      $$MembershipPlansTableAnnotationComposer,
      $$MembershipPlansTableCreateCompanionBuilder,
      $$MembershipPlansTableUpdateCompanionBuilder,
      (
        MembershipPlan,
        BaseReferences<_$AppDatabase, $MembershipPlansTable, MembershipPlan>,
      ),
      MembershipPlan,
      PrefetchHooks Function()
    >;
typedef $$MembershipsTableCreateCompanionBuilder =
    MembershipsCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      required String memberId,
      Value<String?> planId,
      required DateTime startAt,
      required DateTime endAt,
      required String status,
      Value<double?> priceAmount,
      Value<String?> currencyCode,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MembershipsTableUpdateCompanionBuilder =
    MembershipsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> memberId,
      Value<String?> planId,
      Value<DateTime> startAt,
      Value<DateTime> endAt,
      Value<String> status,
      Value<double?> priceAmount,
      Value<String?> currencyCode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MembershipsTableFilterComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceAmount => $composableBuilder(
    column: $table.priceAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembershipsTableOrderingComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceAmount => $composableBuilder(
    column: $table.priceAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembershipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembershipsTable> {
  $$MembershipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get priceAmount => $composableBuilder(
    column: $table.priceAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MembershipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembershipsTable,
          Membership,
          $$MembershipsTableFilterComposer,
          $$MembershipsTableOrderingComposer,
          $$MembershipsTableAnnotationComposer,
          $$MembershipsTableCreateCompanionBuilder,
          $$MembershipsTableUpdateCompanionBuilder,
          (
            Membership,
            BaseReferences<_$AppDatabase, $MembershipsTable, Membership>,
          ),
          Membership,
          PrefetchHooks Function()
        > {
  $$MembershipsTableTableManager(_$AppDatabase db, $MembershipsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembershipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembershipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembershipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String?> planId = const Value.absent(),
                Value<DateTime> startAt = const Value.absent(),
                Value<DateTime> endAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double?> priceAmount = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembershipsCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                planId: planId,
                startAt: startAt,
                endAt: endAt,
                status: status,
                priceAmount: priceAmount,
                currencyCode: currencyCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                required String memberId,
                Value<String?> planId = const Value.absent(),
                required DateTime startAt,
                required DateTime endAt,
                required String status,
                Value<double?> priceAmount = const Value.absent(),
                Value<String?> currencyCode = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MembershipsCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                planId: planId,
                startAt: startAt,
                endAt: endAt,
                status: status,
                priceAmount: priceAmount,
                currencyCode: currencyCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembershipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembershipsTable,
      Membership,
      $$MembershipsTableFilterComposer,
      $$MembershipsTableOrderingComposer,
      $$MembershipsTableAnnotationComposer,
      $$MembershipsTableCreateCompanionBuilder,
      $$MembershipsTableUpdateCompanionBuilder,
      (
        Membership,
        BaseReferences<_$AppDatabase, $MembershipsTable, Membership>,
      ),
      Membership,
      PrefetchHooks Function()
    >;
typedef $$AttendanceSourcesTableCreateCompanionBuilder =
    AttendanceSourcesCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      required String type,
      Value<String?> vendor,
      Value<String?> externalSourceId,
      Value<String> status,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<String?> metadataJson,
      Value<int> rowid,
    });
typedef $$AttendanceSourcesTableUpdateCompanionBuilder =
    AttendanceSourcesCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> type,
      Value<String?> vendor,
      Value<String?> externalSourceId,
      Value<String> status,
      Value<DateTime?> lastSuccessAt,
      Value<DateTime?> lastAttemptAt,
      Value<String?> metadataJson,
      Value<int> rowid,
    });

class $$AttendanceSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceSourcesTable> {
  $$AttendanceSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalSourceId => $composableBuilder(
    column: $table.externalSourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceSourcesTable> {
  $$AttendanceSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalSourceId => $composableBuilder(
    column: $table.externalSourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceSourcesTable> {
  $$AttendanceSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get vendor =>
      $composableBuilder(column: $table.vendor, builder: (column) => column);

  GeneratedColumn<String> get externalSourceId => $composableBuilder(
    column: $table.externalSourceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );
}

class $$AttendanceSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceSourcesTable,
          AttendanceSource,
          $$AttendanceSourcesTableFilterComposer,
          $$AttendanceSourcesTableOrderingComposer,
          $$AttendanceSourcesTableAnnotationComposer,
          $$AttendanceSourcesTableCreateCompanionBuilder,
          $$AttendanceSourcesTableUpdateCompanionBuilder,
          (
            AttendanceSource,
            BaseReferences<
              _$AppDatabase,
              $AttendanceSourcesTable,
              AttendanceSource
            >,
          ),
          AttendanceSource,
          PrefetchHooks Function()
        > {
  $$AttendanceSourcesTableTableManager(
    _$AppDatabase db,
    $AttendanceSourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceSourcesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> vendor = const Value.absent(),
                Value<String?> externalSourceId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceSourcesCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                type: type,
                vendor: vendor,
                externalSourceId: externalSourceId,
                status: status,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                required String type,
                Value<String?> vendor = const Value.absent(),
                Value<String?> externalSourceId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceSourcesCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                type: type,
                vendor: vendor,
                externalSourceId: externalSourceId,
                status: status,
                lastSuccessAt: lastSuccessAt,
                lastAttemptAt: lastAttemptAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceSourcesTable,
      AttendanceSource,
      $$AttendanceSourcesTableFilterComposer,
      $$AttendanceSourcesTableOrderingComposer,
      $$AttendanceSourcesTableAnnotationComposer,
      $$AttendanceSourcesTableCreateCompanionBuilder,
      $$AttendanceSourcesTableUpdateCompanionBuilder,
      (
        AttendanceSource,
        BaseReferences<
          _$AppDatabase,
          $AttendanceSourcesTable,
          AttendanceSource
        >,
      ),
      AttendanceSource,
      PrefetchHooks Function()
    >;
typedef $$AttendanceEventsTableCreateCompanionBuilder =
    AttendanceEventsCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      Value<String?> memberId,
      required String externalMemberId,
      required String sourceId,
      required DateTime occurredAtUtc,
      required DateTime occurredAtLocal,
      required String eventType,
      Value<String?> externalEventId,
      Value<String?> rawPayloadJson,
      required DateTime ingestedAt,
      Value<String> matchStatus,
      Value<int> rowid,
    });
typedef $$AttendanceEventsTableUpdateCompanionBuilder =
    AttendanceEventsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String?> memberId,
      Value<String> externalMemberId,
      Value<String> sourceId,
      Value<DateTime> occurredAtUtc,
      Value<DateTime> occurredAtLocal,
      Value<String> eventType,
      Value<String?> externalEventId,
      Value<String?> rawPayloadJson,
      Value<DateTime> ingestedAt,
      Value<String> matchStatus,
      Value<int> rowid,
    });

class $$AttendanceEventsTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceEventsTable> {
  $$AttendanceEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalMemberId => $composableBuilder(
    column: $table.externalMemberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAtUtc => $composableBuilder(
    column: $table.occurredAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAtLocal => $composableBuilder(
    column: $table.occurredAtLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalEventId => $composableBuilder(
    column: $table.externalEventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawPayloadJson => $composableBuilder(
    column: $table.rawPayloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ingestedAt => $composableBuilder(
    column: $table.ingestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceEventsTable> {
  $$AttendanceEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalMemberId => $composableBuilder(
    column: $table.externalMemberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAtUtc => $composableBuilder(
    column: $table.occurredAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAtLocal => $composableBuilder(
    column: $table.occurredAtLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalEventId => $composableBuilder(
    column: $table.externalEventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawPayloadJson => $composableBuilder(
    column: $table.rawPayloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ingestedAt => $composableBuilder(
    column: $table.ingestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceEventsTable> {
  $$AttendanceEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get externalMemberId => $composableBuilder(
    column: $table.externalMemberId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAtUtc => $composableBuilder(
    column: $table.occurredAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAtLocal => $composableBuilder(
    column: $table.occurredAtLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get externalEventId => $composableBuilder(
    column: $table.externalEventId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawPayloadJson => $composableBuilder(
    column: $table.rawPayloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get ingestedAt => $composableBuilder(
    column: $table.ingestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get matchStatus => $composableBuilder(
    column: $table.matchStatus,
    builder: (column) => column,
  );
}

class $$AttendanceEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceEventsTable,
          AttendanceEvent,
          $$AttendanceEventsTableFilterComposer,
          $$AttendanceEventsTableOrderingComposer,
          $$AttendanceEventsTableAnnotationComposer,
          $$AttendanceEventsTableCreateCompanionBuilder,
          $$AttendanceEventsTableUpdateCompanionBuilder,
          (
            AttendanceEvent,
            BaseReferences<
              _$AppDatabase,
              $AttendanceEventsTable,
              AttendanceEvent
            >,
          ),
          AttendanceEvent,
          PrefetchHooks Function()
        > {
  $$AttendanceEventsTableTableManager(
    _$AppDatabase db,
    $AttendanceEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<String> externalMemberId = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<DateTime> occurredAtUtc = const Value.absent(),
                Value<DateTime> occurredAtLocal = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String?> externalEventId = const Value.absent(),
                Value<String?> rawPayloadJson = const Value.absent(),
                Value<DateTime> ingestedAt = const Value.absent(),
                Value<String> matchStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceEventsCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                externalMemberId: externalMemberId,
                sourceId: sourceId,
                occurredAtUtc: occurredAtUtc,
                occurredAtLocal: occurredAtLocal,
                eventType: eventType,
                externalEventId: externalEventId,
                rawPayloadJson: rawPayloadJson,
                ingestedAt: ingestedAt,
                matchStatus: matchStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                Value<String?> memberId = const Value.absent(),
                required String externalMemberId,
                required String sourceId,
                required DateTime occurredAtUtc,
                required DateTime occurredAtLocal,
                required String eventType,
                Value<String?> externalEventId = const Value.absent(),
                Value<String?> rawPayloadJson = const Value.absent(),
                required DateTime ingestedAt,
                Value<String> matchStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceEventsCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                externalMemberId: externalMemberId,
                sourceId: sourceId,
                occurredAtUtc: occurredAtUtc,
                occurredAtLocal: occurredAtLocal,
                eventType: eventType,
                externalEventId: externalEventId,
                rawPayloadJson: rawPayloadJson,
                ingestedAt: ingestedAt,
                matchStatus: matchStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceEventsTable,
      AttendanceEvent,
      $$AttendanceEventsTableFilterComposer,
      $$AttendanceEventsTableOrderingComposer,
      $$AttendanceEventsTableAnnotationComposer,
      $$AttendanceEventsTableCreateCompanionBuilder,
      $$AttendanceEventsTableUpdateCompanionBuilder,
      (
        AttendanceEvent,
        BaseReferences<_$AppDatabase, $AttendanceEventsTable, AttendanceEvent>,
      ),
      AttendanceEvent,
      PrefetchHooks Function()
    >;
typedef $$TrialsTableCreateCompanionBuilder =
    TrialsCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      required String memberId,
      required DateTime startedAt,
      required DateTime endsAt,
      Value<DateTime?> convertedAt,
      required String status,
      Value<String?> source,
      Value<int> rowid,
    });
typedef $$TrialsTableUpdateCompanionBuilder =
    TrialsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> memberId,
      Value<DateTime> startedAt,
      Value<DateTime> endsAt,
      Value<DateTime?> convertedAt,
      Value<String> status,
      Value<String?> source,
      Value<int> rowid,
    });

class $$TrialsTableFilterComposer
    extends Composer<_$AppDatabase, $TrialsTable> {
  $$TrialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get convertedAt => $composableBuilder(
    column: $table.convertedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrialsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrialsTable> {
  $$TrialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get convertedAt => $composableBuilder(
    column: $table.convertedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrialsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrialsTable> {
  $$TrialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get convertedAt => $composableBuilder(
    column: $table.convertedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);
}

class $$TrialsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrialsTable,
          Trial,
          $$TrialsTableFilterComposer,
          $$TrialsTableOrderingComposer,
          $$TrialsTableAnnotationComposer,
          $$TrialsTableCreateCompanionBuilder,
          $$TrialsTableUpdateCompanionBuilder,
          (Trial, BaseReferences<_$AppDatabase, $TrialsTable, Trial>),
          Trial,
          PrefetchHooks Function()
        > {
  $$TrialsTableTableManager(_$AppDatabase db, $TrialsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrialsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endsAt = const Value.absent(),
                Value<DateTime?> convertedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrialsCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                startedAt: startedAt,
                endsAt: endsAt,
                convertedAt: convertedAt,
                status: status,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                required String memberId,
                required DateTime startedAt,
                required DateTime endsAt,
                Value<DateTime?> convertedAt = const Value.absent(),
                required String status,
                Value<String?> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrialsCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                startedAt: startedAt,
                endsAt: endsAt,
                convertedAt: convertedAt,
                status: status,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrialsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrialsTable,
      Trial,
      $$TrialsTableFilterComposer,
      $$TrialsTableOrderingComposer,
      $$TrialsTableAnnotationComposer,
      $$TrialsTableCreateCompanionBuilder,
      $$TrialsTableUpdateCompanionBuilder,
      (Trial, BaseReferences<_$AppDatabase, $TrialsTable, Trial>),
      Trial,
      PrefetchHooks Function()
    >;
typedef $$FollowUpsTableCreateCompanionBuilder =
    FollowUpsCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      required String memberId,
      required String type,
      Value<int> priority,
      required String reason,
      required String status,
      Value<DateTime?> dueAt,
      Value<String?> assignedTo,
      Value<String?> contactChannel,
      Value<String?> messageTemplateId,
      Value<String?> resolutionNote,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FollowUpsTableUpdateCompanionBuilder =
    FollowUpsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> memberId,
      Value<String> type,
      Value<int> priority,
      Value<String> reason,
      Value<String> status,
      Value<DateTime?> dueAt,
      Value<String?> assignedTo,
      Value<String?> contactChannel,
      Value<String?> messageTemplateId,
      Value<String?> resolutionNote,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$FollowUpsTableFilterComposer
    extends Composer<_$AppDatabase, $FollowUpsTable> {
  $$FollowUpsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactChannel => $composableBuilder(
    column: $table.contactChannel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get messageTemplateId => $composableBuilder(
    column: $table.messageTemplateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolutionNote => $composableBuilder(
    column: $table.resolutionNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FollowUpsTableOrderingComposer
    extends Composer<_$AppDatabase, $FollowUpsTable> {
  $$FollowUpsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactChannel => $composableBuilder(
    column: $table.contactChannel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get messageTemplateId => $composableBuilder(
    column: $table.messageTemplateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolutionNote => $composableBuilder(
    column: $table.resolutionNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FollowUpsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FollowUpsTable> {
  $$FollowUpsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<String> get assignedTo => $composableBuilder(
    column: $table.assignedTo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactChannel => $composableBuilder(
    column: $table.contactChannel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get messageTemplateId => $composableBuilder(
    column: $table.messageTemplateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resolutionNote => $composableBuilder(
    column: $table.resolutionNote,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FollowUpsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FollowUpsTable,
          FollowUp,
          $$FollowUpsTableFilterComposer,
          $$FollowUpsTableOrderingComposer,
          $$FollowUpsTableAnnotationComposer,
          $$FollowUpsTableCreateCompanionBuilder,
          $$FollowUpsTableUpdateCompanionBuilder,
          (FollowUp, BaseReferences<_$AppDatabase, $FollowUpsTable, FollowUp>),
          FollowUp,
          PrefetchHooks Function()
        > {
  $$FollowUpsTableTableManager(_$AppDatabase db, $FollowUpsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FollowUpsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FollowUpsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FollowUpsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String?> assignedTo = const Value.absent(),
                Value<String?> contactChannel = const Value.absent(),
                Value<String?> messageTemplateId = const Value.absent(),
                Value<String?> resolutionNote = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FollowUpsCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                type: type,
                priority: priority,
                reason: reason,
                status: status,
                dueAt: dueAt,
                assignedTo: assignedTo,
                contactChannel: contactChannel,
                messageTemplateId: messageTemplateId,
                resolutionNote: resolutionNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                required String memberId,
                required String type,
                Value<int> priority = const Value.absent(),
                required String reason,
                required String status,
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String?> assignedTo = const Value.absent(),
                Value<String?> contactChannel = const Value.absent(),
                Value<String?> messageTemplateId = const Value.absent(),
                Value<String?> resolutionNote = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FollowUpsCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                type: type,
                priority: priority,
                reason: reason,
                status: status,
                dueAt: dueAt,
                assignedTo: assignedTo,
                contactChannel: contactChannel,
                messageTemplateId: messageTemplateId,
                resolutionNote: resolutionNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FollowUpsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FollowUpsTable,
      FollowUp,
      $$FollowUpsTableFilterComposer,
      $$FollowUpsTableOrderingComposer,
      $$FollowUpsTableAnnotationComposer,
      $$FollowUpsTableCreateCompanionBuilder,
      $$FollowUpsTableUpdateCompanionBuilder,
      (FollowUp, BaseReferences<_$AppDatabase, $FollowUpsTable, FollowUp>),
      FollowUp,
      PrefetchHooks Function()
    >;
typedef $$MessageTemplatesTableCreateCompanionBuilder =
    MessageTemplatesCompanion Function({
      required String id,
      required String organizationId,
      Value<String?> locationId,
      required String key,
      required String body,
      Value<String> channel,
      Value<bool> active,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MessageTemplatesTableUpdateCompanionBuilder =
    MessageTemplatesCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String?> locationId,
      Value<String> key,
      Value<String> body,
      Value<String> channel,
      Value<bool> active,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MessageTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessageTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessageTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessageTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessageTemplatesTable,
          MessageTemplate,
          $$MessageTemplatesTableFilterComposer,
          $$MessageTemplatesTableOrderingComposer,
          $$MessageTemplatesTableAnnotationComposer,
          $$MessageTemplatesTableCreateCompanionBuilder,
          $$MessageTemplatesTableUpdateCompanionBuilder,
          (
            MessageTemplate,
            BaseReferences<
              _$AppDatabase,
              $MessageTemplatesTable,
              MessageTemplate
            >,
          ),
          MessageTemplate,
          PrefetchHooks Function()
        > {
  $$MessageTemplatesTableTableManager(
    _$AppDatabase db,
    $MessageTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String?> locationId = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> channel = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageTemplatesCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                key: key,
                body: body,
                channel: channel,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                Value<String?> locationId = const Value.absent(),
                required String key,
                required String body,
                Value<String> channel = const Value.absent(),
                Value<bool> active = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MessageTemplatesCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                key: key,
                body: body,
                channel: channel,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessageTemplatesTable,
      MessageTemplate,
      $$MessageTemplatesTableFilterComposer,
      $$MessageTemplatesTableOrderingComposer,
      $$MessageTemplatesTableAnnotationComposer,
      $$MessageTemplatesTableCreateCompanionBuilder,
      $$MessageTemplatesTableUpdateCompanionBuilder,
      (
        MessageTemplate,
        BaseReferences<_$AppDatabase, $MessageTemplatesTable, MessageTemplate>,
      ),
      MessageTemplate,
      PrefetchHooks Function()
    >;
typedef $$CancellationEventsTableCreateCompanionBuilder =
    CancellationEventsCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      required String memberId,
      required DateTime occurredAt,
      required String reasonCode,
      Value<String?> reasonText,
      Value<String?> source,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$CancellationEventsTableUpdateCompanionBuilder =
    CancellationEventsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> memberId,
      Value<DateTime> occurredAt,
      Value<String> reasonCode,
      Value<String?> reasonText,
      Value<String?> source,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CancellationEventsTableFilterComposer
    extends Composer<_$AppDatabase, $CancellationEventsTable> {
  $$CancellationEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasonCode => $composableBuilder(
    column: $table.reasonCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reasonText => $composableBuilder(
    column: $table.reasonText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CancellationEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $CancellationEventsTable> {
  $$CancellationEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasonCode => $composableBuilder(
    column: $table.reasonCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reasonText => $composableBuilder(
    column: $table.reasonText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CancellationEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CancellationEventsTable> {
  $$CancellationEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reasonCode => $composableBuilder(
    column: $table.reasonCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reasonText => $composableBuilder(
    column: $table.reasonText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CancellationEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CancellationEventsTable,
          CancellationEvent,
          $$CancellationEventsTableFilterComposer,
          $$CancellationEventsTableOrderingComposer,
          $$CancellationEventsTableAnnotationComposer,
          $$CancellationEventsTableCreateCompanionBuilder,
          $$CancellationEventsTableUpdateCompanionBuilder,
          (
            CancellationEvent,
            BaseReferences<
              _$AppDatabase,
              $CancellationEventsTable,
              CancellationEvent
            >,
          ),
          CancellationEvent,
          PrefetchHooks Function()
        > {
  $$CancellationEventsTableTableManager(
    _$AppDatabase db,
    $CancellationEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CancellationEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CancellationEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CancellationEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String> reasonCode = const Value.absent(),
                Value<String?> reasonText = const Value.absent(),
                Value<String?> source = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CancellationEventsCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                occurredAt: occurredAt,
                reasonCode: reasonCode,
                reasonText: reasonText,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                required String memberId,
                required DateTime occurredAt,
                required String reasonCode,
                Value<String?> reasonText = const Value.absent(),
                Value<String?> source = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CancellationEventsCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                occurredAt: occurredAt,
                reasonCode: reasonCode,
                reasonText: reasonText,
                source: source,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CancellationEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CancellationEventsTable,
      CancellationEvent,
      $$CancellationEventsTableFilterComposer,
      $$CancellationEventsTableOrderingComposer,
      $$CancellationEventsTableAnnotationComposer,
      $$CancellationEventsTableCreateCompanionBuilder,
      $$CancellationEventsTableUpdateCompanionBuilder,
      (
        CancellationEvent,
        BaseReferences<
          _$AppDatabase,
          $CancellationEventsTable,
          CancellationEvent
        >,
      ),
      CancellationEvent,
      PrefetchHooks Function()
    >;
typedef $$RiskScoresTableCreateCompanionBuilder =
    RiskScoresCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      required String memberId,
      required int score,
      required String riskLevel,
      required double confidence,
      required DateTime calculatedAt,
      Value<String?> factorsJson,
      Value<int> rowid,
    });
typedef $$RiskScoresTableUpdateCompanionBuilder =
    RiskScoresCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> memberId,
      Value<int> score,
      Value<String> riskLevel,
      Value<double> confidence,
      Value<DateTime> calculatedAt,
      Value<String?> factorsJson,
      Value<int> rowid,
    });

class $$RiskScoresTableFilterComposer
    extends Composer<_$AppDatabase, $RiskScoresTable> {
  $$RiskScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RiskScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $RiskScoresTable> {
  $$RiskScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RiskScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $RiskScoresTable> {
  $$RiskScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get riskLevel =>
      $composableBuilder(column: $table.riskLevel, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get factorsJson => $composableBuilder(
    column: $table.factorsJson,
    builder: (column) => column,
  );
}

class $$RiskScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RiskScoresTable,
          RiskScore,
          $$RiskScoresTableFilterComposer,
          $$RiskScoresTableOrderingComposer,
          $$RiskScoresTableAnnotationComposer,
          $$RiskScoresTableCreateCompanionBuilder,
          $$RiskScoresTableUpdateCompanionBuilder,
          (
            RiskScore,
            BaseReferences<_$AppDatabase, $RiskScoresTable, RiskScore>,
          ),
          RiskScore,
          PrefetchHooks Function()
        > {
  $$RiskScoresTableTableManager(_$AppDatabase db, $RiskScoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RiskScoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RiskScoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RiskScoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<String> riskLevel = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> calculatedAt = const Value.absent(),
                Value<String?> factorsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RiskScoresCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                score: score,
                riskLevel: riskLevel,
                confidence: confidence,
                calculatedAt: calculatedAt,
                factorsJson: factorsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                required String memberId,
                required int score,
                required String riskLevel,
                required double confidence,
                required DateTime calculatedAt,
                Value<String?> factorsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RiskScoresCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                score: score,
                riskLevel: riskLevel,
                confidence: confidence,
                calculatedAt: calculatedAt,
                factorsJson: factorsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RiskScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RiskScoresTable,
      RiskScore,
      $$RiskScoresTableFilterComposer,
      $$RiskScoresTableOrderingComposer,
      $$RiskScoresTableAnnotationComposer,
      $$RiskScoresTableCreateCompanionBuilder,
      $$RiskScoresTableUpdateCompanionBuilder,
      (RiskScore, BaseReferences<_$AppDatabase, $RiskScoresTable, RiskScore>),
      RiskScore,
      PrefetchHooks Function()
    >;
typedef $$DailyMemberMetricsTableCreateCompanionBuilder =
    DailyMemberMetricsCompanion Function({
      required String organizationId,
      required String locationId,
      required String memberId,
      required DateTime date,
      Value<int> visits,
      Value<int?> daysSinceLastVisit,
      Value<double?> rolling7dVisits,
      Value<double?> rolling30dVisits,
      Value<double?> attendanceChange,
      Value<int?> membershipDaysRemaining,
      Value<int> rowid,
    });
typedef $$DailyMemberMetricsTableUpdateCompanionBuilder =
    DailyMemberMetricsCompanion Function({
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> memberId,
      Value<DateTime> date,
      Value<int> visits,
      Value<int?> daysSinceLastVisit,
      Value<double?> rolling7dVisits,
      Value<double?> rolling30dVisits,
      Value<double?> attendanceChange,
      Value<int?> membershipDaysRemaining,
      Value<int> rowid,
    });

class $$DailyMemberMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyMemberMetricsTable> {
  $$DailyMemberMetricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get visits => $composableBuilder(
    column: $table.visits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get daysSinceLastVisit => $composableBuilder(
    column: $table.daysSinceLastVisit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rolling7dVisits => $composableBuilder(
    column: $table.rolling7dVisits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rolling30dVisits => $composableBuilder(
    column: $table.rolling30dVisits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get attendanceChange => $composableBuilder(
    column: $table.attendanceChange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get membershipDaysRemaining => $composableBuilder(
    column: $table.membershipDaysRemaining,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyMemberMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyMemberMetricsTable> {
  $$DailyMemberMetricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visits => $composableBuilder(
    column: $table.visits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get daysSinceLastVisit => $composableBuilder(
    column: $table.daysSinceLastVisit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rolling7dVisits => $composableBuilder(
    column: $table.rolling7dVisits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rolling30dVisits => $composableBuilder(
    column: $table.rolling30dVisits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get attendanceChange => $composableBuilder(
    column: $table.attendanceChange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get membershipDaysRemaining => $composableBuilder(
    column: $table.membershipDaysRemaining,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyMemberMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyMemberMetricsTable> {
  $$DailyMemberMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get visits =>
      $composableBuilder(column: $table.visits, builder: (column) => column);

  GeneratedColumn<int> get daysSinceLastVisit => $composableBuilder(
    column: $table.daysSinceLastVisit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rolling7dVisits => $composableBuilder(
    column: $table.rolling7dVisits,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rolling30dVisits => $composableBuilder(
    column: $table.rolling30dVisits,
    builder: (column) => column,
  );

  GeneratedColumn<double> get attendanceChange => $composableBuilder(
    column: $table.attendanceChange,
    builder: (column) => column,
  );

  GeneratedColumn<int> get membershipDaysRemaining => $composableBuilder(
    column: $table.membershipDaysRemaining,
    builder: (column) => column,
  );
}

class $$DailyMemberMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyMemberMetricsTable,
          DailyMemberMetric,
          $$DailyMemberMetricsTableFilterComposer,
          $$DailyMemberMetricsTableOrderingComposer,
          $$DailyMemberMetricsTableAnnotationComposer,
          $$DailyMemberMetricsTableCreateCompanionBuilder,
          $$DailyMemberMetricsTableUpdateCompanionBuilder,
          (
            DailyMemberMetric,
            BaseReferences<
              _$AppDatabase,
              $DailyMemberMetricsTable,
              DailyMemberMetric
            >,
          ),
          DailyMemberMetric,
          PrefetchHooks Function()
        > {
  $$DailyMemberMetricsTableTableManager(
    _$AppDatabase db,
    $DailyMemberMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyMemberMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyMemberMetricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyMemberMetricsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> visits = const Value.absent(),
                Value<int?> daysSinceLastVisit = const Value.absent(),
                Value<double?> rolling7dVisits = const Value.absent(),
                Value<double?> rolling30dVisits = const Value.absent(),
                Value<double?> attendanceChange = const Value.absent(),
                Value<int?> membershipDaysRemaining = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyMemberMetricsCompanion(
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                date: date,
                visits: visits,
                daysSinceLastVisit: daysSinceLastVisit,
                rolling7dVisits: rolling7dVisits,
                rolling30dVisits: rolling30dVisits,
                attendanceChange: attendanceChange,
                membershipDaysRemaining: membershipDaysRemaining,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String organizationId,
                required String locationId,
                required String memberId,
                required DateTime date,
                Value<int> visits = const Value.absent(),
                Value<int?> daysSinceLastVisit = const Value.absent(),
                Value<double?> rolling7dVisits = const Value.absent(),
                Value<double?> rolling30dVisits = const Value.absent(),
                Value<double?> attendanceChange = const Value.absent(),
                Value<int?> membershipDaysRemaining = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyMemberMetricsCompanion.insert(
                organizationId: organizationId,
                locationId: locationId,
                memberId: memberId,
                date: date,
                visits: visits,
                daysSinceLastVisit: daysSinceLastVisit,
                rolling7dVisits: rolling7dVisits,
                rolling30dVisits: rolling30dVisits,
                attendanceChange: attendanceChange,
                membershipDaysRemaining: membershipDaysRemaining,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyMemberMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyMemberMetricsTable,
      DailyMemberMetric,
      $$DailyMemberMetricsTableFilterComposer,
      $$DailyMemberMetricsTableOrderingComposer,
      $$DailyMemberMetricsTableAnnotationComposer,
      $$DailyMemberMetricsTableCreateCompanionBuilder,
      $$DailyMemberMetricsTableUpdateCompanionBuilder,
      (
        DailyMemberMetric,
        BaseReferences<
          _$AppDatabase,
          $DailyMemberMetricsTable,
          DailyMemberMetric
        >,
      ),
      DailyMemberMetric,
      PrefetchHooks Function()
    >;
typedef $$GymDailyMetricsTableCreateCompanionBuilder =
    GymDailyMetricsCompanion Function({
      required String organizationId,
      required String locationId,
      required DateTime date,
      Value<int> activeMembers,
      Value<int> visits,
      Value<int> uniqueVisitors,
      Value<int> trials,
      Value<int> trialConversions,
      Value<int> renewals,
      Value<int> cancellations,
      Value<int> rowid,
    });
typedef $$GymDailyMetricsTableUpdateCompanionBuilder =
    GymDailyMetricsCompanion Function({
      Value<String> organizationId,
      Value<String> locationId,
      Value<DateTime> date,
      Value<int> activeMembers,
      Value<int> visits,
      Value<int> uniqueVisitors,
      Value<int> trials,
      Value<int> trialConversions,
      Value<int> renewals,
      Value<int> cancellations,
      Value<int> rowid,
    });

class $$GymDailyMetricsTableFilterComposer
    extends Composer<_$AppDatabase, $GymDailyMetricsTable> {
  $$GymDailyMetricsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeMembers => $composableBuilder(
    column: $table.activeMembers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get visits => $composableBuilder(
    column: $table.visits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uniqueVisitors => $composableBuilder(
    column: $table.uniqueVisitors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trials => $composableBuilder(
    column: $table.trials,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trialConversions => $composableBuilder(
    column: $table.trialConversions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get renewals => $composableBuilder(
    column: $table.renewals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cancellations => $composableBuilder(
    column: $table.cancellations,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GymDailyMetricsTableOrderingComposer
    extends Composer<_$AppDatabase, $GymDailyMetricsTable> {
  $$GymDailyMetricsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeMembers => $composableBuilder(
    column: $table.activeMembers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visits => $composableBuilder(
    column: $table.visits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uniqueVisitors => $composableBuilder(
    column: $table.uniqueVisitors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trials => $composableBuilder(
    column: $table.trials,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trialConversions => $composableBuilder(
    column: $table.trialConversions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get renewals => $composableBuilder(
    column: $table.renewals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cancellations => $composableBuilder(
    column: $table.cancellations,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GymDailyMetricsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GymDailyMetricsTable> {
  $$GymDailyMetricsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get activeMembers => $composableBuilder(
    column: $table.activeMembers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get visits =>
      $composableBuilder(column: $table.visits, builder: (column) => column);

  GeneratedColumn<int> get uniqueVisitors => $composableBuilder(
    column: $table.uniqueVisitors,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trials =>
      $composableBuilder(column: $table.trials, builder: (column) => column);

  GeneratedColumn<int> get trialConversions => $composableBuilder(
    column: $table.trialConversions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get renewals =>
      $composableBuilder(column: $table.renewals, builder: (column) => column);

  GeneratedColumn<int> get cancellations => $composableBuilder(
    column: $table.cancellations,
    builder: (column) => column,
  );
}

class $$GymDailyMetricsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GymDailyMetricsTable,
          GymDailyMetric,
          $$GymDailyMetricsTableFilterComposer,
          $$GymDailyMetricsTableOrderingComposer,
          $$GymDailyMetricsTableAnnotationComposer,
          $$GymDailyMetricsTableCreateCompanionBuilder,
          $$GymDailyMetricsTableUpdateCompanionBuilder,
          (
            GymDailyMetric,
            BaseReferences<
              _$AppDatabase,
              $GymDailyMetricsTable,
              GymDailyMetric
            >,
          ),
          GymDailyMetric,
          PrefetchHooks Function()
        > {
  $$GymDailyMetricsTableTableManager(
    _$AppDatabase db,
    $GymDailyMetricsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GymDailyMetricsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GymDailyMetricsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GymDailyMetricsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> activeMembers = const Value.absent(),
                Value<int> visits = const Value.absent(),
                Value<int> uniqueVisitors = const Value.absent(),
                Value<int> trials = const Value.absent(),
                Value<int> trialConversions = const Value.absent(),
                Value<int> renewals = const Value.absent(),
                Value<int> cancellations = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GymDailyMetricsCompanion(
                organizationId: organizationId,
                locationId: locationId,
                date: date,
                activeMembers: activeMembers,
                visits: visits,
                uniqueVisitors: uniqueVisitors,
                trials: trials,
                trialConversions: trialConversions,
                renewals: renewals,
                cancellations: cancellations,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String organizationId,
                required String locationId,
                required DateTime date,
                Value<int> activeMembers = const Value.absent(),
                Value<int> visits = const Value.absent(),
                Value<int> uniqueVisitors = const Value.absent(),
                Value<int> trials = const Value.absent(),
                Value<int> trialConversions = const Value.absent(),
                Value<int> renewals = const Value.absent(),
                Value<int> cancellations = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GymDailyMetricsCompanion.insert(
                organizationId: organizationId,
                locationId: locationId,
                date: date,
                activeMembers: activeMembers,
                visits: visits,
                uniqueVisitors: uniqueVisitors,
                trials: trials,
                trialConversions: trialConversions,
                renewals: renewals,
                cancellations: cancellations,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GymDailyMetricsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GymDailyMetricsTable,
      GymDailyMetric,
      $$GymDailyMetricsTableFilterComposer,
      $$GymDailyMetricsTableOrderingComposer,
      $$GymDailyMetricsTableAnnotationComposer,
      $$GymDailyMetricsTableCreateCompanionBuilder,
      $$GymDailyMetricsTableUpdateCompanionBuilder,
      (
        GymDailyMetric,
        BaseReferences<_$AppDatabase, $GymDailyMetricsTable, GymDailyMetric>,
      ),
      GymDailyMetric,
      PrefetchHooks Function()
    >;
typedef $$IntegrationSyncRunsTableCreateCompanionBuilder =
    IntegrationSyncRunsCompanion Function({
      required String id,
      required String organizationId,
      required String locationId,
      required String sourceId,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required String status,
      Value<int> recordsRead,
      Value<int> recordsCreated,
      Value<int> recordsUpdated,
      Value<int> recordsSkipped,
      Value<int> errorCount,
      Value<String?> errorSummary,
      Value<int> rowid,
    });
typedef $$IntegrationSyncRunsTableUpdateCompanionBuilder =
    IntegrationSyncRunsCompanion Function({
      Value<String> id,
      Value<String> organizationId,
      Value<String> locationId,
      Value<String> sourceId,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
      Value<int> recordsRead,
      Value<int> recordsCreated,
      Value<int> recordsUpdated,
      Value<int> recordsSkipped,
      Value<int> errorCount,
      Value<String?> errorSummary,
      Value<int> rowid,
    });

class $$IntegrationSyncRunsTableFilterComposer
    extends Composer<_$AppDatabase, $IntegrationSyncRunsTable> {
  $$IntegrationSyncRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordsRead => $composableBuilder(
    column: $table.recordsRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordsCreated => $composableBuilder(
    column: $table.recordsCreated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordsUpdated => $composableBuilder(
    column: $table.recordsUpdated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordsSkipped => $composableBuilder(
    column: $table.recordsSkipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get errorCount => $composableBuilder(
    column: $table.errorCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IntegrationSyncRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $IntegrationSyncRunsTable> {
  $$IntegrationSyncRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordsRead => $composableBuilder(
    column: $table.recordsRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordsCreated => $composableBuilder(
    column: $table.recordsCreated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordsUpdated => $composableBuilder(
    column: $table.recordsUpdated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordsSkipped => $composableBuilder(
    column: $table.recordsSkipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get errorCount => $composableBuilder(
    column: $table.errorCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IntegrationSyncRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IntegrationSyncRunsTable> {
  $$IntegrationSyncRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get recordsRead => $composableBuilder(
    column: $table.recordsRead,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recordsCreated => $composableBuilder(
    column: $table.recordsCreated,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recordsUpdated => $composableBuilder(
    column: $table.recordsUpdated,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recordsSkipped => $composableBuilder(
    column: $table.recordsSkipped,
    builder: (column) => column,
  );

  GeneratedColumn<int> get errorCount => $composableBuilder(
    column: $table.errorCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => column,
  );
}

class $$IntegrationSyncRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IntegrationSyncRunsTable,
          IntegrationSyncRun,
          $$IntegrationSyncRunsTableFilterComposer,
          $$IntegrationSyncRunsTableOrderingComposer,
          $$IntegrationSyncRunsTableAnnotationComposer,
          $$IntegrationSyncRunsTableCreateCompanionBuilder,
          $$IntegrationSyncRunsTableUpdateCompanionBuilder,
          (
            IntegrationSyncRun,
            BaseReferences<
              _$AppDatabase,
              $IntegrationSyncRunsTable,
              IntegrationSyncRun
            >,
          ),
          IntegrationSyncRun,
          PrefetchHooks Function()
        > {
  $$IntegrationSyncRunsTableTableManager(
    _$AppDatabase db,
    $IntegrationSyncRunsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IntegrationSyncRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IntegrationSyncRunsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$IntegrationSyncRunsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> organizationId = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> recordsRead = const Value.absent(),
                Value<int> recordsCreated = const Value.absent(),
                Value<int> recordsUpdated = const Value.absent(),
                Value<int> recordsSkipped = const Value.absent(),
                Value<int> errorCount = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IntegrationSyncRunsCompanion(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                sourceId: sourceId,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                recordsRead: recordsRead,
                recordsCreated: recordsCreated,
                recordsUpdated: recordsUpdated,
                recordsSkipped: recordsSkipped,
                errorCount: errorCount,
                errorSummary: errorSummary,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String organizationId,
                required String locationId,
                required String sourceId,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required String status,
                Value<int> recordsRead = const Value.absent(),
                Value<int> recordsCreated = const Value.absent(),
                Value<int> recordsUpdated = const Value.absent(),
                Value<int> recordsSkipped = const Value.absent(),
                Value<int> errorCount = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IntegrationSyncRunsCompanion.insert(
                id: id,
                organizationId: organizationId,
                locationId: locationId,
                sourceId: sourceId,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                recordsRead: recordsRead,
                recordsCreated: recordsCreated,
                recordsUpdated: recordsUpdated,
                recordsSkipped: recordsSkipped,
                errorCount: errorCount,
                errorSummary: errorSummary,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IntegrationSyncRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IntegrationSyncRunsTable,
      IntegrationSyncRun,
      $$IntegrationSyncRunsTableFilterComposer,
      $$IntegrationSyncRunsTableOrderingComposer,
      $$IntegrationSyncRunsTableAnnotationComposer,
      $$IntegrationSyncRunsTableCreateCompanionBuilder,
      $$IntegrationSyncRunsTableUpdateCompanionBuilder,
      (
        IntegrationSyncRun,
        BaseReferences<
          _$AppDatabase,
          $IntegrationSyncRunsTable,
          IntegrationSyncRun
        >,
      ),
      IntegrationSyncRun,
      PrefetchHooks Function()
    >;
typedef $$NotificationPreferencesTableCreateCompanionBuilder =
    NotificationPreferencesCompanion Function({
      required String organizationId,
      required String userId,
      required String key,
      Value<bool> enabled,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationPreferencesTableUpdateCompanionBuilder =
    NotificationPreferencesCompanion Function({
      Value<String> organizationId,
      Value<String> userId,
      Value<String> key,
      Value<bool> enabled,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$NotificationPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTable> {
  $$NotificationPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationPreferencesTable,
          NotificationPreference,
          $$NotificationPreferencesTableFilterComposer,
          $$NotificationPreferencesTableOrderingComposer,
          $$NotificationPreferencesTableAnnotationComposer,
          $$NotificationPreferencesTableCreateCompanionBuilder,
          $$NotificationPreferencesTableUpdateCompanionBuilder,
          (
            NotificationPreference,
            BaseReferences<
              _$AppDatabase,
              $NotificationPreferencesTable,
              NotificationPreference
            >,
          ),
          NotificationPreference,
          PrefetchHooks Function()
        > {
  $$NotificationPreferencesTableTableManager(
    _$AppDatabase db,
    $NotificationPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPreferencesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationPreferencesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationPreferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> organizationId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationPreferencesCompanion(
                organizationId: organizationId,
                userId: userId,
                key: key,
                enabled: enabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String organizationId,
                required String userId,
                required String key,
                Value<bool> enabled = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationPreferencesCompanion.insert(
                organizationId: organizationId,
                userId: userId,
                key: key,
                enabled: enabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationPreferencesTable,
      NotificationPreference,
      $$NotificationPreferencesTableFilterComposer,
      $$NotificationPreferencesTableOrderingComposer,
      $$NotificationPreferencesTableAnnotationComposer,
      $$NotificationPreferencesTableCreateCompanionBuilder,
      $$NotificationPreferencesTableUpdateCompanionBuilder,
      (
        NotificationPreference,
        BaseReferences<
          _$AppDatabase,
          $NotificationPreferencesTable,
          NotificationPreference
        >,
      ),
      NotificationPreference,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      required String id,
      Value<String?> organizationId,
      Value<String?> userId,
      required String action,
      Value<String?> entityType,
      Value<String?> entityId,
      required DateTime occurredAt,
      Value<String?> metadataJson,
      Value<int> rowid,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<String> id,
      Value<String?> organizationId,
      Value<String?> userId,
      Value<String> action,
      Value<String?> entityType,
      Value<String?> entityId,
      Value<DateTime> occurredAt,
      Value<String?> metadataJson,
      Value<int> rowid,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> organizationId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                organizationId: organizationId,
                userId: userId,
                action: action,
                entityType: entityType,
                entityId: entityId,
                occurredAt: occurredAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> organizationId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                required String action,
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                required DateTime occurredAt,
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                organizationId: organizationId,
                userId: userId,
                action: action,
                entityType: entityType,
                entityId: entityId,
                occurredAt: occurredAt,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;
typedef $$AppMetaEntriesTableCreateCompanionBuilder =
    AppMetaEntriesCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppMetaEntriesTableUpdateCompanionBuilder =
    AppMetaEntriesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppMetaEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaEntriesTable> {
  $$AppMetaEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaEntriesTable> {
  $$AppMetaEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaEntriesTable> {
  $$AppMetaEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppMetaEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaEntriesTable,
          AppMetaEntry,
          $$AppMetaEntriesTableFilterComposer,
          $$AppMetaEntriesTableOrderingComposer,
          $$AppMetaEntriesTableAnnotationComposer,
          $$AppMetaEntriesTableCreateCompanionBuilder,
          $$AppMetaEntriesTableUpdateCompanionBuilder,
          (
            AppMetaEntry,
            BaseReferences<_$AppDatabase, $AppMetaEntriesTable, AppMetaEntry>,
          ),
          AppMetaEntry,
          PrefetchHooks Function()
        > {
  $$AppMetaEntriesTableTableManager(
    _$AppDatabase db,
    $AppMetaEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetaEntriesCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppMetaEntriesCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaEntriesTable,
      AppMetaEntry,
      $$AppMetaEntriesTableFilterComposer,
      $$AppMetaEntriesTableOrderingComposer,
      $$AppMetaEntriesTableAnnotationComposer,
      $$AppMetaEntriesTableCreateCompanionBuilder,
      $$AppMetaEntriesTableUpdateCompanionBuilder,
      (
        AppMetaEntry,
        BaseReferences<_$AppDatabase, $AppMetaEntriesTable, AppMetaEntry>,
      ),
      AppMetaEntry,
      PrefetchHooks Function()
    >;
typedef $$SecurityStatesTableCreateCompanionBuilder =
    SecurityStatesCompanion Function({
      required String id,
      required String pinHash,
      required String pinSalt,
      required String pinAlgo,
      Value<int> failedAttempts,
      Value<DateTime?> lockoutUntilUtc,
      Value<bool> biometricUnlockEnabled,
      Value<int> autoLockSeconds,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SecurityStatesTableUpdateCompanionBuilder =
    SecurityStatesCompanion Function({
      Value<String> id,
      Value<String> pinHash,
      Value<String> pinSalt,
      Value<String> pinAlgo,
      Value<int> failedAttempts,
      Value<DateTime?> lockoutUntilUtc,
      Value<bool> biometricUnlockEnabled,
      Value<int> autoLockSeconds,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SecurityStatesTableFilterComposer
    extends Composer<_$AppDatabase, $SecurityStatesTable> {
  $$SecurityStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinSalt => $composableBuilder(
    column: $table.pinSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinAlgo => $composableBuilder(
    column: $table.pinAlgo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failedAttempts => $composableBuilder(
    column: $table.failedAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lockoutUntilUtc => $composableBuilder(
    column: $table.lockoutUntilUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get biometricUnlockEnabled => $composableBuilder(
    column: $table.biometricUnlockEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoLockSeconds => $composableBuilder(
    column: $table.autoLockSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SecurityStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $SecurityStatesTable> {
  $$SecurityStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinSalt => $composableBuilder(
    column: $table.pinSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinAlgo => $composableBuilder(
    column: $table.pinAlgo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
    column: $table.failedAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lockoutUntilUtc => $composableBuilder(
    column: $table.lockoutUntilUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get biometricUnlockEnabled => $composableBuilder(
    column: $table.biometricUnlockEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoLockSeconds => $composableBuilder(
    column: $table.autoLockSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SecurityStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SecurityStatesTable> {
  $$SecurityStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<String> get pinSalt =>
      $composableBuilder(column: $table.pinSalt, builder: (column) => column);

  GeneratedColumn<String> get pinAlgo =>
      $composableBuilder(column: $table.pinAlgo, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
    column: $table.failedAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lockoutUntilUtc => $composableBuilder(
    column: $table.lockoutUntilUtc,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get biometricUnlockEnabled => $composableBuilder(
    column: $table.biometricUnlockEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoLockSeconds => $composableBuilder(
    column: $table.autoLockSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SecurityStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SecurityStatesTable,
          SecurityState,
          $$SecurityStatesTableFilterComposer,
          $$SecurityStatesTableOrderingComposer,
          $$SecurityStatesTableAnnotationComposer,
          $$SecurityStatesTableCreateCompanionBuilder,
          $$SecurityStatesTableUpdateCompanionBuilder,
          (
            SecurityState,
            BaseReferences<_$AppDatabase, $SecurityStatesTable, SecurityState>,
          ),
          SecurityState,
          PrefetchHooks Function()
        > {
  $$SecurityStatesTableTableManager(
    _$AppDatabase db,
    $SecurityStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SecurityStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SecurityStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SecurityStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pinHash = const Value.absent(),
                Value<String> pinSalt = const Value.absent(),
                Value<String> pinAlgo = const Value.absent(),
                Value<int> failedAttempts = const Value.absent(),
                Value<DateTime?> lockoutUntilUtc = const Value.absent(),
                Value<bool> biometricUnlockEnabled = const Value.absent(),
                Value<int> autoLockSeconds = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SecurityStatesCompanion(
                id: id,
                pinHash: pinHash,
                pinSalt: pinSalt,
                pinAlgo: pinAlgo,
                failedAttempts: failedAttempts,
                lockoutUntilUtc: lockoutUntilUtc,
                biometricUnlockEnabled: biometricUnlockEnabled,
                autoLockSeconds: autoLockSeconds,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pinHash,
                required String pinSalt,
                required String pinAlgo,
                Value<int> failedAttempts = const Value.absent(),
                Value<DateTime?> lockoutUntilUtc = const Value.absent(),
                Value<bool> biometricUnlockEnabled = const Value.absent(),
                Value<int> autoLockSeconds = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SecurityStatesCompanion.insert(
                id: id,
                pinHash: pinHash,
                pinSalt: pinSalt,
                pinAlgo: pinAlgo,
                failedAttempts: failedAttempts,
                lockoutUntilUtc: lockoutUntilUtc,
                biometricUnlockEnabled: biometricUnlockEnabled,
                autoLockSeconds: autoLockSeconds,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SecurityStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SecurityStatesTable,
      SecurityState,
      $$SecurityStatesTableFilterComposer,
      $$SecurityStatesTableOrderingComposer,
      $$SecurityStatesTableAnnotationComposer,
      $$SecurityStatesTableCreateCompanionBuilder,
      $$SecurityStatesTableUpdateCompanionBuilder,
      (
        SecurityState,
        BaseReferences<_$AppDatabase, $SecurityStatesTable, SecurityState>,
      ),
      SecurityState,
      PrefetchHooks Function()
    >;
typedef $$BackupRunsTableCreateCompanionBuilder =
    BackupRunsCompanion Function({
      required String id,
      Value<String?> organizationId,
      required DateTime createdAt,
      Value<DateTime?> completedAt,
      required String direction,
      required String status,
      Value<String?> fileName,
      Value<String?> formatVersion,
      Value<String?> checksum,
      Value<String?> appVersion,
      Value<String?> errorCode,
      Value<String?> errorSummary,
      Value<String?> createdByUserId,
      Value<int> rowid,
    });
typedef $$BackupRunsTableUpdateCompanionBuilder =
    BackupRunsCompanion Function({
      Value<String> id,
      Value<String?> organizationId,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
      Value<String> direction,
      Value<String> status,
      Value<String?> fileName,
      Value<String?> formatVersion,
      Value<String?> checksum,
      Value<String?> appVersion,
      Value<String?> errorCode,
      Value<String?> errorSummary,
      Value<String?> createdByUserId,
      Value<int> rowid,
    });

class $$BackupRunsTableFilterComposer
    extends Composer<_$AppDatabase, $BackupRunsTable> {
  $$BackupRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupRunsTable> {
  $$BackupRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checksum => $composableBuilder(
    column: $table.checksum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorCode => $composableBuilder(
    column: $table.errorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupRunsTable> {
  $$BackupRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checksum =>
      $composableBuilder(column: $table.checksum, builder: (column) => column);

  GeneratedColumn<String> get appVersion => $composableBuilder(
    column: $table.appVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorCode =>
      $composableBuilder(column: $table.errorCode, builder: (column) => column);

  GeneratedColumn<String> get errorSummary => $composableBuilder(
    column: $table.errorSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdByUserId => $composableBuilder(
    column: $table.createdByUserId,
    builder: (column) => column,
  );
}

class $$BackupRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupRunsTable,
          BackupRun,
          $$BackupRunsTableFilterComposer,
          $$BackupRunsTableOrderingComposer,
          $$BackupRunsTableAnnotationComposer,
          $$BackupRunsTableCreateCompanionBuilder,
          $$BackupRunsTableUpdateCompanionBuilder,
          (
            BackupRun,
            BaseReferences<_$AppDatabase, $BackupRunsTable, BackupRun>,
          ),
          BackupRun,
          PrefetchHooks Function()
        > {
  $$BackupRunsTableTableManager(_$AppDatabase db, $BackupRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> organizationId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> fileName = const Value.absent(),
                Value<String?> formatVersion = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<String?> appVersion = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
                Value<String?> createdByUserId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupRunsCompanion(
                id: id,
                organizationId: organizationId,
                createdAt: createdAt,
                completedAt: completedAt,
                direction: direction,
                status: status,
                fileName: fileName,
                formatVersion: formatVersion,
                checksum: checksum,
                appVersion: appVersion,
                errorCode: errorCode,
                errorSummary: errorSummary,
                createdByUserId: createdByUserId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> organizationId = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required String direction,
                required String status,
                Value<String?> fileName = const Value.absent(),
                Value<String?> formatVersion = const Value.absent(),
                Value<String?> checksum = const Value.absent(),
                Value<String?> appVersion = const Value.absent(),
                Value<String?> errorCode = const Value.absent(),
                Value<String?> errorSummary = const Value.absent(),
                Value<String?> createdByUserId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupRunsCompanion.insert(
                id: id,
                organizationId: organizationId,
                createdAt: createdAt,
                completedAt: completedAt,
                direction: direction,
                status: status,
                fileName: fileName,
                formatVersion: formatVersion,
                checksum: checksum,
                appVersion: appVersion,
                errorCode: errorCode,
                errorSummary: errorSummary,
                createdByUserId: createdByUserId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupRunsTable,
      BackupRun,
      $$BackupRunsTableFilterComposer,
      $$BackupRunsTableOrderingComposer,
      $$BackupRunsTableAnnotationComposer,
      $$BackupRunsTableCreateCompanionBuilder,
      $$BackupRunsTableUpdateCompanionBuilder,
      (BackupRun, BaseReferences<_$AppDatabase, $BackupRunsTable, BackupRun>),
      BackupRun,
      PrefetchHooks Function()
    >;
typedef $$BackupReminderSettingsTableCreateCompanionBuilder =
    BackupReminderSettingsCompanion Function({
      required String organizationId,
      Value<int> intervalDays,
      Value<bool> enabled,
      Value<DateTime?> lastRemindedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BackupReminderSettingsTableUpdateCompanionBuilder =
    BackupReminderSettingsCompanion Function({
      Value<String> organizationId,
      Value<int> intervalDays,
      Value<bool> enabled,
      Value<DateTime?> lastRemindedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BackupReminderSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $BackupReminderSettingsTable> {
  $$BackupReminderSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastRemindedAt => $composableBuilder(
    column: $table.lastRemindedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupReminderSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupReminderSettingsTable> {
  $$BackupReminderSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastRemindedAt => $composableBuilder(
    column: $table.lastRemindedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupReminderSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupReminderSettingsTable> {
  $$BackupReminderSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get organizationId => $composableBuilder(
    column: $table.organizationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get lastRemindedAt => $composableBuilder(
    column: $table.lastRemindedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BackupReminderSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupReminderSettingsTable,
          BackupReminderSetting,
          $$BackupReminderSettingsTableFilterComposer,
          $$BackupReminderSettingsTableOrderingComposer,
          $$BackupReminderSettingsTableAnnotationComposer,
          $$BackupReminderSettingsTableCreateCompanionBuilder,
          $$BackupReminderSettingsTableUpdateCompanionBuilder,
          (
            BackupReminderSetting,
            BaseReferences<
              _$AppDatabase,
              $BackupReminderSettingsTable,
              BackupReminderSetting
            >,
          ),
          BackupReminderSetting,
          PrefetchHooks Function()
        > {
  $$BackupReminderSettingsTableTableManager(
    _$AppDatabase db,
    $BackupReminderSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupReminderSettingsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BackupReminderSettingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BackupReminderSettingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> organizationId = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime?> lastRemindedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupReminderSettingsCompanion(
                organizationId: organizationId,
                intervalDays: intervalDays,
                enabled: enabled,
                lastRemindedAt: lastRemindedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String organizationId,
                Value<int> intervalDays = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime?> lastRemindedAt = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BackupReminderSettingsCompanion.insert(
                organizationId: organizationId,
                intervalDays: intervalDays,
                enabled: enabled,
                lastRemindedAt: lastRemindedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupReminderSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupReminderSettingsTable,
      BackupReminderSetting,
      $$BackupReminderSettingsTableFilterComposer,
      $$BackupReminderSettingsTableOrderingComposer,
      $$BackupReminderSettingsTableAnnotationComposer,
      $$BackupReminderSettingsTableCreateCompanionBuilder,
      $$BackupReminderSettingsTableUpdateCompanionBuilder,
      (
        BackupReminderSetting,
        BaseReferences<
          _$AppDatabase,
          $BackupReminderSettingsTable,
          BackupReminderSetting
        >,
      ),
      BackupReminderSetting,
      PrefetchHooks Function()
    >;
typedef $$LocationSettingsTableCreateCompanionBuilder =
    LocationSettingsCompanion Function({
      required String locationId,
      Value<int> inactivityMonitorDays,
      Value<int> inactivityFollowUpDays,
      Value<int> inactivityHighRiskDays,
      Value<int> inactivityCriticalDays,
      Value<int> staleImportHours,
      Value<String?> gymPhone,
      Value<int?> peakHighAttendance,
      Value<String?> closureDatesJson,
      Value<String?> riskWeightsJson,
      Value<int> trialDefaultDays,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$LocationSettingsTableUpdateCompanionBuilder =
    LocationSettingsCompanion Function({
      Value<String> locationId,
      Value<int> inactivityMonitorDays,
      Value<int> inactivityFollowUpDays,
      Value<int> inactivityHighRiskDays,
      Value<int> inactivityCriticalDays,
      Value<int> staleImportHours,
      Value<String?> gymPhone,
      Value<int?> peakHighAttendance,
      Value<String?> closureDatesJson,
      Value<String?> riskWeightsJson,
      Value<int> trialDefaultDays,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$LocationSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationSettingsTable> {
  $$LocationSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inactivityMonitorDays => $composableBuilder(
    column: $table.inactivityMonitorDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inactivityFollowUpDays => $composableBuilder(
    column: $table.inactivityFollowUpDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inactivityHighRiskDays => $composableBuilder(
    column: $table.inactivityHighRiskDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inactivityCriticalDays => $composableBuilder(
    column: $table.inactivityCriticalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get staleImportHours => $composableBuilder(
    column: $table.staleImportHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymPhone => $composableBuilder(
    column: $table.gymPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get peakHighAttendance => $composableBuilder(
    column: $table.peakHighAttendance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get closureDatesJson => $composableBuilder(
    column: $table.closureDatesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskWeightsJson => $composableBuilder(
    column: $table.riskWeightsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trialDefaultDays => $composableBuilder(
    column: $table.trialDefaultDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationSettingsTable> {
  $$LocationSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inactivityMonitorDays => $composableBuilder(
    column: $table.inactivityMonitorDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inactivityFollowUpDays => $composableBuilder(
    column: $table.inactivityFollowUpDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inactivityHighRiskDays => $composableBuilder(
    column: $table.inactivityHighRiskDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inactivityCriticalDays => $composableBuilder(
    column: $table.inactivityCriticalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get staleImportHours => $composableBuilder(
    column: $table.staleImportHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymPhone => $composableBuilder(
    column: $table.gymPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get peakHighAttendance => $composableBuilder(
    column: $table.peakHighAttendance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get closureDatesJson => $composableBuilder(
    column: $table.closureDatesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskWeightsJson => $composableBuilder(
    column: $table.riskWeightsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trialDefaultDays => $composableBuilder(
    column: $table.trialDefaultDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationSettingsTable> {
  $$LocationSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inactivityMonitorDays => $composableBuilder(
    column: $table.inactivityMonitorDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inactivityFollowUpDays => $composableBuilder(
    column: $table.inactivityFollowUpDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inactivityHighRiskDays => $composableBuilder(
    column: $table.inactivityHighRiskDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inactivityCriticalDays => $composableBuilder(
    column: $table.inactivityCriticalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get staleImportHours => $composableBuilder(
    column: $table.staleImportHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gymPhone =>
      $composableBuilder(column: $table.gymPhone, builder: (column) => column);

  GeneratedColumn<int> get peakHighAttendance => $composableBuilder(
    column: $table.peakHighAttendance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get closureDatesJson => $composableBuilder(
    column: $table.closureDatesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get riskWeightsJson => $composableBuilder(
    column: $table.riskWeightsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trialDefaultDays => $composableBuilder(
    column: $table.trialDefaultDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocationSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationSettingsTable,
          LocationSetting,
          $$LocationSettingsTableFilterComposer,
          $$LocationSettingsTableOrderingComposer,
          $$LocationSettingsTableAnnotationComposer,
          $$LocationSettingsTableCreateCompanionBuilder,
          $$LocationSettingsTableUpdateCompanionBuilder,
          (
            LocationSetting,
            BaseReferences<
              _$AppDatabase,
              $LocationSettingsTable,
              LocationSetting
            >,
          ),
          LocationSetting,
          PrefetchHooks Function()
        > {
  $$LocationSettingsTableTableManager(
    _$AppDatabase db,
    $LocationSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> locationId = const Value.absent(),
                Value<int> inactivityMonitorDays = const Value.absent(),
                Value<int> inactivityFollowUpDays = const Value.absent(),
                Value<int> inactivityHighRiskDays = const Value.absent(),
                Value<int> inactivityCriticalDays = const Value.absent(),
                Value<int> staleImportHours = const Value.absent(),
                Value<String?> gymPhone = const Value.absent(),
                Value<int?> peakHighAttendance = const Value.absent(),
                Value<String?> closureDatesJson = const Value.absent(),
                Value<String?> riskWeightsJson = const Value.absent(),
                Value<int> trialDefaultDays = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationSettingsCompanion(
                locationId: locationId,
                inactivityMonitorDays: inactivityMonitorDays,
                inactivityFollowUpDays: inactivityFollowUpDays,
                inactivityHighRiskDays: inactivityHighRiskDays,
                inactivityCriticalDays: inactivityCriticalDays,
                staleImportHours: staleImportHours,
                gymPhone: gymPhone,
                peakHighAttendance: peakHighAttendance,
                closureDatesJson: closureDatesJson,
                riskWeightsJson: riskWeightsJson,
                trialDefaultDays: trialDefaultDays,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String locationId,
                Value<int> inactivityMonitorDays = const Value.absent(),
                Value<int> inactivityFollowUpDays = const Value.absent(),
                Value<int> inactivityHighRiskDays = const Value.absent(),
                Value<int> inactivityCriticalDays = const Value.absent(),
                Value<int> staleImportHours = const Value.absent(),
                Value<String?> gymPhone = const Value.absent(),
                Value<int?> peakHighAttendance = const Value.absent(),
                Value<String?> closureDatesJson = const Value.absent(),
                Value<String?> riskWeightsJson = const Value.absent(),
                Value<int> trialDefaultDays = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocationSettingsCompanion.insert(
                locationId: locationId,
                inactivityMonitorDays: inactivityMonitorDays,
                inactivityFollowUpDays: inactivityFollowUpDays,
                inactivityHighRiskDays: inactivityHighRiskDays,
                inactivityCriticalDays: inactivityCriticalDays,
                staleImportHours: staleImportHours,
                gymPhone: gymPhone,
                peakHighAttendance: peakHighAttendance,
                closureDatesJson: closureDatesJson,
                riskWeightsJson: riskWeightsJson,
                trialDefaultDays: trialDefaultDays,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationSettingsTable,
      LocationSetting,
      $$LocationSettingsTableFilterComposer,
      $$LocationSettingsTableOrderingComposer,
      $$LocationSettingsTableAnnotationComposer,
      $$LocationSettingsTableCreateCompanionBuilder,
      $$LocationSettingsTableUpdateCompanionBuilder,
      (
        LocationSetting,
        BaseReferences<_$AppDatabase, $LocationSettingsTable, LocationSetting>,
      ),
      LocationSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OrganizationsTableTableManager get organizations =>
      $$OrganizationsTableTableManager(_db, _db.organizations);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$OrganizationMembersTableTableManager get organizationMembers =>
      $$OrganizationMembersTableTableManager(_db, _db.organizationMembers);
  $$LocationAccessTableTableManager get locationAccess =>
      $$LocationAccessTableTableManager(_db, _db.locationAccess);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$MembershipPlansTableTableManager get membershipPlans =>
      $$MembershipPlansTableTableManager(_db, _db.membershipPlans);
  $$MembershipsTableTableManager get memberships =>
      $$MembershipsTableTableManager(_db, _db.memberships);
  $$AttendanceSourcesTableTableManager get attendanceSources =>
      $$AttendanceSourcesTableTableManager(_db, _db.attendanceSources);
  $$AttendanceEventsTableTableManager get attendanceEvents =>
      $$AttendanceEventsTableTableManager(_db, _db.attendanceEvents);
  $$TrialsTableTableManager get trials =>
      $$TrialsTableTableManager(_db, _db.trials);
  $$FollowUpsTableTableManager get followUps =>
      $$FollowUpsTableTableManager(_db, _db.followUps);
  $$MessageTemplatesTableTableManager get messageTemplates =>
      $$MessageTemplatesTableTableManager(_db, _db.messageTemplates);
  $$CancellationEventsTableTableManager get cancellationEvents =>
      $$CancellationEventsTableTableManager(_db, _db.cancellationEvents);
  $$RiskScoresTableTableManager get riskScores =>
      $$RiskScoresTableTableManager(_db, _db.riskScores);
  $$DailyMemberMetricsTableTableManager get dailyMemberMetrics =>
      $$DailyMemberMetricsTableTableManager(_db, _db.dailyMemberMetrics);
  $$GymDailyMetricsTableTableManager get gymDailyMetrics =>
      $$GymDailyMetricsTableTableManager(_db, _db.gymDailyMetrics);
  $$IntegrationSyncRunsTableTableManager get integrationSyncRuns =>
      $$IntegrationSyncRunsTableTableManager(_db, _db.integrationSyncRuns);
  $$NotificationPreferencesTableTableManager get notificationPreferences =>
      $$NotificationPreferencesTableTableManager(
        _db,
        _db.notificationPreferences,
      );
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$AppMetaEntriesTableTableManager get appMetaEntries =>
      $$AppMetaEntriesTableTableManager(_db, _db.appMetaEntries);
  $$SecurityStatesTableTableManager get securityStates =>
      $$SecurityStatesTableTableManager(_db, _db.securityStates);
  $$BackupRunsTableTableManager get backupRuns =>
      $$BackupRunsTableTableManager(_db, _db.backupRuns);
  $$BackupReminderSettingsTableTableManager get backupReminderSettings =>
      $$BackupReminderSettingsTableTableManager(
        _db,
        _db.backupReminderSettings,
      );
  $$LocationSettingsTableTableManager get locationSettings =>
      $$LocationSettingsTableTableManager(_db, _db.locationSettings);
}
