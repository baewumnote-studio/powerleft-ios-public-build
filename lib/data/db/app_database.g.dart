// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BatteryProfilesTable extends BatteryProfiles
    with TableInfo<$BatteryProfilesTable, BatteryProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatteryProfilesTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capacityWhMeta = const VerificationMeta(
    'capacityWh',
  );
  @override
  late final GeneratedColumn<double> capacityWh = GeneratedColumn<double>(
    'capacity_wh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultConnectionTypeMeta =
      const VerificationMeta('defaultConnectionType');
  @override
  late final GeneratedColumn<String> defaultConnectionType =
      GeneratedColumn<String>(
        'default_connection_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('AC'),
      );
  static const VerificationMeta _currentChargePercentMeta =
      const VerificationMeta('currentChargePercent');
  @override
  late final GeneratedColumn<double> currentChargePercent =
      GeneratedColumn<double>(
        'current_charge_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(100.0),
      );
  static const VerificationMeta _maxContinuousOutputWMeta =
      const VerificationMeta('maxContinuousOutputW');
  @override
  late final GeneratedColumn<double> maxContinuousOutputW =
      GeneratedColumn<double>(
        'max_continuous_output_w',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    capacityWh,
    defaultConnectionType,
    currentChargePercent,
    maxContinuousOutputW,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'battery_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatteryProfile> instance, {
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
    if (data.containsKey('capacity_wh')) {
      context.handle(
        _capacityWhMeta,
        capacityWh.isAcceptableOrUnknown(data['capacity_wh']!, _capacityWhMeta),
      );
    } else if (isInserting) {
      context.missing(_capacityWhMeta);
    }
    if (data.containsKey('default_connection_type')) {
      context.handle(
        _defaultConnectionTypeMeta,
        defaultConnectionType.isAcceptableOrUnknown(
          data['default_connection_type']!,
          _defaultConnectionTypeMeta,
        ),
      );
    }
    if (data.containsKey('current_charge_percent')) {
      context.handle(
        _currentChargePercentMeta,
        currentChargePercent.isAcceptableOrUnknown(
          data['current_charge_percent']!,
          _currentChargePercentMeta,
        ),
      );
    }
    if (data.containsKey('max_continuous_output_w')) {
      context.handle(
        _maxContinuousOutputWMeta,
        maxContinuousOutputW.isAcceptableOrUnknown(
          data['max_continuous_output_w']!,
          _maxContinuousOutputWMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  BatteryProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatteryProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      capacityWh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}capacity_wh'],
      )!,
      defaultConnectionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_connection_type'],
      )!,
      currentChargePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_charge_percent'],
      )!,
      maxContinuousOutputW: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_continuous_output_w'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BatteryProfilesTable createAlias(String alias) {
    return $BatteryProfilesTable(attachedDatabase, alias);
  }
}

