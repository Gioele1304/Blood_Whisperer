import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';

import '../database/app_database.dart';
import '../models/daily_log.dart';
import '../models/flo_import.dart';

class FloDataImporter {
  final AppDatabase _db;

  FloDataImporter(this._db);

  /// Importa da file CSV esportato da Flo.
  Future<FloImportResult> importCsv(File file) async {
    final raw = await file.readAsString();
    final rows = const CsvToListConverter(eol: '\n', shouldParseNumbers: false)
        .convert(raw);

    if (rows.isEmpty) {
      return const FloImportResult(
        totalRows: 0,
        imported: 0,
        skipped: 0,
        errors: ['File CSV vuoto o non valido'],
      );
    }

    final header = rows.first.map((e) => e.toString().toLowerCase()).toList();
    final dataRows = rows.skip(1).toList();

    final parsed = <FloImportRow>[];
    final errors = <String>[];

    for (var i = 0; i < dataRows.length; i++) {
      try {
        final row = dataRows[i];
        final map = <String, dynamic>{};
        for (var j = 0; j < header.length && j < row.length; j++) {
          map[header[j]] = row[j];
        }
        final parsedRow = _parseCsvRow(map);
        if (parsedRow != null) parsed.add(parsedRow);
      } catch (e) {
        errors.add('Riga ${i + 2}: $e');
      }
    }

    return _persist(parsed, errors);
  }

  /// Importa da file JSON esportato da Flo.
  Future<FloImportResult> importJson(File file) async {
    final raw = await file.readAsString();
    final decoded = jsonDecode(raw);
    final errors = <String>[];
    final parsed = <FloImportRow>[];

    final List<dynamic> entries;
    if (decoded is List) {
      entries = decoded;
    } else if (decoded is Map && decoded['data'] is List) {
      entries = decoded['data'] as List;
    } else {
      return const FloImportResult(
        totalRows: 0,
        imported: 0,
        skipped: 0,
        errors: ['Struttura JSON non riconosciuta'],
      );
    }

    for (var i = 0; i < entries.length; i++) {
      try {
        final e = entries[i];
        if (e is! Map) continue;
        final parsedRow = _parseJsonRow(Map<String, dynamic>.from(e));
        if (parsedRow != null) parsed.add(parsedRow);
      } catch (err) {
        errors.add('Elemento $i: $err');
      }
    }

    return _persist(parsed, errors);
  }

  FloImportRow? _parseCsvRow(Map<String, dynamic> row) {
    final dateStr = _firstNonNull(row, [
      'date',
      'day',
      'data',
      'data_mestruale',
    ]);
    if (dateStr == null) return null;
    final date = _parseDate(dateStr.toString());
    if (date == null) return null;

    return FloImportRow(
      date: date,
      symptoms: _firstNonNull(row, ['symptoms', 'sintomi', 'symptom'])?.toString(),
      moods: _firstNonNull(row, ['moods', 'umore', 'mood'])?.toString(),
      flow: _firstNonNull(row, ['flow', 'flusso', 'bleeding'])?.toString(),
      bbt: _parseDouble(_firstNonNull(row, ['bbt', 'temperature', 'temp'])),
      weight: _parseDouble(_firstNonNull(row, ['weight', 'peso'])),
      notes: _firstNonNull(row, ['notes', 'note'])?.toString(),
    );
  }

  FloImportRow? _parseJsonRow(Map<String, dynamic> json) {
    final dateStr = _firstNonNull(json, [
      'date',
      'day',
      'data',
    ]);
    if (dateStr == null) return null;
    final date = _parseDate(dateStr.toString());
    if (date == null) return null;

    final symptoms = json['symptoms'] ?? json['sintomi'];
    final moods = json['moods'] ?? json['umore'];

    return FloImportRow(
      date: date,
      symptoms: symptoms is List ? symptoms.join(',') : symptoms?.toString(),
      moods: moods is List ? moods.join(',') : moods?.toString(),
      flow: (json['flow'] ?? json['flusso'])?.toString(),
      bbt: _parseDouble(json['bbt'] ?? json['temperature']),
      weight: _parseDouble(json['weight'] ?? json['peso']),
      notes: (json['notes'] ?? json['note'])?.toString(),
    );
  }

