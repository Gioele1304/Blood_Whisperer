import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import '../models/daily_log.dart';
import '../models/cycle.dart';

part 'app_database.g.dart';

class DailyLogEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get flow => integer().withDefault(const Constant(0))();
  IntColumn get mucus => integer().withDefault(const Constant(0))();
  TextColumn get moods => text().withDefault(const Constant(''))();
  TextColumn get symptoms => text().withDefault(const Constant(''))();
  RealColumn get bbt => real().nullable()();
  RealColumn get weight => real().nullable()();
  RealColumn get hydrationLiters => real().nullable()();
  RealColumn get sleepHours => real().nullable()();
  IntColumn get sleepQuality => integer().nullable()();
  BoolColumn get hadSex => boolean().nullable()();
  BoolColumn get sexProtected => boolean().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class MenstrualCycles extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get lengthDays => integer().nullable()();
  IntColumn get periodLengthDays => integer().nullable()();
  TextColumn get notes => text().nullable()();
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [DailyLogEntries, MenstrualCycles, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  // ---------------- Daily Logs ----------------

  Future<List<DailyLog>> getAllLogs() async {
    final rows = await (select(dailyLogEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
    return rows.map(_mapLog).toList();
  }

  Future<DailyLog?> getLogByDate(DateTime date) async {
    final d = DateTime(date.year, date.month, date.day);
    final row = await (select(dailyLogEntries)
          ..where((t) => t.date.equals(d)))
        .getSingleOrNull();
    return row == null ? null : _mapLog(row);
  }

  Future<List<DailyLog>> getLogsBetween(DateTime from, DateTime to) async {
    final rows = await (select(dailyLogEntries)
          ..where((t) => t.date.isBetweenValues(from, to))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
    return rows.map(_mapLog).toList();
  }

  Future<int> upsertLog(DailyLog log) async {
    final d = DateTime(log.date.year, log.date.month, log.date.day);
    final existing = await (select(dailyLogEntries)..where((t) => t.date.equals(d)))
        .getSingleOrNull();

    final companion = DailyLogEntriesCompanion(
      id: log.id != null ? Value(log.id!) : const Value.absent(),
      date: Value(d),
      flow: Value(log.flow.index),
      mucus: Value(log.mucus.index),
      moods: Value(log.moods.map((m) => m.index).join(',')),
      symptoms: Value(log.symptoms.map((s) => s.index).join(',')),
      bbt: Value(log.bbt),
      weight: Value(log.weight),
      hydrationLiters: Value(log.hydrationLiters),
      sleepHours: Value(log.sleepHours),
      sleepQuality: Value(log.sleepQuality),
      hadSex: Value(log.hadSex),
      sexProtected: Value(log.sexProtected),
      notes: Value(log.notes),
      createdAt: Value(log.createdAt),
      updatedAt: Value(DateTime.now()),
    );

    if (existing != null) {
      await (update(dailyLogEntries)..where((t) => t.id.equals(existing.id)))
          .write(companion);
      return existing.id;
    }
    return into(dailyLogEntries).insert(companion);
  }

  Future<void> deleteLog(int id) async {
    await (delete(dailyLogEntries)..where((t) => t.id.equals(id))).go();
  }

  DailyLog _mapLog(DailyLogEntry row) {
    return DailyLog(
      id: row.id,
      date: row.date,
      flow: FlowIntensity.values[row.flow],
      mucus: CervicalMucusType.values[row.mucus],
      moods: row.moods.isEmpty
          ? []
          : row.moods.split(',').map((e) => MoodType.values[int.parse(e)]).toList(),
      symptoms: row.symptoms.isEmpty
          ? []
          : row.symptoms
              .split(',')
              .map((e) => SymptomType.values[int.parse(e)])
              .toList(),
      bbt: row.bbt,
      weight: row.weight,
      hydrationLiters: row.hydrationLiters,
      sleepHours: row.sleepHours,
      sleepQuality: row.sleepQuality,
      hadSex: row.hadSex,
      sexProtected: row.sexProtected,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  // ---------------- Cycles ----------------

    Future<List<Cycle>> getAllCycles() async {
    final rows = await (select(menstrualCycles)
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
        .get();
    return rows
        .map((r) => Cycle(
              id: r.id,
              startDate: r.startDate,
              endDate: r.endDate,
              lengthDays: r.lengthDays,
              periodLengthDays: r.periodLengthDays,
              notes: r.notes,
            ))
        .toList();
  }

  Future<int> insertCycle(Cycle cycle) {
    return into(menstrualCycles).insert(MenstrualCyclesCompanion.insert(
      startDate: cycle.startDate,
      endDate: Value(cycle.endDate),
      lengthDays: Value(cycle.lengthDays),
      periodLengthDays: Value(cycle.periodLengthDays),
      notes: Value(cycle.notes),
    ));
  }

  Future<void> deleteCycle(int id) async {
    await (delete(menstrualCycles)..where((t) => t.id.equals(id))).go();
  }

  

  // ---------------- Settings ----------------

  Future<String?> getSetting(String key) async {
    final row = await (select(appSettings)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setSetting(String key, String value) async {
    await into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(key: key, value: value),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'blood_whisperer.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