class BatteryProfile extends DataClass implements Insertable<BatteryProfile> {
  final String id;
  final String name;
  final double capacityWh;
  final String defaultConnectionType;
  final double currentChargePercent;
  final double? maxContinuousOutputW;
  final String? notes;
  final int createdAt;
  final int updatedAt;
  const BatteryProfile({
    required this.id,
    required this.name,
    required this.capacityWh,
    required this.defaultConnectionType,
    required this.currentChargePercent,
    this.maxContinuousOutputW,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['capacity_wh'] = Variable<double>(capacityWh);
    map['default_connection_type'] = Variable<String>(defaultConnectionType);
    map['current_charge_percent'] = Variable<double>(currentChargePercent);
    if (!nullToAbsent || maxContinuousOutputW != null) {
      map['max_continuous_output_w'] = Variable<double>(maxContinuousOutputW);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  BatteryProfilesCompanion toCompanion(bool nullToAbsent) {
    return BatteryProfilesCompanion(
      id: Value(id),
      name: Value(name),
      capacityWh: Value(capacityWh),
      defaultConnectionType: Value(defaultConnectionType),
      currentChargePercent: Value(currentChargePercent),
      maxContinuousOutputW: maxContinuousOutputW == null && nullToAbsent
          ? const Value.absent()
          : Value(maxContinuousOutputW),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BatteryProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatteryProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      capacityWh: serializer.fromJson<double>(json['capacityWh']),
      defaultConnectionType: serializer.fromJson<String>(
        json['defaultConnectionType'],
      ),
      currentChargePercent: serializer.fromJson<double>(
        json['currentChargePercent'],
      ),
      maxContinuousOutputW: serializer.fromJson<double?>(
        json['maxContinuousOutputW'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'capacityWh': serializer.toJson<double>(capacityWh),
      'defaultConnectionType': serializer.toJson<String>(defaultConnectionType),
      'currentChargePercent': serializer.toJson<double>(currentChargePercent),
      'maxContinuousOutputW': serializer.toJson<double?>(maxContinuousOutputW),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  BatteryProfile copyWith({
    String? id,
    String? name,
    double? capacityWh,
    String? defaultConnectionType,
    double? currentChargePercent,
    Value<double?> maxContinuousOutputW = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => BatteryProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    capacityWh: capacityWh ?? this.capacityWh,
    defaultConnectionType: defaultConnectionType ?? this.defaultConnectionType,
    currentChargePercent: currentChargePercent ?? this.currentChargePercent,
    maxContinuousOutputW: maxContinuousOutputW.present
        ? maxContinuousOutputW.value
        : this.maxContinuousOutputW,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BatteryProfile copyWithCompanion(BatteryProfilesCompanion data) {
    return BatteryProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      capacityWh: data.capacityWh.present
          ? data.capacityWh.value
          : this.capacityWh,
      defaultConnectionType: data.defaultConnectionType.present
          ? data.defaultConnectionType.value
          : this.defaultConnectionType,
      currentChargePercent: data.currentChargePercent.present
          ? data.currentChargePercent.value
          : this.currentChargePercent,
      maxContinuousOutputW: data.maxContinuousOutputW.present
          ? data.maxContinuousOutputW.value
          : this.maxContinuousOutputW,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatteryProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('capacityWh: $capacityWh, ')
          ..write('defaultConnectionType: $defaultConnectionType, ')
          ..write('currentChargePercent: $currentChargePercent, ')
          ..write('maxContinuousOutputW: $maxContinuousOutputW, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    capacityWh,
    defaultConnectionType,
    currentChargePercent,
    maxContinuousOutputW,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatteryProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.capacityWh == this.capacityWh &&
          other.defaultConnectionType == this.defaultConnectionType &&
          other.currentChargePercent == this.currentChargePercent &&
          other.maxContinuousOutputW == this.maxContinuousOutputW &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BatteryProfilesCompanion extends UpdateCompanion<BatteryProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> capacityWh;
  final Value<String> defaultConnectionType;
  final Value<double> currentChargePercent;
  final Value<double?> maxContinuousOutputW;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const BatteryProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.capacityWh = const Value.absent(),
    this.defaultConnectionType = const Value.absent(),
    this.currentChargePercent = const Value.absent(),
    this.maxContinuousOutputW = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatteryProfilesCompanion.insert({
    required String id,
    required String name,
    required double capacityWh,
    this.defaultConnectionType = const Value.absent(),
    this.currentChargePercent = const Value.absent(),
    this.maxContinuousOutputW = const Value.absent(),
    this.notes = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       capacityWh = Value(capacityWh),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BatteryProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? capacityWh,
    Expression<String>? defaultConnectionType,
    Expression<double>? currentChargePercent,
    Expression<double>? maxContinuousOutputW,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (capacityWh != null) 'capacity_wh': capacityWh,
      if (defaultConnectionType != null)
        'default_connection_type': defaultConnectionType,
      if (currentChargePercent != null)
        'current_charge_percent': currentChargePercent,
      if (maxContinuousOutputW != null)
        'max_continuous_output_w': maxContinuousOutputW,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatteryProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? capacityWh,
    Value<String>? defaultConnectionType,
    Value<double>? currentChargePercent,
    Value<double?>? maxContinuousOutputW,
    Value<String?>? notes,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return BatteryProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      capacityWh: capacityWh ?? this.capacityWh,
      defaultConnectionType:
          defaultConnectionType ?? this.defaultConnectionType,
      currentChargePercent: currentChargePercent ?? this.currentChargePercent,
      maxContinuousOutputW: maxContinuousOutputW ?? this.maxContinuousOutputW,
      notes: notes ?? this.notes,
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
    if (capacityWh.present) {
      map['capacity_wh'] = Variable<double>(capacityWh.value);
    }
    if (defaultConnectionType.present) {
      map['default_connection_type'] = Variable<String>(
        defaultConnectionType.value,
      );
    }
    if (currentChargePercent.present) {
      map['current_charge_percent'] = Variable<double>(
        currentChargePercent.value,
      );
    }
    if (maxContinuousOutputW.present) {
      map['max_continuous_output_w'] = Variable<double>(
        maxContinuousOutputW.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatteryProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('capacityWh: $capacityWh, ')
          ..write('defaultConnectionType: $defaultConnectionType, ')
          ..write('currentChargePercent: $currentChargePercent, ')
          ..write('maxContinuousOutputW: $maxContinuousOutputW, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomAppliancesTable extends CustomAppliances
    with TableInfo<$CustomAppliancesTable, CustomAppliance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomAppliancesTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wattsMeta = const VerificationMeta('watts');
  @override
  late final GeneratedColumn<double> watts = GeneratedColumn<double>(
    'watts',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usagePatternMeta = const VerificationMeta(
    'usagePattern',
  );
  @override
  late final GeneratedColumn<String> usagePattern = GeneratedColumn<String>(
    'usage_pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('alwaysOn'),
  );
  static const VerificationMeta _customUsageFactorMeta = const VerificationMeta(
    'customUsageFactor',
  );
  @override
  late final GeneratedColumn<double> customUsageFactor =
      GeneratedColumn<double>(
        'custom_usage_factor',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _connectionOverrideMeta =
      const VerificationMeta('connectionOverride');
  @override
  late final GeneratedColumn<String> connectionOverride =
      GeneratedColumn<String>(
        'connection_override',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _hasStartupSurgeMeta = const VerificationMeta(
    'hasStartupSurge',
  );
  @override
  late final GeneratedColumn<bool> hasStartupSurge = GeneratedColumn<bool>(
    'has_startup_surge',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_startup_surge" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isMedicalRelatedMeta = const VerificationMeta(
    'isMedicalRelated',
  );
  @override
  late final GeneratedColumn<bool> isMedicalRelated = GeneratedColumn<bool>(
    'is_medical_related',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_medical_related" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    watts,
    usagePattern,
    customUsageFactor,
    category,
    connectionOverride,
    hasStartupSurge,
    isMedicalRelated,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_appliances';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomAppliance> instance, {
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
    if (data.containsKey('watts')) {
      context.handle(
        _wattsMeta,
        watts.isAcceptableOrUnknown(data['watts']!, _wattsMeta),
      );
    } else if (isInserting) {
      context.missing(_wattsMeta);
    }
    if (data.containsKey('usage_pattern')) {
      context.handle(
        _usagePatternMeta,
        usagePattern.isAcceptableOrUnknown(
          data['usage_pattern']!,
          _usagePatternMeta,
        ),
      );
    }
    if (data.containsKey('custom_usage_factor')) {
      context.handle(
        _customUsageFactorMeta,
        customUsageFactor.isAcceptableOrUnknown(
          data['custom_usage_factor']!,
          _customUsageFactorMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('connection_override')) {
      context.handle(
        _connectionOverrideMeta,
        connectionOverride.isAcceptableOrUnknown(
          data['connection_override']!,
          _connectionOverrideMeta,
        ),
      );
    }
    if (data.containsKey('has_startup_surge')) {
      context.handle(
        _hasStartupSurgeMeta,
        hasStartupSurge.isAcceptableOrUnknown(
          data['has_startup_surge']!,
          _hasStartupSurgeMeta,
        ),
      );
    }
    if (data.containsKey('is_medical_related')) {
      context.handle(
        _isMedicalRelatedMeta,
        isMedicalRelated.isAcceptableOrUnknown(
          data['is_medical_related']!,
          _isMedicalRelatedMeta,
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
  CustomAppliance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomAppliance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      watts: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}watts'],
      )!,
      usagePattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_pattern'],
      )!,
      customUsageFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}custom_usage_factor'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      connectionOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_override'],
      ),
      hasStartupSurge: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_startup_surge'],
      )!,
      isMedicalRelated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_medical_related'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomAppliancesTable createAlias(String alias) {
    return $CustomAppliancesTable(attachedDatabase, alias);
  }
}

class CustomAppliance extends DataClass implements Insertable<CustomAppliance> {
  final String id;
  final String name;
  final double watts;
  final String usagePattern;
  final double? customUsageFactor;
  final String category;
  final String? connectionOverride;
  final bool hasStartupSurge;
  final bool isMedicalRelated;
  final int createdAt;
  final int updatedAt;
  const CustomAppliance({
    required this.id,
    required this.name,
    required this.watts,
    required this.usagePattern,
    this.customUsageFactor,
    required this.category,
    this.connectionOverride,
    required this.hasStartupSurge,
    required this.isMedicalRelated,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['watts'] = Variable<double>(watts);
    map['usage_pattern'] = Variable<String>(usagePattern);
    if (!nullToAbsent || customUsageFactor != null) {
      map['custom_usage_factor'] = Variable<double>(customUsageFactor);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || connectionOverride != null) {
      map['connection_override'] = Variable<String>(connectionOverride);
    }
    map['has_startup_surge'] = Variable<bool>(hasStartupSurge);
    map['is_medical_related'] = Variable<bool>(isMedicalRelated);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  CustomAppliancesCompanion toCompanion(bool nullToAbsent) {
    return CustomAppliancesCompanion(
      id: Value(id),
      name: Value(name),
      watts: Value(watts),
      usagePattern: Value(usagePattern),
      customUsageFactor: customUsageFactor == null && nullToAbsent
          ? const Value.absent()
          : Value(customUsageFactor),
      category: Value(category),
      connectionOverride: connectionOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionOverride),
      hasStartupSurge: Value(hasStartupSurge),
      isMedicalRelated: Value(isMedicalRelated),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomAppliance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomAppliance(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      watts: serializer.fromJson<double>(json['watts']),
      usagePattern: serializer.fromJson<String>(json['usagePattern']),
      customUsageFactor: serializer.fromJson<double?>(
        json['customUsageFactor'],
      ),
      category: serializer.fromJson<String>(json['category']),
      connectionOverride: serializer.fromJson<String?>(
        json['connectionOverride'],
      ),
      hasStartupSurge: serializer.fromJson<bool>(json['hasStartupSurge']),
      isMedicalRelated: serializer.fromJson<bool>(json['isMedicalRelated']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'watts': serializer.toJson<double>(watts),
      'usagePattern': serializer.toJson<String>(usagePattern),
      'customUsageFactor': serializer.toJson<double?>(customUsageFactor),
      'category': serializer.toJson<String>(category),
      'connectionOverride': serializer.toJson<String?>(connectionOverride),
      'hasStartupSurge': serializer.toJson<bool>(hasStartupSurge),
      'isMedicalRelated': serializer.toJson<bool>(isMedicalRelated),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  CustomAppliance copyWith({
    String? id,
    String? name,
    double? watts,
    String? usagePattern,
    Value<double?> customUsageFactor = const Value.absent(),
    String? category,
    Value<String?> connectionOverride = const Value.absent(),
    bool? hasStartupSurge,
    bool? isMedicalRelated,
    int? createdAt,
    int? updatedAt,
  }) => CustomAppliance(
    id: id ?? this.id,
    name: name ?? this.name,
    watts: watts ?? this.watts,
    usagePattern: usagePattern ?? this.usagePattern,
    customUsageFactor: customUsageFactor.present
        ? customUsageFactor.value
        : this.customUsageFactor,
    category: category ?? this.category,
    connectionOverride: connectionOverride.present
        ? connectionOverride.value
        : this.connectionOverride,
    hasStartupSurge: hasStartupSurge ?? this.hasStartupSurge,
    isMedicalRelated: isMedicalRelated ?? this.isMedicalRelated,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomAppliance copyWithCompanion(CustomAppliancesCompanion data) {
    return CustomAppliance(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      watts: data.watts.present ? data.watts.value : this.watts,
      usagePattern: data.usagePattern.present
          ? data.usagePattern.value
          : this.usagePattern,
      customUsageFactor: data.customUsageFactor.present
          ? data.customUsageFactor.value
          : this.customUsageFactor,
      category: data.category.present ? data.category.value : this.category,
      connectionOverride: data.connectionOverride.present
          ? data.connectionOverride.value
          : this.connectionOverride,
      hasStartupSurge: data.hasStartupSurge.present
          ? data.hasStartupSurge.value
          : this.hasStartupSurge,
      isMedicalRelated: data.isMedicalRelated.present
          ? data.isMedicalRelated.value
          : this.isMedicalRelated,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomAppliance(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('watts: $watts, ')
          ..write('usagePattern: $usagePattern, ')
          ..write('customUsageFactor: $customUsageFactor, ')
          ..write('category: $category, ')
          ..write('connectionOverride: $connectionOverride, ')
          ..write('hasStartupSurge: $hasStartupSurge, ')
          ..write('isMedicalRelated: $isMedicalRelated, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    watts,
    usagePattern,
    customUsageFactor,
    category,
    connectionOverride,
    hasStartupSurge,
    isMedicalRelated,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomAppliance &&
          other.id == this.id &&
          other.name == this.name &&
          other.watts == this.watts &&
          other.usagePattern == this.usagePattern &&
          other.customUsageFactor == this.customUsageFactor &&
          other.category == this.category &&
          other.connectionOverride == this.connectionOverride &&
          other.hasStartupSurge == this.hasStartupSurge &&
          other.isMedicalRelated == this.isMedicalRelated &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomAppliancesCompanion extends UpdateCompanion<CustomAppliance> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> watts;
  final Value<String> usagePattern;
  final Value<double?> customUsageFactor;
  final Value<String> category;
  final Value<String?> connectionOverride;
  final Value<bool> hasStartupSurge;
  final Value<bool> isMedicalRelated;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const CustomAppliancesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.watts = const Value.absent(),
    this.usagePattern = const Value.absent(),
    this.customUsageFactor = const Value.absent(),
    this.category = const Value.absent(),
    this.connectionOverride = const Value.absent(),
    this.hasStartupSurge = const Value.absent(),
    this.isMedicalRelated = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomAppliancesCompanion.insert({
    required String id,
    required String name,
    required double watts,
    this.usagePattern = const Value.absent(),
    this.customUsageFactor = const Value.absent(),
    this.category = const Value.absent(),
    this.connectionOverride = const Value.absent(),
    this.hasStartupSurge = const Value.absent(),
    this.isMedicalRelated = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       watts = Value(watts),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CustomAppliance> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? watts,
    Expression<String>? usagePattern,
    Expression<double>? customUsageFactor,
    Expression<String>? category,
    Expression<String>? connectionOverride,
    Expression<bool>? hasStartupSurge,
    Expression<bool>? isMedicalRelated,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (watts != null) 'watts': watts,
      if (usagePattern != null) 'usage_pattern': usagePattern,
      if (customUsageFactor != null) 'custom_usage_factor': customUsageFactor,
      if (category != null) 'category': category,
      if (connectionOverride != null) 'connection_override': connectionOverride,
      if (hasStartupSurge != null) 'has_startup_surge': hasStartupSurge,
      if (isMedicalRelated != null) 'is_medical_related': isMedicalRelated,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomAppliancesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? watts,
    Value<String>? usagePattern,
    Value<double?>? customUsageFactor,
    Value<String>? category,
    Value<String?>? connectionOverride,
    Value<bool>? hasStartupSurge,
    Value<bool>? isMedicalRelated,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return CustomAppliancesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      watts: watts ?? this.watts,
      usagePattern: usagePattern ?? this.usagePattern,
      customUsageFactor: customUsageFactor ?? this.customUsageFactor,
      category: category ?? this.category,
      connectionOverride: connectionOverride ?? this.connectionOverride,
      hasStartupSurge: hasStartupSurge ?? this.hasStartupSurge,
      isMedicalRelated: isMedicalRelated ?? this.isMedicalRelated,
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
    if (watts.present) {
      map['watts'] = Variable<double>(watts.value);
    }
    if (usagePattern.present) {
      map['usage_pattern'] = Variable<String>(usagePattern.value);
    }
    if (customUsageFactor.present) {
      map['custom_usage_factor'] = Variable<double>(customUsageFactor.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (connectionOverride.present) {
      map['connection_override'] = Variable<String>(connectionOverride.value);
    }
    if (hasStartupSurge.present) {
      map['has_startup_surge'] = Variable<bool>(hasStartupSurge.value);
    }
    if (isMedicalRelated.present) {
      map['is_medical_related'] = Variable<bool>(isMedicalRelated.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomAppliancesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('watts: $watts, ')
          ..write('usagePattern: $usagePattern, ')
          ..write('customUsageFactor: $customUsageFactor, ')
          ..write('category: $category, ')
          ..write('connectionOverride: $connectionOverride, ')
          ..write('hasStartupSurge: $hasStartupSurge, ')
          ..write('isMedicalRelated: $isMedicalRelated, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetupsTable extends Setups with TableInfo<$SetupsTable, Setup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetupsTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batteryProfileIdMeta = const VerificationMeta(
    'batteryProfileId',
  );
  @override
  late final GeneratedColumn<String> batteryProfileId = GeneratedColumn<String>(
    'battery_profile_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capacityWhSnapshotMeta =
      const VerificationMeta('capacityWhSnapshot');
  @override
  late final GeneratedColumn<double> capacityWhSnapshot =
      GeneratedColumn<double>(
        'capacity_wh_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _chargePercentSnapshotMeta =
      const VerificationMeta('chargePercentSnapshot');
  @override
  late final GeneratedColumn<double> chargePercentSnapshot =
      GeneratedColumn<double>(
        'charge_percent_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _connectionTypeMeta = const VerificationMeta(
    'connectionType',
  );
  @override
  late final GeneratedColumn<String> connectionType = GeneratedColumn<String>(
    'connection_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('AC'),
  );
  static const VerificationMeta _desiredRuntimeHoursMeta =
      const VerificationMeta('desiredRuntimeHours');
  @override
  late final GeneratedColumn<double> desiredRuntimeHours =
      GeneratedColumn<double>(
        'desired_runtime_hours',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reserveFloorPercentMeta =
      const VerificationMeta('reserveFloorPercent');
  @override
  late final GeneratedColumn<double> reserveFloorPercent =
      GeneratedColumn<double>(
        'reserve_floor_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(10.0),
      );
  static const VerificationMeta _customEfficiencyMeta = const VerificationMeta(
    'customEfficiency',
  );
  @override
  late final GeneratedColumn<double> customEfficiency = GeneratedColumn<double>(
    'custom_efficiency',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxContinuousOutputWMeta =
      const VerificationMeta('maxContinuousOutputW');
  @override
  late final GeneratedColumn<double> maxContinuousOutputW =
      GeneratedColumn<double>(
        'max_continuous_output_w',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    mode,
    batteryProfileId,
    capacityWhSnapshot,
    chargePercentSnapshot,
    connectionType,
    desiredRuntimeHours,
    reserveFloorPercent,
    customEfficiency,
    maxContinuousOutputW,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setups';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setup> instance, {
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
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('battery_profile_id')) {
      context.handle(
        _batteryProfileIdMeta,
        batteryProfileId.isAcceptableOrUnknown(
          data['battery_profile_id']!,
          _batteryProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('capacity_wh_snapshot')) {
      context.handle(
        _capacityWhSnapshotMeta,
        capacityWhSnapshot.isAcceptableOrUnknown(
          data['capacity_wh_snapshot']!,
          _capacityWhSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('charge_percent_snapshot')) {
      context.handle(
        _chargePercentSnapshotMeta,
        chargePercentSnapshot.isAcceptableOrUnknown(
          data['charge_percent_snapshot']!,
          _chargePercentSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('connection_type')) {
      context.handle(
        _connectionTypeMeta,
        connectionType.isAcceptableOrUnknown(
          data['connection_type']!,
          _connectionTypeMeta,
        ),
      );
    }
    if (data.containsKey('desired_runtime_hours')) {
      context.handle(
        _desiredRuntimeHoursMeta,
        desiredRuntimeHours.isAcceptableOrUnknown(
          data['desired_runtime_hours']!,
          _desiredRuntimeHoursMeta,
        ),
      );
    }
    if (data.containsKey('reserve_floor_percent')) {
      context.handle(
        _reserveFloorPercentMeta,
        reserveFloorPercent.isAcceptableOrUnknown(
          data['reserve_floor_percent']!,
          _reserveFloorPercentMeta,
        ),
      );
    }
    if (data.containsKey('custom_efficiency')) {
      context.handle(
        _customEfficiencyMeta,
        customEfficiency.isAcceptableOrUnknown(
          data['custom_efficiency']!,
          _customEfficiencyMeta,
        ),
      );
    }
    if (data.containsKey('max_continuous_output_w')) {
      context.handle(
        _maxContinuousOutputWMeta,
        maxContinuousOutputW.isAcceptableOrUnknown(
          data['max_continuous_output_w']!,
          _maxContinuousOutputWMeta,
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
  Setup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      batteryProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}battery_profile_id'],
      ),
      capacityWhSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}capacity_wh_snapshot'],
      ),
      chargePercentSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}charge_percent_snapshot'],
      ),
      connectionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_type'],
      )!,
      desiredRuntimeHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}desired_runtime_hours'],
      ),
      reserveFloorPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reserve_floor_percent'],
      )!,
      customEfficiency: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}custom_efficiency'],
      ),
      maxContinuousOutputW: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_continuous_output_w'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SetupsTable createAlias(String alias) {
    return $SetupsTable(attachedDatabase, alias);
  }
}

class Setup extends DataClass implements Insertable<Setup> {
  final String id;
  final String name;
  final String mode;
  final String? batteryProfileId;
  final double? capacityWhSnapshot;
  final double? chargePercentSnapshot;
  final String connectionType;
  final double? desiredRuntimeHours;
  final double reserveFloorPercent;
  final double? customEfficiency;
  final double? maxContinuousOutputW;
  final int createdAt;
  final int updatedAt;
  const Setup({
    required this.id,
    required this.name,
    required this.mode,
    this.batteryProfileId,
    this.capacityWhSnapshot,
    this.chargePercentSnapshot,
    required this.connectionType,
    this.desiredRuntimeHours,
    required this.reserveFloorPercent,
    this.customEfficiency,
    this.maxContinuousOutputW,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || batteryProfileId != null) {
      map['battery_profile_id'] = Variable<String>(batteryProfileId);
    }
    if (!nullToAbsent || capacityWhSnapshot != null) {
      map['capacity_wh_snapshot'] = Variable<double>(capacityWhSnapshot);
    }
    if (!nullToAbsent || chargePercentSnapshot != null) {
      map['charge_percent_snapshot'] = Variable<double>(chargePercentSnapshot);
    }
    map['connection_type'] = Variable<String>(connectionType);
    if (!nullToAbsent || desiredRuntimeHours != null) {
      map['desired_runtime_hours'] = Variable<double>(desiredRuntimeHours);
    }
    map['reserve_floor_percent'] = Variable<double>(reserveFloorPercent);
    if (!nullToAbsent || customEfficiency != null) {
      map['custom_efficiency'] = Variable<double>(customEfficiency);
    }
    if (!nullToAbsent || maxContinuousOutputW != null) {
      map['max_continuous_output_w'] = Variable<double>(maxContinuousOutputW);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  SetupsCompanion toCompanion(bool nullToAbsent) {
    return SetupsCompanion(
      id: Value(id),
      name: Value(name),
      mode: Value(mode),
      batteryProfileId: batteryProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryProfileId),
      capacityWhSnapshot: capacityWhSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(capacityWhSnapshot),
      chargePercentSnapshot: chargePercentSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(chargePercentSnapshot),
      connectionType: Value(connectionType),
      desiredRuntimeHours: desiredRuntimeHours == null && nullToAbsent
          ? const Value.absent()
          : Value(desiredRuntimeHours),
      reserveFloorPercent: Value(reserveFloorPercent),
      customEfficiency: customEfficiency == null && nullToAbsent
          ? const Value.absent()
          : Value(customEfficiency),
      maxContinuousOutputW: maxContinuousOutputW == null && nullToAbsent
          ? const Value.absent()
          : Value(maxContinuousOutputW),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setup(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mode: serializer.fromJson<String>(json['mode']),
      batteryProfileId: serializer.fromJson<String?>(json['batteryProfileId']),
      capacityWhSnapshot: serializer.fromJson<double?>(
        json['capacityWhSnapshot'],
      ),
      chargePercentSnapshot: serializer.fromJson<double?>(
        json['chargePercentSnapshot'],
      ),
      connectionType: serializer.fromJson<String>(json['connectionType']),
      desiredRuntimeHours: serializer.fromJson<double?>(
        json['desiredRuntimeHours'],
      ),
      reserveFloorPercent: serializer.fromJson<double>(
        json['reserveFloorPercent'],
      ),
      customEfficiency: serializer.fromJson<double?>(json['customEfficiency']),
      maxContinuousOutputW: serializer.fromJson<double?>(
        json['maxContinuousOutputW'],
      ),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'mode': serializer.toJson<String>(mode),
      'batteryProfileId': serializer.toJson<String?>(batteryProfileId),
      'capacityWhSnapshot': serializer.toJson<double?>(capacityWhSnapshot),
      'chargePercentSnapshot': serializer.toJson<double?>(
        chargePercentSnapshot,
      ),
      'connectionType': serializer.toJson<String>(connectionType),
      'desiredRuntimeHours': serializer.toJson<double?>(desiredRuntimeHours),
      'reserveFloorPercent': serializer.toJson<double>(reserveFloorPercent),
      'customEfficiency': serializer.toJson<double?>(customEfficiency),
      'maxContinuousOutputW': serializer.toJson<double?>(maxContinuousOutputW),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Setup copyWith({
    String? id,
    String? name,
    String? mode,
    Value<String?> batteryProfileId = const Value.absent(),
    Value<double?> capacityWhSnapshot = const Value.absent(),
    Value<double?> chargePercentSnapshot = const Value.absent(),
    String? connectionType,
    Value<double?> desiredRuntimeHours = const Value.absent(),
    double? reserveFloorPercent,
    Value<double?> customEfficiency = const Value.absent(),
    Value<double?> maxContinuousOutputW = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => Setup(
    id: id ?? this.id,
    name: name ?? this.name,
    mode: mode ?? this.mode,
    batteryProfileId: batteryProfileId.present
        ? batteryProfileId.value
        : this.batteryProfileId,
    capacityWhSnapshot: capacityWhSnapshot.present
        ? capacityWhSnapshot.value
        : this.capacityWhSnapshot,
    chargePercentSnapshot: chargePercentSnapshot.present
        ? chargePercentSnapshot.value
        : this.chargePercentSnapshot,
    connectionType: connectionType ?? this.connectionType,
    desiredRuntimeHours: desiredRuntimeHours.present
        ? desiredRuntimeHours.value
        : this.desiredRuntimeHours,
    reserveFloorPercent: reserveFloorPercent ?? this.reserveFloorPercent,
    customEfficiency: customEfficiency.present
        ? customEfficiency.value
        : this.customEfficiency,
    maxContinuousOutputW: maxContinuousOutputW.present
        ? maxContinuousOutputW.value
        : this.maxContinuousOutputW,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Setup copyWithCompanion(SetupsCompanion data) {
    return Setup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      mode: data.mode.present ? data.mode.value : this.mode,
      batteryProfileId: data.batteryProfileId.present
          ? data.batteryProfileId.value
          : this.batteryProfileId,
      capacityWhSnapshot: data.capacityWhSnapshot.present
          ? data.capacityWhSnapshot.value
          : this.capacityWhSnapshot,
      chargePercentSnapshot: data.chargePercentSnapshot.present
          ? data.chargePercentSnapshot.value
          : this.chargePercentSnapshot,
      connectionType: data.connectionType.present
          ? data.connectionType.value
          : this.connectionType,
      desiredRuntimeHours: data.desiredRuntimeHours.present
          ? data.desiredRuntimeHours.value
          : this.desiredRuntimeHours,
      reserveFloorPercent: data.reserveFloorPercent.present
          ? data.reserveFloorPercent.value
          : this.reserveFloorPercent,
      customEfficiency: data.customEfficiency.present
          ? data.customEfficiency.value
          : this.customEfficiency,
      maxContinuousOutputW: data.maxContinuousOutputW.present
          ? data.maxContinuousOutputW.value
          : this.maxContinuousOutputW,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mode: $mode, ')
          ..write('batteryProfileId: $batteryProfileId, ')
          ..write('capacityWhSnapshot: $capacityWhSnapshot, ')
          ..write('chargePercentSnapshot: $chargePercentSnapshot, ')
          ..write('connectionType: $connectionType, ')
          ..write('desiredRuntimeHours: $desiredRuntimeHours, ')
          ..write('reserveFloorPercent: $reserveFloorPercent, ')
          ..write('customEfficiency: $customEfficiency, ')
          ..write('maxContinuousOutputW: $maxContinuousOutputW, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    mode,
    batteryProfileId,
    capacityWhSnapshot,
    chargePercentSnapshot,
    connectionType,
    desiredRuntimeHours,
    reserveFloorPercent,
    customEfficiency,
    maxContinuousOutputW,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setup &&
          other.id == this.id &&
          other.name == this.name &&
          other.mode == this.mode &&
          other.batteryProfileId == this.batteryProfileId &&
          other.capacityWhSnapshot == this.capacityWhSnapshot &&
          other.chargePercentSnapshot == this.chargePercentSnapshot &&
          other.connectionType == this.connectionType &&
          other.desiredRuntimeHours == this.desiredRuntimeHours &&
          other.reserveFloorPercent == this.reserveFloorPercent &&
          other.customEfficiency == this.customEfficiency &&
          other.maxContinuousOutputW == this.maxContinuousOutputW &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SetupsCompanion extends UpdateCompanion<Setup> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> mode;
  final Value<String?> batteryProfileId;
  final Value<double?> capacityWhSnapshot;
  final Value<double?> chargePercentSnapshot;
  final Value<String> connectionType;
  final Value<double?> desiredRuntimeHours;
  final Value<double> reserveFloorPercent;
  final Value<double?> customEfficiency;
  final Value<double?> maxContinuousOutputW;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const SetupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mode = const Value.absent(),
    this.batteryProfileId = const Value.absent(),
    this.capacityWhSnapshot = const Value.absent(),
    this.chargePercentSnapshot = const Value.absent(),
    this.connectionType = const Value.absent(),
    this.desiredRuntimeHours = const Value.absent(),
    this.reserveFloorPercent = const Value.absent(),
    this.customEfficiency = const Value.absent(),
    this.maxContinuousOutputW = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetupsCompanion.insert({
    required String id,
    required String name,
    required String mode,
    this.batteryProfileId = const Value.absent(),
    this.capacityWhSnapshot = const Value.absent(),
    this.chargePercentSnapshot = const Value.absent(),
    this.connectionType = const Value.absent(),
    this.desiredRuntimeHours = const Value.absent(),
    this.reserveFloorPercent = const Value.absent(),
    this.customEfficiency = const Value.absent(),
    this.maxContinuousOutputW = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       mode = Value(mode),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Setup> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? mode,
    Expression<String>? batteryProfileId,
    Expression<double>? capacityWhSnapshot,
    Expression<double>? chargePercentSnapshot,
    Expression<String>? connectionType,
    Expression<double>? desiredRuntimeHours,
    Expression<double>? reserveFloorPercent,
    Expression<double>? customEfficiency,
    Expression<double>? maxContinuousOutputW,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mode != null) 'mode': mode,
      if (batteryProfileId != null) 'battery_profile_id': batteryProfileId,
      if (capacityWhSnapshot != null)
        'capacity_wh_snapshot': capacityWhSnapshot,
      if (chargePercentSnapshot != null)
        'charge_percent_snapshot': chargePercentSnapshot,
      if (connectionType != null) 'connection_type': connectionType,
      if (desiredRuntimeHours != null)
        'desired_runtime_hours': desiredRuntimeHours,
      if (reserveFloorPercent != null)
        'reserve_floor_percent': reserveFloorPercent,
      if (customEfficiency != null) 'custom_efficiency': customEfficiency,
      if (maxContinuousOutputW != null)
        'max_continuous_output_w': maxContinuousOutputW,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetupsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? mode,
    Value<String?>? batteryProfileId,
    Value<double?>? capacityWhSnapshot,
    Value<double?>? chargePercentSnapshot,
    Value<String>? connectionType,
    Value<double?>? desiredRuntimeHours,
    Value<double>? reserveFloorPercent,
    Value<double?>? customEfficiency,
    Value<double?>? maxContinuousOutputW,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return SetupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mode: mode ?? this.mode,
      batteryProfileId: batteryProfileId ?? this.batteryProfileId,
      capacityWhSnapshot: capacityWhSnapshot ?? this.capacityWhSnapshot,
      chargePercentSnapshot:
          chargePercentSnapshot ?? this.chargePercentSnapshot,
      connectionType: connectionType ?? this.connectionType,
      desiredRuntimeHours: desiredRuntimeHours ?? this.desiredRuntimeHours,
      reserveFloorPercent: reserveFloorPercent ?? this.reserveFloorPercent,
      customEfficiency: customEfficiency ?? this.customEfficiency,
      maxContinuousOutputW: maxContinuousOutputW ?? this.maxContinuousOutputW,
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
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (batteryProfileId.present) {
      map['battery_profile_id'] = Variable<String>(batteryProfileId.value);
    }
    if (capacityWhSnapshot.present) {
      map['capacity_wh_snapshot'] = Variable<double>(capacityWhSnapshot.value);
    }
    if (chargePercentSnapshot.present) {
      map['charge_percent_snapshot'] = Variable<double>(
        chargePercentSnapshot.value,
      );
    }
    if (connectionType.present) {
      map['connection_type'] = Variable<String>(connectionType.value);
    }
    if (desiredRuntimeHours.present) {
      map['desired_runtime_hours'] = Variable<double>(
        desiredRuntimeHours.value,
      );
    }
    if (reserveFloorPercent.present) {
      map['reserve_floor_percent'] = Variable<double>(
        reserveFloorPercent.value,
      );
    }
    if (customEfficiency.present) {
      map['custom_efficiency'] = Variable<double>(customEfficiency.value);
    }
    if (maxContinuousOutputW.present) {
      map['max_continuous_output_w'] = Variable<double>(
        maxContinuousOutputW.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mode: $mode, ')
          ..write('batteryProfileId: $batteryProfileId, ')
          ..write('capacityWhSnapshot: $capacityWhSnapshot, ')
          ..write('chargePercentSnapshot: $chargePercentSnapshot, ')
          ..write('connectionType: $connectionType, ')
          ..write('desiredRuntimeHours: $desiredRuntimeHours, ')
          ..write('reserveFloorPercent: $reserveFloorPercent, ')
          ..write('customEfficiency: $customEfficiency, ')
          ..write('maxContinuousOutputW: $maxContinuousOutputW, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetupItemsTable extends SetupItems
    with TableInfo<$SetupItemsTable, SetupItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetupItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setupIdMeta = const VerificationMeta(
    'setupId',
  );
  @override
  late final GeneratedColumn<String> setupId = GeneratedColumn<String>(
    'setup_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES setups (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sourceApplianceIdMeta = const VerificationMeta(
    'sourceApplianceId',
  );
  @override
  late final GeneratedColumn<String> sourceApplianceId =
      GeneratedColumn<String>(
        'source_appliance_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameSnapshotMeta = const VerificationMeta(
    'nameSnapshot',
  );
  @override
  late final GeneratedColumn<String> nameSnapshot = GeneratedColumn<String>(
    'name_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wattsSnapshotMeta = const VerificationMeta(
    'wattsSnapshot',
  );
  @override
  late final GeneratedColumn<double> wattsSnapshot = GeneratedColumn<double>(
    'watts_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usageFactorSnapshotMeta =
      const VerificationMeta('usageFactorSnapshot');
  @override
  late final GeneratedColumn<double> usageFactorSnapshot =
      GeneratedColumn<double>(
        'usage_factor_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _usagePatternSnapshotMeta =
      const VerificationMeta('usagePatternSnapshot');
  @override
  late final GeneratedColumn<String> usagePatternSnapshot =
      GeneratedColumn<String>(
        'usage_pattern_snapshot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('alwaysOn'),
      );
  static const VerificationMeta _connectionOverrideMeta =
      const VerificationMeta('connectionOverride');
  @override
  late final GeneratedColumn<String> connectionOverride =
      GeneratedColumn<String>(
        'connection_override',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _hasStartupSurgeMeta = const VerificationMeta(
    'hasStartupSurge',
  );
  @override
  late final GeneratedColumn<bool> hasStartupSurge = GeneratedColumn<bool>(
    'has_startup_surge',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_startup_surge" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isMedicalRelatedMeta = const VerificationMeta(
    'isMedicalRelated',
  );
  @override
  late final GeneratedColumn<bool> isMedicalRelated = GeneratedColumn<bool>(
    'is_medical_related',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_medical_related" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _categorySnapshotMeta = const VerificationMeta(
    'categorySnapshot',
  );
  @override
  late final GeneratedColumn<String> categorySnapshot = GeneratedColumn<String>(
    'category_snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('other'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    setupId,
    sourceApplianceId,
    nameSnapshot,
    wattsSnapshot,
    usageFactorSnapshot,
    usagePatternSnapshot,
    connectionOverride,
    hasStartupSurge,
    isMedicalRelated,
    categorySnapshot,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setup_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SetupItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('setup_id')) {
      context.handle(
        _setupIdMeta,
        setupId.isAcceptableOrUnknown(data['setup_id']!, _setupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_setupIdMeta);
    }
    if (data.containsKey('source_appliance_id')) {
      context.handle(
        _sourceApplianceIdMeta,
        sourceApplianceId.isAcceptableOrUnknown(
          data['source_appliance_id']!,
          _sourceApplianceIdMeta,
        ),
      );
    }
    if (data.containsKey('name_snapshot')) {
      context.handle(
        _nameSnapshotMeta,
        nameSnapshot.isAcceptableOrUnknown(
          data['name_snapshot']!,
          _nameSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameSnapshotMeta);
    }
    if (data.containsKey('watts_snapshot')) {
      context.handle(
        _wattsSnapshotMeta,
        wattsSnapshot.isAcceptableOrUnknown(
          data['watts_snapshot']!,
          _wattsSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wattsSnapshotMeta);
    }
    if (data.containsKey('usage_factor_snapshot')) {
      context.handle(
        _usageFactorSnapshotMeta,
        usageFactorSnapshot.isAcceptableOrUnknown(
          data['usage_factor_snapshot']!,
          _usageFactorSnapshotMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_usageFactorSnapshotMeta);
    }
    if (data.containsKey('usage_pattern_snapshot')) {
      context.handle(
        _usagePatternSnapshotMeta,
        usagePatternSnapshot.isAcceptableOrUnknown(
          data['usage_pattern_snapshot']!,
          _usagePatternSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('connection_override')) {
      context.handle(
        _connectionOverrideMeta,
        connectionOverride.isAcceptableOrUnknown(
          data['connection_override']!,
          _connectionOverrideMeta,
        ),
      );
    }
    if (data.containsKey('has_startup_surge')) {
      context.handle(
        _hasStartupSurgeMeta,
        hasStartupSurge.isAcceptableOrUnknown(
          data['has_startup_surge']!,
          _hasStartupSurgeMeta,
        ),
      );
    }
    if (data.containsKey('is_medical_related')) {
      context.handle(
        _isMedicalRelatedMeta,
        isMedicalRelated.isAcceptableOrUnknown(
          data['is_medical_related']!,
          _isMedicalRelatedMeta,
        ),
      );
    }
    if (data.containsKey('category_snapshot')) {
      context.handle(
        _categorySnapshotMeta,
        categorySnapshot.isAcceptableOrUnknown(
          data['category_snapshot']!,
          _categorySnapshotMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetupItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetupItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      setupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}setup_id'],
      )!,
      sourceApplianceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_appliance_id'],
      ),
      nameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_snapshot'],
      )!,
      wattsSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}watts_snapshot'],
      )!,
      usageFactorSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}usage_factor_snapshot'],
      )!,
      usagePatternSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usage_pattern_snapshot'],
      )!,
      connectionOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connection_override'],
      ),
      hasStartupSurge: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_startup_surge'],
      )!,
      isMedicalRelated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_medical_related'],
      )!,
      categorySnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_snapshot'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SetupItemsTable createAlias(String alias) {
    return $SetupItemsTable(attachedDatabase, alias);
  }
}

class SetupItem extends DataClass implements Insertable<SetupItem> {
  final String id;
  final String setupId;
  final String? sourceApplianceId;
  final String nameSnapshot;
  final double wattsSnapshot;
  final double usageFactorSnapshot;
  final String usagePatternSnapshot;
  final String? connectionOverride;
  final bool hasStartupSurge;
  final bool isMedicalRelated;
  final String categorySnapshot;
  final int sortOrder;
  const SetupItem({
    required this.id,
    required this.setupId,
    this.sourceApplianceId,
    required this.nameSnapshot,
    required this.wattsSnapshot,
    required this.usageFactorSnapshot,
    required this.usagePatternSnapshot,
    this.connectionOverride,
    required this.hasStartupSurge,
    required this.isMedicalRelated,
    required this.categorySnapshot,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['setup_id'] = Variable<String>(setupId);
    if (!nullToAbsent || sourceApplianceId != null) {
      map['source_appliance_id'] = Variable<String>(sourceApplianceId);
    }
    map['name_snapshot'] = Variable<String>(nameSnapshot);
    map['watts_snapshot'] = Variable<double>(wattsSnapshot);
    map['usage_factor_snapshot'] = Variable<double>(usageFactorSnapshot);
    map['usage_pattern_snapshot'] = Variable<String>(usagePatternSnapshot);
    if (!nullToAbsent || connectionOverride != null) {
      map['connection_override'] = Variable<String>(connectionOverride);
    }
    map['has_startup_surge'] = Variable<bool>(hasStartupSurge);
    map['is_medical_related'] = Variable<bool>(isMedicalRelated);
    map['category_snapshot'] = Variable<String>(categorySnapshot);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SetupItemsCompanion toCompanion(bool nullToAbsent) {
    return SetupItemsCompanion(
      id: Value(id),
      setupId: Value(setupId),
      sourceApplianceId: sourceApplianceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceApplianceId),
      nameSnapshot: Value(nameSnapshot),
      wattsSnapshot: Value(wattsSnapshot),
      usageFactorSnapshot: Value(usageFactorSnapshot),
      usagePatternSnapshot: Value(usagePatternSnapshot),
      connectionOverride: connectionOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(connectionOverride),
      hasStartupSurge: Value(hasStartupSurge),
      isMedicalRelated: Value(isMedicalRelated),
      categorySnapshot: Value(categorySnapshot),
      sortOrder: Value(sortOrder),
    );
  }

  factory SetupItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetupItem(
      id: serializer.fromJson<String>(json['id']),
      setupId: serializer.fromJson<String>(json['setupId']),
      sourceApplianceId: serializer.fromJson<String?>(
        json['sourceApplianceId'],
      ),
      nameSnapshot: serializer.fromJson<String>(json['nameSnapshot']),
      wattsSnapshot: serializer.fromJson<double>(json['wattsSnapshot']),
      usageFactorSnapshot: serializer.fromJson<double>(
        json['usageFactorSnapshot'],
      ),
      usagePatternSnapshot: serializer.fromJson<String>(
        json['usagePatternSnapshot'],
      ),
      connectionOverride: serializer.fromJson<String?>(
        json['connectionOverride'],
      ),
      hasStartupSurge: serializer.fromJson<bool>(json['hasStartupSurge']),
      isMedicalRelated: serializer.fromJson<bool>(json['isMedicalRelated']),
      categorySnapshot: serializer.fromJson<String>(json['categorySnapshot']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'setupId': serializer.toJson<String>(setupId),
      'sourceApplianceId': serializer.toJson<String?>(sourceApplianceId),
      'nameSnapshot': serializer.toJson<String>(nameSnapshot),
      'wattsSnapshot': serializer.toJson<double>(wattsSnapshot),
      'usageFactorSnapshot': serializer.toJson<double>(usageFactorSnapshot),
      'usagePatternSnapshot': serializer.toJson<String>(usagePatternSnapshot),
      'connectionOverride': serializer.toJson<String?>(connectionOverride),
      'hasStartupSurge': serializer.toJson<bool>(hasStartupSurge),
      'isMedicalRelated': serializer.toJson<bool>(isMedicalRelated),
      'categorySnapshot': serializer.toJson<String>(categorySnapshot),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SetupItem copyWith({
    String? id,
    String? setupId,
    Value<String?> sourceApplianceId = const Value.absent(),
    String? nameSnapshot,
    double? wattsSnapshot,
    double? usageFactorSnapshot,
    String? usagePatternSnapshot,
    Value<String?> connectionOverride = const Value.absent(),
    bool? hasStartupSurge,
    bool? isMedicalRelated,
    String? categorySnapshot,
    int? sortOrder,
  }) => SetupItem(
    id: id ?? this.id,
    setupId: setupId ?? this.setupId,
    sourceApplianceId: sourceApplianceId.present
        ? sourceApplianceId.value
        : this.sourceApplianceId,
    nameSnapshot: nameSnapshot ?? this.nameSnapshot,
    wattsSnapshot: wattsSnapshot ?? this.wattsSnapshot,
    usageFactorSnapshot: usageFactorSnapshot ?? this.usageFactorSnapshot,
    usagePatternSnapshot: usagePatternSnapshot ?? this.usagePatternSnapshot,
    connectionOverride: connectionOverride.present
        ? connectionOverride.value
        : this.connectionOverride,
    hasStartupSurge: hasStartupSurge ?? this.hasStartupSurge,
    isMedicalRelated: isMedicalRelated ?? this.isMedicalRelated,
    categorySnapshot: categorySnapshot ?? this.categorySnapshot,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  SetupItem copyWithCompanion(SetupItemsCompanion data) {
    return SetupItem(
      id: data.id.present ? data.id.value : this.id,
      setupId: data.setupId.present ? data.setupId.value : this.setupId,
      sourceApplianceId: data.sourceApplianceId.present
          ? data.sourceApplianceId.value
          : this.sourceApplianceId,
      nameSnapshot: data.nameSnapshot.present
          ? data.nameSnapshot.value
          : this.nameSnapshot,
      wattsSnapshot: data.wattsSnapshot.present
          ? data.wattsSnapshot.value
          : this.wattsSnapshot,
      usageFactorSnapshot: data.usageFactorSnapshot.present
          ? data.usageFactorSnapshot.value
          : this.usageFactorSnapshot,
      usagePatternSnapshot: data.usagePatternSnapshot.present
          ? data.usagePatternSnapshot.value
          : this.usagePatternSnapshot,
      connectionOverride: data.connectionOverride.present
          ? data.connectionOverride.value
          : this.connectionOverride,
      hasStartupSurge: data.hasStartupSurge.present
          ? data.hasStartupSurge.value
          : this.hasStartupSurge,
      isMedicalRelated: data.isMedicalRelated.present
          ? data.isMedicalRelated.value
          : this.isMedicalRelated,
      categorySnapshot: data.categorySnapshot.present
          ? data.categorySnapshot.value
          : this.categorySnapshot,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetupItem(')
          ..write('id: $id, ')
          ..write('setupId: $setupId, ')
          ..write('sourceApplianceId: $sourceApplianceId, ')
          ..write('nameSnapshot: $nameSnapshot, ')
          ..write('wattsSnapshot: $wattsSnapshot, ')
          ..write('usageFactorSnapshot: $usageFactorSnapshot, ')
          ..write('usagePatternSnapshot: $usagePatternSnapshot, ')
          ..write('connectionOverride: $connectionOverride, ')
          ..write('hasStartupSurge: $hasStartupSurge, ')
          ..write('isMedicalRelated: $isMedicalRelated, ')
          ..write('categorySnapshot: $categorySnapshot, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    setupId,
    sourceApplianceId,
    nameSnapshot,
    wattsSnapshot,
    usageFactorSnapshot,
    usagePatternSnapshot,
    connectionOverride,
    hasStartupSurge,
    isMedicalRelated,
    categorySnapshot,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetupItem &&
          other.id == this.id &&
          other.setupId == this.setupId &&
          other.sourceApplianceId == this.sourceApplianceId &&
          other.nameSnapshot == this.nameSnapshot &&
          other.wattsSnapshot == this.wattsSnapshot &&
          other.usageFactorSnapshot == this.usageFactorSnapshot &&
          other.usagePatternSnapshot == this.usagePatternSnapshot &&
          other.connectionOverride == this.connectionOverride &&
          other.hasStartupSurge == this.hasStartupSurge &&
          other.isMedicalRelated == this.isMedicalRelated &&
          other.categorySnapshot == this.categorySnapshot &&
          other.sortOrder == this.sortOrder);
}

class SetupItemsCompanion extends UpdateCompanion<SetupItem> {
  final Value<String> id;
  final Value<String> setupId;
  final Value<String?> sourceApplianceId;
  final Value<String> nameSnapshot;
  final Value<double> wattsSnapshot;
  final Value<double> usageFactorSnapshot;
  final Value<String> usagePatternSnapshot;
  final Value<String?> connectionOverride;
  final Value<bool> hasStartupSurge;
  final Value<bool> isMedicalRelated;
  final Value<String> categorySnapshot;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const SetupItemsCompanion({
    this.id = const Value.absent(),
    this.setupId = const Value.absent(),
    this.sourceApplianceId = const Value.absent(),
    this.nameSnapshot = const Value.absent(),
    this.wattsSnapshot = const Value.absent(),
    this.usageFactorSnapshot = const Value.absent(),
    this.usagePatternSnapshot = const Value.absent(),
    this.connectionOverride = const Value.absent(),
    this.hasStartupSurge = const Value.absent(),
    this.isMedicalRelated = const Value.absent(),
    this.categorySnapshot = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetupItemsCompanion.insert({
    required String id,
    required String setupId,
    this.sourceApplianceId = const Value.absent(),
    required String nameSnapshot,
    required double wattsSnapshot,
    required double usageFactorSnapshot,
    this.usagePatternSnapshot = const Value.absent(),
    this.connectionOverride = const Value.absent(),
    this.hasStartupSurge = const Value.absent(),
    this.isMedicalRelated = const Value.absent(),
    this.categorySnapshot = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       setupId = Value(setupId),
       nameSnapshot = Value(nameSnapshot),
       wattsSnapshot = Value(wattsSnapshot),
       usageFactorSnapshot = Value(usageFactorSnapshot),
       sortOrder = Value(sortOrder);
  static Insertable<SetupItem> custom({
    Expression<String>? id,
    Expression<String>? setupId,
    Expression<String>? sourceApplianceId,
    Expression<String>? nameSnapshot,
    Expression<double>? wattsSnapshot,
    Expression<double>? usageFactorSnapshot,
    Expression<String>? usagePatternSnapshot,
    Expression<String>? connectionOverride,
    Expression<bool>? hasStartupSurge,
    Expression<bool>? isMedicalRelated,
    Expression<String>? categorySnapshot,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (setupId != null) 'setup_id': setupId,
      if (sourceApplianceId != null) 'source_appliance_id': sourceApplianceId,
      if (nameSnapshot != null) 'name_snapshot': nameSnapshot,
      if (wattsSnapshot != null) 'watts_snapshot': wattsSnapshot,
      if (usageFactorSnapshot != null)
        'usage_factor_snapshot': usageFactorSnapshot,
      if (usagePatternSnapshot != null)
        'usage_pattern_snapshot': usagePatternSnapshot,
      if (connectionOverride != null) 'connection_override': connectionOverride,
      if (hasStartupSurge != null) 'has_startup_surge': hasStartupSurge,
      if (isMedicalRelated != null) 'is_medical_related': isMedicalRelated,
      if (categorySnapshot != null) 'category_snapshot': categorySnapshot,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetupItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? setupId,
    Value<String?>? sourceApplianceId,
    Value<String>? nameSnapshot,
    Value<double>? wattsSnapshot,
    Value<double>? usageFactorSnapshot,
    Value<String>? usagePatternSnapshot,
    Value<String?>? connectionOverride,
    Value<bool>? hasStartupSurge,
    Value<bool>? isMedicalRelated,
    Value<String>? categorySnapshot,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return SetupItemsCompanion(
      id: id ?? this.id,
      setupId: setupId ?? this.setupId,
      sourceApplianceId: sourceApplianceId ?? this.sourceApplianceId,
      nameSnapshot: nameSnapshot ?? this.nameSnapshot,
      wattsSnapshot: wattsSnapshot ?? this.wattsSnapshot,
      usageFactorSnapshot: usageFactorSnapshot ?? this.usageFactorSnapshot,
      usagePatternSnapshot: usagePatternSnapshot ?? this.usagePatternSnapshot,
      connectionOverride: connectionOverride ?? this.connectionOverride,
      hasStartupSurge: hasStartupSurge ?? this.hasStartupSurge,
      isMedicalRelated: isMedicalRelated ?? this.isMedicalRelated,
      categorySnapshot: categorySnapshot ?? this.categorySnapshot,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (setupId.present) {
      map['setup_id'] = Variable<String>(setupId.value);
    }
    if (sourceApplianceId.present) {
      map['source_appliance_id'] = Variable<String>(sourceApplianceId.value);
    }
    if (nameSnapshot.present) {
      map['name_snapshot'] = Variable<String>(nameSnapshot.value);
    }
    if (wattsSnapshot.present) {
      map['watts_snapshot'] = Variable<double>(wattsSnapshot.value);
    }
    if (usageFactorSnapshot.present) {
      map['usage_factor_snapshot'] = Variable<double>(
        usageFactorSnapshot.value,
      );
    }
    if (usagePatternSnapshot.present) {
      map['usage_pattern_snapshot'] = Variable<String>(
        usagePatternSnapshot.value,
      );
    }
    if (connectionOverride.present) {
      map['connection_override'] = Variable<String>(connectionOverride.value);
    }
    if (hasStartupSurge.present) {
      map['has_startup_surge'] = Variable<bool>(hasStartupSurge.value);
    }
    if (isMedicalRelated.present) {
      map['is_medical_related'] = Variable<bool>(isMedicalRelated.value);
    }
    if (categorySnapshot.present) {
      map['category_snapshot'] = Variable<String>(categorySnapshot.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetupItemsCompanion(')
          ..write('id: $id, ')
          ..write('setupId: $setupId, ')
          ..write('sourceApplianceId: $sourceApplianceId, ')
          ..write('nameSnapshot: $nameSnapshot, ')
          ..write('wattsSnapshot: $wattsSnapshot, ')
          ..write('usageFactorSnapshot: $usageFactorSnapshot, ')
          ..write('usagePatternSnapshot: $usagePatternSnapshot, ')
          ..write('connectionOverride: $connectionOverride, ')
          ..write('hasStartupSurge: $hasStartupSurge, ')
          ..write('isMedicalRelated: $isMedicalRelated, ')
          ..write('categorySnapshot: $categorySnapshot, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BatteryProfilesTable batteryProfiles = $BatteryProfilesTable(
    this,
  );
  late final $CustomAppliancesTable customAppliances = $CustomAppliancesTable(
    this,
  );
  late final $SetupsTable setups = $SetupsTable(this);
  late final $SetupItemsTable setupItems = $SetupItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    batteryProfiles,
    customAppliances,
    setups,
    setupItems,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'setups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('setup_items', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BatteryProfilesTableCreateCompanionBuilder =
    BatteryProfilesCompanion Function({
      required String id,
      required String name,
      required double capacityWh,
      Value<String> defaultConnectionType,
      Value<double> currentChargePercent,
      Value<double?> maxContinuousOutputW,
      Value<String?> notes,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$BatteryProfilesTableUpdateCompanionBuilder =
    BatteryProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> capacityWh,
      Value<String> defaultConnectionType,
      Value<double> currentChargePercent,
      Value<double?> maxContinuousOutputW,
      Value<String?> notes,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$BatteryProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $BatteryProfilesTable> {
  $$BatteryProfilesTableFilterComposer({
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

  ColumnFilters<double> get capacityWh => $composableBuilder(
    column: $table.capacityWh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultConnectionType => $composableBuilder(
    column: $table.defaultConnectionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentChargePercent => $composableBuilder(
    column: $table.currentChargePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxContinuousOutputW => $composableBuilder(
    column: $table.maxContinuousOutputW,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BatteryProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $BatteryProfilesTable> {
  $$BatteryProfilesTableOrderingComposer({
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

  ColumnOrderings<double> get capacityWh => $composableBuilder(
    column: $table.capacityWh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultConnectionType => $composableBuilder(
    column: $table.defaultConnectionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentChargePercent => $composableBuilder(
    column: $table.currentChargePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxContinuousOutputW => $composableBuilder(
    column: $table.maxContinuousOutputW,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BatteryProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatteryProfilesTable> {
  $$BatteryProfilesTableAnnotationComposer({
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

  GeneratedColumn<double> get capacityWh => $composableBuilder(
    column: $table.capacityWh,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultConnectionType => $composableBuilder(
    column: $table.defaultConnectionType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentChargePercent => $composableBuilder(
    column: $table.currentChargePercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxContinuousOutputW => $composableBuilder(
    column: $table.maxContinuousOutputW,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BatteryProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatteryProfilesTable,
          BatteryProfile,
          $$BatteryProfilesTableFilterComposer,
          $$BatteryProfilesTableOrderingComposer,
          $$BatteryProfilesTableAnnotationComposer,
          $$BatteryProfilesTableCreateCompanionBuilder,
          $$BatteryProfilesTableUpdateCompanionBuilder,
          (
            BatteryProfile,
            BaseReferences<
              _$AppDatabase,
              $BatteryProfilesTable,
              BatteryProfile
            >,
          ),
          BatteryProfile,
          PrefetchHooks Function()
        > {
  $$BatteryProfilesTableTableManager(
    _$AppDatabase db,
    $BatteryProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatteryProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatteryProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatteryProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> capacityWh = const Value.absent(),
                Value<String> defaultConnectionType = const Value.absent(),
                Value<double> currentChargePercent = const Value.absent(),
                Value<double?> maxContinuousOutputW = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatteryProfilesCompanion(
                id: id,
                name: name,
                capacityWh: capacityWh,
                defaultConnectionType: defaultConnectionType,
                currentChargePercent: currentChargePercent,
                maxContinuousOutputW: maxContinuousOutputW,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double capacityWh,
                Value<String> defaultConnectionType = const Value.absent(),
                Value<double> currentChargePercent = const Value.absent(),
                Value<double?> maxContinuousOutputW = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BatteryProfilesCompanion.insert(
                id: id,
                name: name,
                capacityWh: capacityWh,
                defaultConnectionType: defaultConnectionType,
                currentChargePercent: currentChargePercent,
                maxContinuousOutputW: maxContinuousOutputW,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatteryProfilesTable, BatteryProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BatteryProfilesTable,
                    BatteryProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BatteryProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatteryProfilesTable,
      BatteryProfile,
      $$BatteryProfilesTableFilterComposer,
      $$BatteryProfilesTableOrderingComposer,
      $$BatteryProfilesTableAnnotationComposer,
      $$BatteryProfilesTableCreateCompanionBuilder,
      $$BatteryProfilesTableUpdateCompanionBuilder,
      (
        BatteryProfile,
        BaseReferences<_$AppDatabase, $BatteryProfilesTable, BatteryProfile>,
      ),
      BatteryProfile,
      PrefetchHooks Function()
    >;
typedef $$CustomAppliancesTableCreateCompanionBuilder =
    CustomAppliancesCompanion Function({
      required String id,
      required String name,
      required double watts,
      Value<String> usagePattern,
      Value<double?> customUsageFactor,
      Value<String> category,
      Value<String?> connectionOverride,
      Value<bool> hasStartupSurge,
      Value<bool> isMedicalRelated,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$CustomAppliancesTableUpdateCompanionBuilder =
    CustomAppliancesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> watts,
      Value<String> usagePattern,
      Value<double?> customUsageFactor,
      Value<String> category,
      Value<String?> connectionOverride,
      Value<bool> hasStartupSurge,
      Value<bool> isMedicalRelated,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$CustomAppliancesTableFilterComposer
    extends Composer<_$AppDatabase, $CustomAppliancesTable> {
  $$CustomAppliancesTableFilterComposer({
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

  ColumnFilters<double> get watts => $composableBuilder(
    column: $table.watts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usagePattern => $composableBuilder(
    column: $table.usagePattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get customUsageFactor => $composableBuilder(
    column: $table.customUsageFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionOverride => $composableBuilder(
    column: $table.connectionOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasStartupSurge => $composableBuilder(
    column: $table.hasStartupSurge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMedicalRelated => $composableBuilder(
    column: $table.isMedicalRelated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomAppliancesTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomAppliancesTable> {
  $$CustomAppliancesTableOrderingComposer({
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

  ColumnOrderings<double> get watts => $composableBuilder(
    column: $table.watts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usagePattern => $composableBuilder(
    column: $table.usagePattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get customUsageFactor => $composableBuilder(
    column: $table.customUsageFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionOverride => $composableBuilder(
    column: $table.connectionOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasStartupSurge => $composableBuilder(
    column: $table.hasStartupSurge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMedicalRelated => $composableBuilder(
    column: $table.isMedicalRelated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomAppliancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomAppliancesTable> {
  $$CustomAppliancesTableAnnotationComposer({
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

  GeneratedColumn<double> get watts =>
      $composableBuilder(column: $table.watts, builder: (column) => column);

  GeneratedColumn<String> get usagePattern => $composableBuilder(
    column: $table.usagePattern,
    builder: (column) => column,
  );

  GeneratedColumn<double> get customUsageFactor => $composableBuilder(
    column: $table.customUsageFactor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get connectionOverride => $composableBuilder(
    column: $table.connectionOverride,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasStartupSurge => $composableBuilder(
    column: $table.hasStartupSurge,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMedicalRelated => $composableBuilder(
    column: $table.isMedicalRelated,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CustomAppliancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomAppliancesTable,
          CustomAppliance,
          $$CustomAppliancesTableFilterComposer,
          $$CustomAppliancesTableOrderingComposer,
          $$CustomAppliancesTableAnnotationComposer,
          $$CustomAppliancesTableCreateCompanionBuilder,
          $$CustomAppliancesTableUpdateCompanionBuilder,
          (
            CustomAppliance,
            BaseReferences<
              _$AppDatabase,
              $CustomAppliancesTable,
              CustomAppliance
            >,
          ),
          CustomAppliance,
          PrefetchHooks Function()
        > {
  $$CustomAppliancesTableTableManager(
    _$AppDatabase db,
    $CustomAppliancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomAppliancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomAppliancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomAppliancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> watts = const Value.absent(),
                Value<String> usagePattern = const Value.absent(),
                Value<double?> customUsageFactor = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> connectionOverride = const Value.absent(),
                Value<bool> hasStartupSurge = const Value.absent(),
                Value<bool> isMedicalRelated = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomAppliancesCompanion(
                id: id,
                name: name,
                watts: watts,
                usagePattern: usagePattern,
                customUsageFactor: customUsageFactor,
                category: category,
                connectionOverride: connectionOverride,
                hasStartupSurge: hasStartupSurge,
                isMedicalRelated: isMedicalRelated,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double watts,
                Value<String> usagePattern = const Value.absent(),
                Value<double?> customUsageFactor = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> connectionOverride = const Value.absent(),
                Value<bool> hasStartupSurge = const Value.absent(),
                Value<bool> isMedicalRelated = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CustomAppliancesCompanion.insert(
                id: id,
                name: name,
                watts: watts,
                usagePattern: usagePattern,
                customUsageFactor: customUsageFactor,
                category: category,
                connectionOverride: connectionOverride,
                hasStartupSurge: hasStartupSurge,
                isMedicalRelated: isMedicalRelated,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomAppliancesTable, CustomAppliance>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CustomAppliancesTable,
                    CustomAppliance
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomAppliancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomAppliancesTable,
      CustomAppliance,
      $$CustomAppliancesTableFilterComposer,
      $$CustomAppliancesTableOrderingComposer,
      $$CustomAppliancesTableAnnotationComposer,
      $$CustomAppliancesTableCreateCompanionBuilder,
      $$CustomAppliancesTableUpdateCompanionBuilder,
      (
        CustomAppliance,
        BaseReferences<_$AppDatabase, $CustomAppliancesTable, CustomAppliance>,
      ),
      CustomAppliance,
      PrefetchHooks Function()
    >;
typedef $$SetupsTableCreateCompanionBuilder =
    SetupsCompanion Function({
      required String id,
      required String name,
      required String mode,
      Value<String?> batteryProfileId,
      Value<double?> capacityWhSnapshot,
      Value<double?> chargePercentSnapshot,
      Value<String> connectionType,
      Value<double?> desiredRuntimeHours,
      Value<double> reserveFloorPercent,
      Value<double?> customEfficiency,
      Value<double?> maxContinuousOutputW,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$SetupsTableUpdateCompanionBuilder =
    SetupsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> mode,
      Value<String?> batteryProfileId,
      Value<double?> capacityWhSnapshot,
      Value<double?> chargePercentSnapshot,
      Value<String> connectionType,
      Value<double?> desiredRuntimeHours,
      Value<double> reserveFloorPercent,
      Value<double?> customEfficiency,
      Value<double?> maxContinuousOutputW,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$SetupsTableReferences
    extends BaseReferences<_$AppDatabase, $SetupsTable, Setup> {
  $$SetupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SetupItemsTable, List<SetupItem>>
  _setupItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.setupItems,
    aliasName: 'setups__id__setup_items__setup_id',
  );

  $$SetupItemsTableProcessedTableManager get setupItemsRefs {
    final manager = $$SetupItemsTableTableManager(
      $_db,
      $_db.setupItems,
    ).filter((f) => f.setupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_setupItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SetupsTableFilterComposer
    extends Composer<_$AppDatabase, $SetupsTable> {
  $$SetupsTableFilterComposer({
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

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batteryProfileId => $composableBuilder(
    column: $table.batteryProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get capacityWhSnapshot => $composableBuilder(
    column: $table.capacityWhSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chargePercentSnapshot => $composableBuilder(
    column: $table.chargePercentSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get desiredRuntimeHours => $composableBuilder(
    column: $table.desiredRuntimeHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get reserveFloorPercent => $composableBuilder(
    column: $table.reserveFloorPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get customEfficiency => $composableBuilder(
    column: $table.customEfficiency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxContinuousOutputW => $composableBuilder(
    column: $table.maxContinuousOutputW,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> setupItemsRefs(
    Expression<bool> Function($$SetupItemsTableFilterComposer f) f,
  ) {
    final $$SetupItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setupItems,
      getReferencedColumn: (t) => t.setupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetupItemsTableFilterComposer(
            $db: $db,
            $table: $db.setupItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SetupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SetupsTable> {
  $$SetupsTableOrderingComposer({
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

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batteryProfileId => $composableBuilder(
    column: $table.batteryProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get capacityWhSnapshot => $composableBuilder(
    column: $table.capacityWhSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chargePercentSnapshot => $composableBuilder(
    column: $table.chargePercentSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get desiredRuntimeHours => $composableBuilder(
    column: $table.desiredRuntimeHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get reserveFloorPercent => $composableBuilder(
    column: $table.reserveFloorPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get customEfficiency => $composableBuilder(
    column: $table.customEfficiency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxContinuousOutputW => $composableBuilder(
    column: $table.maxContinuousOutputW,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SetupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetupsTable> {
  $$SetupsTableAnnotationComposer({
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

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get batteryProfileId => $composableBuilder(
    column: $table.batteryProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get capacityWhSnapshot => $composableBuilder(
    column: $table.capacityWhSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<double> get chargePercentSnapshot => $composableBuilder(
    column: $table.chargePercentSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionType => $composableBuilder(
    column: $table.connectionType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get desiredRuntimeHours => $composableBuilder(
    column: $table.desiredRuntimeHours,
    builder: (column) => column,
  );

  GeneratedColumn<double> get reserveFloorPercent => $composableBuilder(
    column: $table.reserveFloorPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get customEfficiency => $composableBuilder(
    column: $table.customEfficiency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxContinuousOutputW => $composableBuilder(
    column: $table.maxContinuousOutputW,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> setupItemsRefs<T extends Object>(
    Expression<T> Function($$SetupItemsTableAnnotationComposer a) f,
  ) {
    final $$SetupItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.setupItems,
      getReferencedColumn: (t) => t.setupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetupItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.setupItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SetupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SetupsTable,
          Setup,
          $$SetupsTableFilterComposer,
          $$SetupsTableOrderingComposer,
          $$SetupsTableAnnotationComposer,
          $$SetupsTableCreateCompanionBuilder,
          $$SetupsTableUpdateCompanionBuilder,
          (Setup, $$SetupsTableReferences),
          Setup,
          PrefetchHooks Function({bool setupItemsRefs})
        > {
  $$SetupsTableTableManager(_$AppDatabase db, $SetupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String?> batteryProfileId = const Value.absent(),
                Value<double?> capacityWhSnapshot = const Value.absent(),
                Value<double?> chargePercentSnapshot = const Value.absent(),
                Value<String> connectionType = const Value.absent(),
                Value<double?> desiredRuntimeHours = const Value.absent(),
                Value<double> reserveFloorPercent = const Value.absent(),
                Value<double?> customEfficiency = const Value.absent(),
                Value<double?> maxContinuousOutputW = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SetupsCompanion(
                id: id,
                name: name,
                mode: mode,
                batteryProfileId: batteryProfileId,
                capacityWhSnapshot: capacityWhSnapshot,
                chargePercentSnapshot: chargePercentSnapshot,
                connectionType: connectionType,
                desiredRuntimeHours: desiredRuntimeHours,
                reserveFloorPercent: reserveFloorPercent,
                customEfficiency: customEfficiency,
                maxContinuousOutputW: maxContinuousOutputW,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String mode,
                Value<String?> batteryProfileId = const Value.absent(),
                Value<double?> capacityWhSnapshot = const Value.absent(),
                Value<double?> chargePercentSnapshot = const Value.absent(),
                Value<String> connectionType = const Value.absent(),
                Value<double?> desiredRuntimeHours = const Value.absent(),
                Value<double> reserveFloorPercent = const Value.absent(),
                Value<double?> customEfficiency = const Value.absent(),
                Value<double?> maxContinuousOutputW = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SetupsCompanion.insert(
                id: id,
                name: name,
                mode: mode,
                batteryProfileId: batteryProfileId,
                capacityWhSnapshot: capacityWhSnapshot,
                chargePercentSnapshot: chargePercentSnapshot,
                connectionType: connectionType,
                desiredRuntimeHours: desiredRuntimeHours,
                reserveFloorPercent: reserveFloorPercent,
                customEfficiency: customEfficiency,
                maxContinuousOutputW: maxContinuousOutputW,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SetupsTable, Setup>(table),
                  $$SetupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({setupItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (setupItemsRefs) db.setupItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (setupItemsRefs)
                    await $_getPrefetchedData<Setup, $SetupsTable, SetupItem>(
                      currentTable: table,
                      referencedTable: $$SetupsTableReferences
                          ._setupItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SetupsTableReferences(db, table, p0).setupItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.setupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SetupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SetupsTable,
      Setup,
      $$SetupsTableFilterComposer,
      $$SetupsTableOrderingComposer,
      $$SetupsTableAnnotationComposer,
      $$SetupsTableCreateCompanionBuilder,
      $$SetupsTableUpdateCompanionBuilder,
      (Setup, $$SetupsTableReferences),
      Setup,
      PrefetchHooks Function({bool setupItemsRefs})
    >;
typedef $$SetupItemsTableCreateCompanionBuilder =
    SetupItemsCompanion Function({
      required String id,
      required String setupId,
      Value<String?> sourceApplianceId,
      required String nameSnapshot,
      required double wattsSnapshot,
      required double usageFactorSnapshot,
      Value<String> usagePatternSnapshot,
      Value<String?> connectionOverride,
      Value<bool> hasStartupSurge,
      Value<bool> isMedicalRelated,
      Value<String> categorySnapshot,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$SetupItemsTableUpdateCompanionBuilder =
    SetupItemsCompanion Function({
      Value<String> id,
      Value<String> setupId,
      Value<String?> sourceApplianceId,
      Value<String> nameSnapshot,
      Value<double> wattsSnapshot,
      Value<double> usageFactorSnapshot,
      Value<String> usagePatternSnapshot,
      Value<String?> connectionOverride,
      Value<bool> hasStartupSurge,
      Value<bool> isMedicalRelated,
      Value<String> categorySnapshot,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$SetupItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SetupItemsTable, SetupItem> {
  $$SetupItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SetupsTable _setupIdTable(_$AppDatabase db) =>
      db.setups.createAlias('setup_items__setup_id__setups__id');

  $$SetupsTableProcessedTableManager get setupId {
    final $_column = $_itemColumn<String>('setup_id')!;

    final manager = $$SetupsTableTableManager(
      $_db,
      $_db.setups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_setupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SetupItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SetupItemsTable> {
  $$SetupItemsTableFilterComposer({
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

  ColumnFilters<String> get sourceApplianceId => $composableBuilder(
    column: $table.sourceApplianceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameSnapshot => $composableBuilder(
    column: $table.nameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wattsSnapshot => $composableBuilder(
    column: $table.wattsSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get usageFactorSnapshot => $composableBuilder(
    column: $table.usageFactorSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usagePatternSnapshot => $composableBuilder(
    column: $table.usagePatternSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectionOverride => $composableBuilder(
    column: $table.connectionOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasStartupSurge => $composableBuilder(
    column: $table.hasStartupSurge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMedicalRelated => $composableBuilder(
    column: $table.isMedicalRelated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorySnapshot => $composableBuilder(
    column: $table.categorySnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$SetupsTableFilterComposer get setupId {
    final $$SetupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setupId,
      referencedTable: $db.setups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetupsTableFilterComposer(
            $db: $db,
            $table: $db.setups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SetupItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SetupItemsTable> {
  $$SetupItemsTableOrderingComposer({
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

  ColumnOrderings<String> get sourceApplianceId => $composableBuilder(
    column: $table.sourceApplianceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameSnapshot => $composableBuilder(
    column: $table.nameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wattsSnapshot => $composableBuilder(
    column: $table.wattsSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get usageFactorSnapshot => $composableBuilder(
    column: $table.usageFactorSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usagePatternSnapshot => $composableBuilder(
    column: $table.usagePatternSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectionOverride => $composableBuilder(
    column: $table.connectionOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasStartupSurge => $composableBuilder(
    column: $table.hasStartupSurge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMedicalRelated => $composableBuilder(
    column: $table.isMedicalRelated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorySnapshot => $composableBuilder(
    column: $table.categorySnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$SetupsTableOrderingComposer get setupId {
    final $$SetupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setupId,
      referencedTable: $db.setups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetupsTableOrderingComposer(
            $db: $db,
            $table: $db.setups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SetupItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetupItemsTable> {
  $$SetupItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceApplianceId => $composableBuilder(
    column: $table.sourceApplianceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameSnapshot => $composableBuilder(
    column: $table.nameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wattsSnapshot => $composableBuilder(
    column: $table.wattsSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<double> get usageFactorSnapshot => $composableBuilder(
    column: $table.usageFactorSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get usagePatternSnapshot => $composableBuilder(
    column: $table.usagePatternSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectionOverride => $composableBuilder(
    column: $table.connectionOverride,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasStartupSurge => $composableBuilder(
    column: $table.hasStartupSurge,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMedicalRelated => $composableBuilder(
    column: $table.isMedicalRelated,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categorySnapshot => $composableBuilder(
    column: $table.categorySnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$SetupsTableAnnotationComposer get setupId {
    final $$SetupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setupId,
      referencedTable: $db.setups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetupsTableAnnotationComposer(
            $db: $db,
            $table: $db.setups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SetupItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SetupItemsTable,
          SetupItem,
          $$SetupItemsTableFilterComposer,
          $$SetupItemsTableOrderingComposer,
          $$SetupItemsTableAnnotationComposer,
          $$SetupItemsTableCreateCompanionBuilder,
          $$SetupItemsTableUpdateCompanionBuilder,
          (SetupItem, $$SetupItemsTableReferences),
          SetupItem,
          PrefetchHooks Function({bool setupId})
        > {
  $$SetupItemsTableTableManager(_$AppDatabase db, $SetupItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetupItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetupItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetupItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> setupId = const Value.absent(),
                Value<String?> sourceApplianceId = const Value.absent(),
                Value<String> nameSnapshot = const Value.absent(),
                Value<double> wattsSnapshot = const Value.absent(),
                Value<double> usageFactorSnapshot = const Value.absent(),
                Value<String> usagePatternSnapshot = const Value.absent(),
                Value<String?> connectionOverride = const Value.absent(),
                Value<bool> hasStartupSurge = const Value.absent(),
                Value<bool> isMedicalRelated = const Value.absent(),
                Value<String> categorySnapshot = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SetupItemsCompanion(
                id: id,
                setupId: setupId,
                sourceApplianceId: sourceApplianceId,
                nameSnapshot: nameSnapshot,
                wattsSnapshot: wattsSnapshot,
                usageFactorSnapshot: usageFactorSnapshot,
                usagePatternSnapshot: usagePatternSnapshot,
                connectionOverride: connectionOverride,
                hasStartupSurge: hasStartupSurge,
                isMedicalRelated: isMedicalRelated,
                categorySnapshot: categorySnapshot,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String setupId,
                Value<String?> sourceApplianceId = const Value.absent(),
                required String nameSnapshot,
                required double wattsSnapshot,
                required double usageFactorSnapshot,
                Value<String> usagePatternSnapshot = const Value.absent(),
                Value<String?> connectionOverride = const Value.absent(),
                Value<bool> hasStartupSurge = const Value.absent(),
                Value<bool> isMedicalRelated = const Value.absent(),
                Value<String> categorySnapshot = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => SetupItemsCompanion.insert(
                id: id,
                setupId: setupId,
                sourceApplianceId: sourceApplianceId,
                nameSnapshot: nameSnapshot,
                wattsSnapshot: wattsSnapshot,
                usageFactorSnapshot: usageFactorSnapshot,
                usagePatternSnapshot: usagePatternSnapshot,
                connectionOverride: connectionOverride,
                hasStartupSurge: hasStartupSurge,
                isMedicalRelated: isMedicalRelated,
                categorySnapshot: categorySnapshot,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SetupItemsTable, SetupItem>(table),
                  $$SetupItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({setupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (setupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.setupId,
                                referencedTable: $$SetupItemsTableReferences
                                    ._setupIdTable(db),
                                referencedColumn: $$SetupItemsTableReferences
                                    ._setupIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SetupItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SetupItemsTable,
      SetupItem,
      $$SetupItemsTableFilterComposer,
      $$SetupItemsTableOrderingComposer,
      $$SetupItemsTableAnnotationComposer,
      $$SetupItemsTableCreateCompanionBuilder,
      $$SetupItemsTableUpdateCompanionBuilder,
      (SetupItem, $$SetupItemsTableReferences),
      SetupItem,
      PrefetchHooks Function({bool setupId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BatteryProfilesTableTableManager get batteryProfiles =>
      $$BatteryProfilesTableTableManager(_db, _db.batteryProfiles);
  $$CustomAppliancesTableTableManager get customAppliances =>
      $$CustomAppliancesTableTableManager(_db, _db.customAppliances);
  $$SetupsTableTableManager get setups =>
      $$SetupsTableTableManager(_db, _db.setups);
  $$SetupItemsTableTableManager get setupItems =>
      $$SetupItemsTableTableManager(_db, _db.setupItems);
}
