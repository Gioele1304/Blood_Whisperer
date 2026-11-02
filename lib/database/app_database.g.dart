// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DailyLogEntriesTable extends DailyLogEntries
    with TableInfo<$DailyLogEntriesTable, DailyLogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _flowMeta = const VerificationMeta('flow');
  @override
  late final GeneratedColumn<int> flow = GeneratedColumn<int>(
      'flow', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _mucusMeta = const VerificationMeta('mucus');
  @override
  late final GeneratedColumn<int> mucus = GeneratedColumn<int>(
      'mucus', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _moodsMeta = const VerificationMeta('moods');
  @override
  late final GeneratedColumn<String> moods = GeneratedColumn<String>(
      'moods', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _symptomsMeta =
      const VerificationMeta('symptoms');
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
      'symptoms', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _bbtMeta = const VerificationMeta('bbt');
  @override
  late final GeneratedColumn<double> bbt = GeneratedColumn<double>(
      'bbt', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _hydrationLitersMeta =
      const VerificationMeta('hydrationLiters');
  @override
  late final GeneratedColumn<double> hydrationLiters = GeneratedColumn<double>(
      'hydration_liters', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sleepHoursMeta =
      const VerificationMeta('sleepHours');
  @override
  late final GeneratedColumn<double> sleepHours = GeneratedColumn<double>(
      'sleep_hours', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sleepQualityMeta =
      const VerificationMeta('sleepQuality');
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
      'sleep_quality', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hadSexMeta = const VerificationMeta('hadSex');
  @override
  late final GeneratedColumn<bool> hadSex = GeneratedColumn<bool>(
      'had_sex', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("had_sex" IN (0, 1))'));
  static const VerificationMeta _sexProtectedMeta =
      const VerificationMeta('sexProtected');
  @override
  late final GeneratedColumn<bool> sexProtected = GeneratedColumn<bool>(
      'sex_protected', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sex_protected" IN (0, 1))'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        flow,
        mucus,
        moods,
        symptoms,
        bbt,
        weight,
        hydrationLiters,
        sleepHours,
        sleepQuality,
        hadSex,
        sexProtected,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_log_entries';
  @override
  VerificationContext validateIntegrity(Insertable<DailyLogEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('flow')) {
      context.handle(
          _flowMeta, flow.isAcceptableOrUnknown(data['flow']!, _flowMeta));
    }
    if (data.containsKey('mucus')) {
      context.handle(
          _mucusMeta, mucus.isAcceptableOrUnknown(data['mucus']!, _mucusMeta));
    }
    if (data.containsKey('moods')) {
      context.handle(
          _moodsMeta, moods.isAcceptableOrUnknown(data['moods']!, _moodsMeta));
    }
    if (data.containsKey('symptoms')) {
      context.handle(_symptomsMeta,
          symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta));
    }
    if (data.containsKey('bbt')) {
      context.handle(
          _bbtMeta, bbt.isAcceptableOrUnknown(data['bbt']!, _bbtMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('hydration_liters')) {
      context.handle(
          _hydrationLitersMeta,
          hydrationLiters.isAcceptableOrUnknown(
              data['hydration_liters']!, _hydrationLitersMeta));
    }
    if (data.containsKey('sleep_hours')) {
      context.handle(
          _sleepHoursMeta,
          sleepHours.isAcceptableOrUnknown(
              data['sleep_hours']!, _sleepHoursMeta));
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
          _sleepQualityMeta,
          sleepQuality.isAcceptableOrUnknown(
              data['sleep_quality']!, _sleepQualityMeta));
    }
    if (data.containsKey('had_sex')) {
      context.handle(_hadSexMeta,
          hadSex.isAcceptableOrUnknown(data['had_sex']!, _hadSexMeta));
    }
    if (data.containsKey('sex_protected')) {
      context.handle(
          _sexProtectedMeta,
          sexProtected.isAcceptableOrUnknown(
              data['sex_protected']!, _sexProtectedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyLogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLogEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      flow: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}flow'])!,
      mucus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mucus'])!,
      moods: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moods'])!,
      symptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptoms'])!,
      bbt: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bbt']),
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight']),
      hydrationLiters: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}hydration_liters']),
      sleepHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sleep_hours']),
      sleepQuality: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_quality']),
      hadSex: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}had_sex']),
      sexProtected: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sex_protected']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyLogEntriesTable createAlias(String alias) {
    return $DailyLogEntriesTable(attachedDatabase, alias);
  }
}

class DailyLogEntry extends DataClass implements Insertable<DailyLogEntry> {
  final int id;
  final DateTime date;
  final int flow;
  final int mucus;
  final String moods;
  final String symptoms;
  final double? bbt;
  final double? weight;
  final double? hydrationLiters;
  final double? sleepHours;
  final int? sleepQuality;
  final bool? hadSex;
  final bool? sexProtected;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyLogEntry(
      {required this.id,
      required this.date,
      required this.flow,
      required this.mucus,
      required this.moods,
      required this.symptoms,
      this.bbt,
      this.weight,
      this.hydrationLiters,
      this.sleepHours,
      this.sleepQuality,
      this.hadSex,
      this.sexProtected,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['flow'] = Variable<int>(flow);
    map['mucus'] = Variable<int>(mucus);
    map['moods'] = Variable<String>(moods);
    map['symptoms'] = Variable<String>(symptoms);
    if (!nullToAbsent || bbt != null) {
      map['bbt'] = Variable<double>(bbt);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || hydrationLiters != null) {
      map['hydration_liters'] = Variable<double>(hydrationLiters);
    }
    if (!nullToAbsent || sleepHours != null) {
      map['sleep_hours'] = Variable<double>(sleepHours);
    }
    if (!nullToAbsent || sleepQuality != null) {
      map['sleep_quality'] = Variable<int>(sleepQuality);
    }
    if (!nullToAbsent || hadSex != null) {
      map['had_sex'] = Variable<bool>(hadSex);
    }
    if (!nullToAbsent || sexProtected != null) {
      map['sex_protected'] = Variable<bool>(sexProtected);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyLogEntriesCompanion toCompanion(bool nullToAbsent) {
    return DailyLogEntriesCompanion(
      id: Value(id),
      date: Value(date),
      flow: Value(flow),
      mucus: Value(mucus),
      moods: Value(moods),
      symptoms: Value(symptoms),
      bbt: bbt == null && nullToAbsent ? const Value.absent() : Value(bbt),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      hydrationLiters: hydrationLiters == null && nullToAbsent
          ? const Value.absent()
          : Value(hydrationLiters),
      sleepHours: sleepHours == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepHours),
      sleepQuality: sleepQuality == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepQuality),
      hadSex:
          hadSex == null && nullToAbsent ? const Value.absent() : Value(hadSex),
      sexProtected: sexProtected == null && nullToAbsent
          ? const Value.absent()
          : Value(sexProtected),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyLogEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLogEntry(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      flow: serializer.fromJson<int>(json['flow']),
      mucus: serializer.fromJson<int>(json['mucus']),
      moods: serializer.fromJson<String>(json['moods']),
      symptoms: serializer.fromJson<String>(json['symptoms']),
      bbt: serializer.fromJson<double?>(json['bbt']),
      weight: serializer.fromJson<double?>(json['weight']),
      hydrationLiters: serializer.fromJson<double?>(json['hydrationLiters']),
      sleepHours: serializer.fromJson<double?>(json['sleepHours']),
      sleepQuality: serializer.fromJson<int?>(json['sleepQuality']),
      hadSex: serializer.fromJson<bool?>(json['hadSex']),
      sexProtected: serializer.fromJson<bool?>(json['sexProtected']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'flow': serializer.toJson<int>(flow),
      'mucus': serializer.toJson<int>(mucus),
      'moods': serializer.toJson<String>(moods),
      'symptoms': serializer.toJson<String>(symptoms),
      'bbt': serializer.toJson<double?>(bbt),
      'weight': serializer.toJson<double?>(weight),
      'hydrationLiters': serializer.toJson<double?>(hydrationLiters),
      'sleepHours': serializer.toJson<double?>(sleepHours),
      'sleepQuality': serializer.toJson<int?>(sleepQuality),
      'hadSex': serializer.toJson<bool?>(hadSex),
      'sexProtected': serializer.toJson<bool?>(sexProtected),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyLogEntry copyWith(
          {int? id,
          DateTime? date,
          int? flow,
          int? mucus,
          String? moods,
          String? symptoms,
          Value<double?> bbt = const Value.absent(),
          Value<double?> weight = const Value.absent(),
          Value<double?> hydrationLiters = const Value.absent(),
          Value<double?> sleepHours = const Value.absent(),
          Value<int?> sleepQuality = const Value.absent(),
          Value<bool?> hadSex = const Value.absent(),
          Value<bool?> sexProtected = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DailyLogEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        flow: flow ?? this.flow,
        mucus: mucus ?? this.mucus,
        moods: moods ?? this.moods,
        symptoms: symptoms ?? this.symptoms,
        bbt: bbt.present ? bbt.value : this.bbt,
        weight: weight.present ? weight.value : this.weight,
        hydrationLiters: hydrationLiters.present
            ? hydrationLiters.value
            : this.hydrationLiters,
        sleepHours: sleepHours.present ? sleepHours.value : this.sleepHours,
        sleepQuality:
            sleepQuality.present ? sleepQuality.value : this.sleepQuality,
        hadSex: hadSex.present ? hadSex.value : this.hadSex,
        sexProtected:
            sexProtected.present ? sexProtected.value : this.sexProtected,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyLogEntry copyWithCompanion(DailyLogEntriesCompanion data) {
    return DailyLogEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      flow: data.flow.present ? data.flow.value : this.flow,
      mucus: data.mucus.present ? data.mucus.value : this.mucus,
      moods: data.moods.present ? data.moods.value : this.moods,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      bbt: data.bbt.present ? data.bbt.value : this.bbt,
      weight: data.weight.present ? data.weight.value : this.weight,
      hydrationLiters: data.hydrationLiters.present
          ? data.hydrationLiters.value
          : this.hydrationLiters,
      sleepHours:
          data.sleepHours.present ? data.sleepHours.value : this.sleepHours,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      hadSex: data.hadSex.present ? data.hadSex.value : this.hadSex,
      sexProtected: data.sexProtected.present
          ? data.sexProtected.value
          : this.sexProtected,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('flow: $flow, ')
          ..write('mucus: $mucus, ')
          ..write('moods: $moods, ')
          ..write('symptoms: $symptoms, ')
          ..write('bbt: $bbt, ')
          ..write('weight: $weight, ')
          ..write('hydrationLiters: $hydrationLiters, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('hadSex: $hadSex, ')
          ..write('sexProtected: $sexProtected, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      flow,
      mucus,
      moods,
      symptoms,
      bbt,
      weight,
      hydrationLiters,
      sleepHours,
      sleepQuality,
      hadSex,
      sexProtected,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLogEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.flow == this.flow &&
          other.mucus == this.mucus &&
          other.moods == this.moods &&
          other.symptoms == this.symptoms &&
          other.bbt == this.bbt &&
          other.weight == this.weight &&
          other.hydrationLiters == this.hydrationLiters &&
          other.sleepHours == this.sleepHours &&
          other.sleepQuality == this.sleepQuality &&
          other.hadSex == this.hadSex &&
          other.sexProtected == this.sexProtected &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyLogEntriesCompanion extends UpdateCompanion<DailyLogEntry> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> flow;
  final Value<int> mucus;
  final Value<String> moods;
  final Value<String> symptoms;
  final Value<double?> bbt;
  final Value<double?> weight;
  final Value<double?> hydrationLiters;
  final Value<double?> sleepHours;
  final Value<int?> sleepQuality;
  final Value<bool?> hadSex;
  final Value<bool?> sexProtected;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DailyLogEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.flow = const Value.absent(),
    this.mucus = const Value.absent(),
    this.moods = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.bbt = const Value.absent(),
    this.weight = const Value.absent(),
    this.hydrationLiters = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.hadSex = const Value.absent(),
    this.sexProtected = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyLogEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.flow = const Value.absent(),
    this.mucus = const Value.absent(),
    this.moods = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.bbt = const Value.absent(),
    this.weight = const Value.absent(),
    this.hydrationLiters = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.hadSex = const Value.absent(),
    this.sexProtected = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : date = Value(date),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<DailyLogEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? flow,
    Expression<int>? mucus,
    Expression<String>? moods,
    Expression<String>? symptoms,
    Expression<double>? bbt,
    Expression<double>? weight,
    Expression<double>? hydrationLiters,
    Expression<double>? sleepHours,
    Expression<int>? sleepQuality,
    Expression<bool>? hadSex,
    Expression<bool>? sexProtected,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (flow != null) 'flow': flow,
      if (mucus != null) 'mucus': mucus,
      if (moods != null) 'moods': moods,
      if (symptoms != null) 'symptoms': symptoms,
      if (bbt != null) 'bbt': bbt,
      if (weight != null) 'weight': weight,
      if (hydrationLiters != null) 'hydration_liters': hydrationLiters,
      if (sleepHours != null) 'sleep_hours': sleepHours,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (hadSex != null) 'had_sex': hadSex,
      if (sexProtected != null) 'sex_protected': sexProtected,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyLogEntriesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? flow,
      Value<int>? mucus,
      Value<String>? moods,
      Value<String>? symptoms,
      Value<double?>? bbt,
      Value<double?>? weight,
      Value<double?>? hydrationLiters,
      Value<double?>? sleepHours,
      Value<int?>? sleepQuality,
      Value<bool?>? hadSex,
      Value<bool?>? sexProtected,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return DailyLogEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      flow: flow ?? this.flow,
      mucus: mucus ?? this.mucus,
      moods: moods ?? this.moods,
      symptoms: symptoms ?? this.symptoms,
      bbt: bbt ?? this.bbt,
      weight: weight ?? this.weight,
      hydrationLiters: hydrationLiters ?? this.hydrationLiters,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      hadSex: hadSex ?? this.hadSex,
      sexProtected: sexProtected ?? this.sexProtected,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (flow.present) {
      map['flow'] = Variable<int>(flow.value);
    }
    if (mucus.present) {
      map['mucus'] = Variable<int>(mucus.value);
    }
    if (moods.present) {
      map['moods'] = Variable<String>(moods.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (bbt.present) {
      map['bbt'] = Variable<double>(bbt.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (hydrationLiters.present) {
      map['hydration_liters'] = Variable<double>(hydrationLiters.value);
    }
    if (sleepHours.present) {
      map['sleep_hours'] = Variable<double>(sleepHours.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (hadSex.present) {
      map['had_sex'] = Variable<bool>(hadSex.value);
    }
    if (sexProtected.present) {
      map['sex_protected'] = Variable<bool>(sexProtected.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('flow: $flow, ')
          ..write('mucus: $mucus, ')
          ..write('moods: $moods, ')
          ..write('symptoms: $symptoms, ')
          ..write('bbt: $bbt, ')
          ..write('weight: $weight, ')
          ..write('hydrationLiters: $hydrationLiters, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('hadSex: $hadSex, ')
          ..write('sexProtected: $sexProtected, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MenstrualCyclesTable extends MenstrualCycles
    with TableInfo<$MenstrualCyclesTable, MenstrualCycle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MenstrualCyclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lengthDaysMeta =
      const VerificationMeta('lengthDays');
  @override
  late final GeneratedColumn<int> lengthDays = GeneratedColumn<int>(
      'length_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _periodLengthDaysMeta =
      const VerificationMeta('periodLengthDays');
  @override
  late final GeneratedColumn<int> periodLengthDays = GeneratedColumn<int>(
      'period_length_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, startDate, endDate, lengthDays, periodLengthDays, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'menstrual_cycles';
  @override
  VerificationContext validateIntegrity(Insertable<MenstrualCycle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('length_days')) {
      context.handle(
          _lengthDaysMeta,
          lengthDays.isAcceptableOrUnknown(
              data['length_days']!, _lengthDaysMeta));
    }
    if (data.containsKey('period_length_days')) {
      context.handle(
          _periodLengthDaysMeta,
          periodLengthDays.isAcceptableOrUnknown(
              data['period_length_days']!, _periodLengthDaysMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MenstrualCycle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MenstrualCycle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      lengthDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}length_days']),
      periodLengthDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}period_length_days']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $MenstrualCyclesTable createAlias(String alias) {
    return $MenstrualCyclesTable(attachedDatabase, alias);
  }
}

class MenstrualCycle extends DataClass implements Insertable<MenstrualCycle> {
  final int id;
  final DateTime startDate;
  final DateTime? endDate;
  final int? lengthDays;
  final int? periodLengthDays;
  final String? notes;
  const MenstrualCycle(
      {required this.id,
      required this.startDate,
      this.endDate,
      this.lengthDays,
      this.periodLengthDays,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || lengthDays != null) {
      map['length_days'] = Variable<int>(lengthDays);
    }
    if (!nullToAbsent || periodLengthDays != null) {
      map['period_length_days'] = Variable<int>(periodLengthDays);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MenstrualCyclesCompanion toCompanion(bool nullToAbsent) {
    return MenstrualCyclesCompanion(
      id: Value(id),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      lengthDays: lengthDays == null && nullToAbsent
          ? const Value.absent()
          : Value(lengthDays),
      periodLengthDays: periodLengthDays == null && nullToAbsent
          ? const Value.absent()
          : Value(periodLengthDays),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory MenstrualCycle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MenstrualCycle(
      id: serializer.fromJson<int>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      lengthDays: serializer.fromJson<int?>(json['lengthDays']),
      periodLengthDays: serializer.fromJson<int?>(json['periodLengthDays']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'lengthDays': serializer.toJson<int?>(lengthDays),
      'periodLengthDays': serializer.toJson<int?>(periodLengthDays),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  MenstrualCycle copyWith(
          {int? id,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          Value<int?> lengthDays = const Value.absent(),
          Value<int?> periodLengthDays = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      MenstrualCycle(
        id: id ?? this.id,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        lengthDays: lengthDays.present ? lengthDays.value : this.lengthDays,
        periodLengthDays: periodLengthDays.present
            ? periodLengthDays.value
            : this.periodLengthDays,
        notes: notes.present ? notes.value : this.notes,
      );
  MenstrualCycle copyWithCompanion(MenstrualCyclesCompanion data) {
    return MenstrualCycle(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      lengthDays:
          data.lengthDays.present ? data.lengthDays.value : this.lengthDays,
      periodLengthDays: data.periodLengthDays.present
          ? data.periodLengthDays.value
          : this.periodLengthDays,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MenstrualCycle(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('lengthDays: $lengthDays, ')
          ..write('periodLengthDays: $periodLengthDays, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startDate, endDate, lengthDays, periodLengthDays, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MenstrualCycle &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.lengthDays == this.lengthDays &&
          other.periodLengthDays == this.periodLengthDays &&
          other.notes == this.notes);
}

class MenstrualCyclesCompanion extends UpdateCompanion<MenstrualCycle> {
  final Value<int> id;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int?> lengthDays;
  final Value<int?> periodLengthDays;
  final Value<String?> notes;
  const MenstrualCyclesCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.lengthDays = const Value.absent(),
    this.periodLengthDays = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MenstrualCyclesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.lengthDays = const Value.absent(),
    this.periodLengthDays = const Value.absent(),
    this.notes = const Value.absent(),
  }) : startDate = Value(startDate);
  static Insertable<MenstrualCycle> custom({
    Expression<int>? id,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? lengthDays,
    Expression<int>? periodLengthDays,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (lengthDays != null) 'length_days': lengthDays,
      if (periodLengthDays != null) 'period_length_days': periodLengthDays,
      if (notes != null) 'notes': notes,
    });
  }

  MenstrualCyclesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<int?>? lengthDays,
      Value<int?>? periodLengthDays,
      Value<String?>? notes}) {
    return MenstrualCyclesCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lengthDays: lengthDays ?? this.lengthDays,
      periodLengthDays: periodLengthDays ?? this.periodLengthDays,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (lengthDays.present) {
      map['length_days'] = Variable<int>(lengthDays.value);
    }
    if (periodLengthDays.present) {
      map['period_length_days'] = Variable<int>(periodLengthDays.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MenstrualCyclesCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('lengthDays: $lengthDays, ')
          ..write('periodLengthDays: $periodLengthDays, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) => AppSetting(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyLogEntriesTable dailyLogEntries =
      $DailyLogEntriesTable(this);
  late final $MenstrualCyclesTable menstrualCycles =
      $MenstrualCyclesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dailyLogEntries, menstrualCycles, appSettings];
}

typedef $$DailyLogEntriesTableCreateCompanionBuilder = DailyLogEntriesCompanion
    Function({
  Value<int> id,
  required DateTime date,
  Value<int> flow,
  Value<int> mucus,
  Value<String> moods,
  Value<String> symptoms,
  Value<double?> bbt,
  Value<double?> weight,
  Value<double?> hydrationLiters,
  Value<double?> sleepHours,
  Value<int?> sleepQuality,
  Value<bool?> hadSex,
  Value<bool?> sexProtected,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$DailyLogEntriesTableUpdateCompanionBuilder = DailyLogEntriesCompanion
    Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> flow,
  Value<int> mucus,
  Value<String> moods,
  Value<String> symptoms,
  Value<double?> bbt,
  Value<double?> weight,
  Value<double?> hydrationLiters,
  Value<double?> sleepHours,
  Value<int?> sleepQuality,
  Value<bool?> hadSex,
  Value<bool?> sexProtected,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$DailyLogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyLogEntriesTable> {
  $$DailyLogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get flow => $composableBuilder(
      column: $table.flow, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mucus => $composableBuilder(
      column: $table.mucus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get moods => $composableBuilder(
      column: $table.moods, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bbt => $composableBuilder(
      column: $table.bbt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hydrationLiters => $composableBuilder(
      column: $table.hydrationLiters,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hadSex => $composableBuilder(
      column: $table.hadSex, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sexProtected => $composableBuilder(
      column: $table.sexProtected, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyLogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyLogEntriesTable> {
  $$DailyLogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get flow => $composableBuilder(
      column: $table.flow, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mucus => $composableBuilder(
      column: $table.mucus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get moods => $composableBuilder(
      column: $table.moods, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bbt => $composableBuilder(
      column: $table.bbt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hydrationLiters => $composableBuilder(
      column: $table.hydrationLiters,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hadSex => $composableBuilder(
      column: $table.hadSex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sexProtected => $composableBuilder(
      column: $table.sexProtected,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyLogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyLogEntriesTable> {
  $$DailyLogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get flow =>
      $composableBuilder(column: $table.flow, builder: (column) => column);

  GeneratedColumn<int> get mucus =>
      $composableBuilder(column: $table.mucus, builder: (column) => column);

  GeneratedColumn<String> get moods =>
      $composableBuilder(column: $table.moods, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<double> get bbt =>
      $composableBuilder(column: $table.bbt, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get hydrationLiters => $composableBuilder(
      column: $table.hydrationLiters, builder: (column) => column);

  GeneratedColumn<double> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => column);

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
      column: $table.sleepQuality, builder: (column) => column);

  GeneratedColumn<bool> get hadSex =>
      $composableBuilder(column: $table.hadSex, builder: (column) => column);

  GeneratedColumn<bool> get sexProtected => $composableBuilder(
      column: $table.sexProtected, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyLogEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyLogEntriesTable,
    DailyLogEntry,
    $$DailyLogEntriesTableFilterComposer,
    $$DailyLogEntriesTableOrderingComposer,
    $$DailyLogEntriesTableAnnotationComposer,
    $$DailyLogEntriesTableCreateCompanionBuilder,
    $$DailyLogEntriesTableUpdateCompanionBuilder,
    (
      DailyLogEntry,
      BaseReferences<_$AppDatabase, $DailyLogEntriesTable, DailyLogEntry>
    ),
    DailyLogEntry,
    PrefetchHooks Function()> {
  $$DailyLogEntriesTableTableManager(
      _$AppDatabase db, $DailyLogEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyLogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> flow = const Value.absent(),
            Value<int> mucus = const Value.absent(),
            Value<String> moods = const Value.absent(),
            Value<String> symptoms = const Value.absent(),
            Value<double?> bbt = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<double?> hydrationLiters = const Value.absent(),
            Value<double?> sleepHours = const Value.absent(),
            Value<int?> sleepQuality = const Value.absent(),
            Value<bool?> hadSex = const Value.absent(),
            Value<bool?> sexProtected = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyLogEntriesCompanion(
            id: id,
            date: date,
            flow: flow,
            mucus: mucus,
            moods: moods,
            symptoms: symptoms,
            bbt: bbt,
            weight: weight,
            hydrationLiters: hydrationLiters,
            sleepHours: sleepHours,
            sleepQuality: sleepQuality,
            hadSex: hadSex,
            sexProtected: sexProtected,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            Value<int> flow = const Value.absent(),
            Value<int> mucus = const Value.absent(),
            Value<String> moods = const Value.absent(),
            Value<String> symptoms = const Value.absent(),
            Value<double?> bbt = const Value.absent(),
            Value<double?> weight = const Value.absent(),
            Value<double?> hydrationLiters = const Value.absent(),
            Value<double?> sleepHours = const Value.absent(),
            Value<int?> sleepQuality = const Value.absent(),
            Value<bool?> hadSex = const Value.absent(),
            Value<bool?> sexProtected = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              DailyLogEntriesCompanion.insert(
            id: id,
            date: date,
            flow: flow,
            mucus: mucus,
            moods: moods,
            symptoms: symptoms,
            bbt: bbt,
            weight: weight,
            hydrationLiters: hydrationLiters,
            sleepHours: sleepHours,
            sleepQuality: sleepQuality,
            hadSex: hadSex,
            sexProtected: sexProtected,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyLogEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyLogEntriesTable,
    DailyLogEntry,
    $$DailyLogEntriesTableFilterComposer,
    $$DailyLogEntriesTableOrderingComposer,
    $$DailyLogEntriesTableAnnotationComposer,
    $$DailyLogEntriesTableCreateCompanionBuilder,
    $$DailyLogEntriesTableUpdateCompanionBuilder,
    (
      DailyLogEntry,
      BaseReferences<_$AppDatabase, $DailyLogEntriesTable, DailyLogEntry>
    ),
    DailyLogEntry,
    PrefetchHooks Function()>;
typedef $$MenstrualCyclesTableCreateCompanionBuilder = MenstrualCyclesCompanion
    Function({
  Value<int> id,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<int?> lengthDays,
  Value<int?> periodLengthDays,
  Value<String?> notes,
});
typedef $$MenstrualCyclesTableUpdateCompanionBuilder = MenstrualCyclesCompanion
    Function({
  Value<int> id,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<int?> lengthDays,
  Value<int?> periodLengthDays,
  Value<String?> notes,
});

class $$MenstrualCyclesTableFilterComposer
    extends Composer<_$AppDatabase, $MenstrualCyclesTable> {
  $$MenstrualCyclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lengthDays => $composableBuilder(
      column: $table.lengthDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get periodLengthDays => $composableBuilder(
      column: $table.periodLengthDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$MenstrualCyclesTableOrderingComposer
    extends Composer<_$AppDatabase, $MenstrualCyclesTable> {
  $$MenstrualCyclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lengthDays => $composableBuilder(
      column: $table.lengthDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get periodLengthDays => $composableBuilder(
      column: $table.periodLengthDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$MenstrualCyclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MenstrualCyclesTable> {
  $$MenstrualCyclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get lengthDays => $composableBuilder(
      column: $table.lengthDays, builder: (column) => column);

  GeneratedColumn<int> get periodLengthDays => $composableBuilder(
      column: $table.periodLengthDays, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$MenstrualCyclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MenstrualCyclesTable,
    MenstrualCycle,
    $$MenstrualCyclesTableFilterComposer,
    $$MenstrualCyclesTableOrderingComposer,
    $$MenstrualCyclesTableAnnotationComposer,
    $$MenstrualCyclesTableCreateCompanionBuilder,
    $$MenstrualCyclesTableUpdateCompanionBuilder,
    (
      MenstrualCycle,
      BaseReferences<_$AppDatabase, $MenstrualCyclesTable, MenstrualCycle>
    ),
    MenstrualCycle,
    PrefetchHooks Function()> {
  $$MenstrualCyclesTableTableManager(
      _$AppDatabase db, $MenstrualCyclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MenstrualCyclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MenstrualCyclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MenstrualCyclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<int?> lengthDays = const Value.absent(),
            Value<int?> periodLengthDays = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              MenstrualCyclesCompanion(
            id: id,
            startDate: startDate,
            endDate: endDate,
            lengthDays: lengthDays,
            periodLengthDays: periodLengthDays,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<int?> lengthDays = const Value.absent(),
            Value<int?> periodLengthDays = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              MenstrualCyclesCompanion.insert(
            id: id,
            startDate: startDate,
            endDate: endDate,
            lengthDays: lengthDays,
            periodLengthDays: periodLengthDays,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MenstrualCyclesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MenstrualCyclesTable,
    MenstrualCycle,
    $$MenstrualCyclesTableFilterComposer,
    $$MenstrualCyclesTableOrderingComposer,
    $$MenstrualCyclesTableAnnotationComposer,
    $$MenstrualCyclesTableCreateCompanionBuilder,
    $$MenstrualCyclesTableUpdateCompanionBuilder,
    (
      MenstrualCycle,
      BaseReferences<_$AppDatabase, $MenstrualCyclesTable, MenstrualCycle>
    ),
    MenstrualCycle,
    PrefetchHooks Function()>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
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
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyLogEntriesTableTableManager get dailyLogEntries =>
      $$DailyLogEntriesTableTableManager(_db, _db.dailyLogEntries);
  $$MenstrualCyclesTableTableManager get menstrualCycles =>
      $$MenstrualCyclesTableTableManager(_db, _db.menstrualCycles);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
