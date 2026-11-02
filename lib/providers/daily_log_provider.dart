import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../models/daily_log.dart';
import 'database_provider.dart';

class DailyLogNotifier extends StateNotifier<AsyncValue<List<DailyLog>>> {
  final AppDatabase _db;
  DailyLogNotifier(this._db) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final logs = await _db.getAllLogs();
      state = AsyncValue.data(logs);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> upsert(DailyLog log) async {
    await _db.upsertLog(log);
    await load();
  }

  Future<void> remove(int id) async {
    await _db.deleteLog(id);
    await load();
  }
}

final dailyLogsProvider =
    StateNotifierProvider<DailyLogNotifier, AsyncValue<List<DailyLog>>>(
  (ref) => DailyLogNotifier(ref.read(databaseProvider)),
);

final logsRangeProvider = FutureProvider.family<List<DailyLog>, DateTimeRange>(
  (ref, range) async {
    final db = ref.read(databaseProvider);
    return db.getLogsBetween(range.start, range.end);
  },
);

class DateTimeRange {
  final DateTime start;
  final DateTime end;
  const DateTimeRange(this.start, this.end);
}
