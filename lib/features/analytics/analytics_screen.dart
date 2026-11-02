import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/daily_log_provider.dart';
import '../../models/daily_log.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(dailyLogsProvider);
    final logs = logsAsync.maybeWhen(data: (d) => d, orElse: () => <DailyLog>[]);

    if (logs.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: const Center(child: Text('Nessun dato disponibile. Registra qualche log.')),
      );
    }

    final sorted = [...logs]..sort((a, b) => a.date.compareTo(b.date));
    final bbtPoints = sorted.where((l) => l.bbt != null).toList();
    final weightPoints = sorted.where((l) => l.weight != null).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Temperatura Corporea Basale', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: bbtPoints.isEmpty
                ? const Center(child: Text('Nessuna BBT registrata'))
                : LineChart(_bbtData(bbtPoints)),
          ),
          const SizedBox(height: 32),
          const Text('Peso', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: weightPoints.isEmpty
                ? const Center(child: Text('Nessun peso registrato'))
                : LineChart(_weightData(weightPoints)),
          ),
          const SizedBox(height: 32),
          const Text('Sintomi più frequenti', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _SymptomFrequency(logs: logs),
        ],
      ),
    );
  }

  LineChartData _bbtData(List<DailyLog> points) {
    final spots = <FlSpot>[];
    for (var i = 0; i < points.length; i++) {
      spots.add(FlSpot(i.toDouble(), points[i].bbt!));
    }
    return LineChartData(
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.pink,
          barWidth: 2,
          dotData: const FlDotData(show: true),
        ),
      ],
    );
  }

  LineChartData _weightData(List<DailyLog> points) {
    final spots = <FlSpot>[];
    for (var i = 0; i < points.length; i++) {
      spots.add(FlSpot(i.toDouble(), points[i].weight!));
    }
    return LineChartData(
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 2,
          dotData: const FlDotData(show: true),
        ),
      ],
    );
  }
}

class _SymptomFrequency extends StatelessWidget {
  final List<DailyLog> logs;
  const _SymptomFrequency({required this.logs});

  @override
  Widget build(BuildContext context) {
    final counts = <SymptomType, int>{};
    for (final log in logs) {
      for (final s in log.symptoms) {
        counts[s] = (counts[s] ?? 0) + 1;
      }
    }
    if (counts.isEmpty) return const Text('Nessun sintomo registrato');

    final sorted = counts.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final maxCount = sorted.first.value;

    return Column(
      children: sorted.take(8).map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              SizedBox(width: 120, child: Text(e.key.name)),
              Expanded(
                child: LinearProgressIndicator(
                  value: e.value / maxCount,
                  minHeight: 12,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(width: 8),
              Text('${e.value}'),
            ],
          ),
        );
      }).toList(),
    );
  }
}