  dynamic _firstNonNull(Map<String, dynamic> map, List<String> keys) {
    for (final k in keys) {
      if (map.containsKey(k) && map[k] != null && map[k].toString().isNotEmpty) {
        return map[k];
      }
    }
    return null;
  }

  DateTime? _parseDate(String raw) {
    raw = raw.trim();
    final formats = [
      RegExp(r'^(\d{4})-(\d{2})-(\d{2})'),
      RegExp(r'^(\d{2})/(\d{2})/(\d{4})'),
      RegExp(r'^(\d{2})-(\d{2})-(\d{4})'),
    ];
    for (final f in formats) {
      final m = f.firstMatch(raw);
      if (m != null) {
        try {
          if (f.pattern.startsWith(r'^(\d{4})')) {
            return DateTime(
                int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!));
          } else {
            return DateTime(
                int.parse(m[3]!), int.parse(m[2]!), int.parse(m[1]!));
          }
        } catch (_) {}
      }
    }
    return DateTime.tryParse(raw);
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString().replaceAll(',', '.'));
  }

  FlowIntensity _mapFlow(String? raw) {
    if (raw == null) return FlowIntensity.none;
    final s = raw.toLowerCase();
    if (s.contains('spot') || s.contains('macch')) return FlowIntensity.spotting;
    if (s.contains('light') || s.contains('leggero')) return FlowIntensity.light;
    if (s.contains('medium') || s.contains('medio')) return FlowIntensity.medium;
    if (s.contains('heavy') || s.contains('abbo')) return FlowIntensity.heavy;
    return FlowIntensity.none;
  }

  List<SymptomType> _mapSymptoms(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    final result = <SymptomType>[];
    final s = raw.toLowerCase();
    for (final t in SymptomType.values) {
      if (s.contains(t.name.toLowerCase())) result.add(t);
    }
    // Mapping italiano
    final itMap = {
      'crampi': SymptomType.cramps,
      'mal di testa': SymptomType.headache,
      'gonfiore': SymptomType.bloating,
      'acne': SymptomType.acne,
      'seno': SymptomType.breastTenderness,
      'affatic': SymptomType.fatigue,
      'mal di schiena': SymptomType.backache,
      'nausea': SymptomType.nausea,
      'voglie': SymptomType.cravings,
      'insonnia': SymptomType.insomnia,
    };
    itMap.forEach((k, v) {
      if (s.contains(k) && !result.contains(v)) result.add(v);
    });
    return result;
  }

  List<MoodType> _mapMoods(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    final result = <MoodType>[];
    final s = raw.toLowerCase();
    for (final t in MoodType.values) {
      if (s.contains(t.name.toLowerCase())) result.add(t);
    }
    final itMap = <String, MoodType>{
      'felice': MoodType.happy,
      'calmo': MoodType.calm,
      'ansia': MoodType.anxious,
      'irritab': MoodType.irritable,
      'triste': MoodType.sad,
      'energi': MoodType.energetic,
      'stanco': MoodType.tired,
    };
    itMap.forEach((k, v) {
      if (s.contains(k) && !result.contains(v)) result.add(v);
    });
    return result;
  }

  Future<FloImportResult> _persist(
    List<FloImportRow> rows,
    List<String> errors,
  ) async {
    var imported = 0;
    var skipped = 0;

    for (final row in rows) {
      try {
        final log = DailyLog(
          date: row.date,
          flow: _mapFlow(row.flow),
          symptoms: _mapSymptoms(row.symptoms),
          moods: _mapMoods(row.moods),
          bbt: row.bbt,
          weight: row.weight,
          notes: row.notes,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _db.upsertLog(log);
        imported++;
      } catch (e) {
        skipped++;
        errors.add('${row.date.toIso8601String()}: $e');
      }
    }

    return FloImportResult(
      totalRows: rows.length,
      imported: imported,
      skipped: skipped,
      errors: errors,
    );
  }
}
