import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/daily_log.dart';
import '../../providers/cycle_provider.dart';
import '../../providers/daily_log_provider.dart';
import '../../features/daily_log/daily_log_form.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focused = DateTime.now();
  DateTime _selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(dailyLogsProvider);
    final logs = logsAsync.maybeWhen(data: (d) => d, orElse: () => <DailyLog>[]);
    final fertile = ref.watch(fertileWindowProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendario')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focused,
            selectedDayPredicate: (d) => isSameDay(_selected, d),
            onDaySelected: (sel, foc) {
              setState(() {
                _selected = sel;
                _focused = foc;
              });
              final log = logs.firstWhere(
                (l) => isSameDay(l.date, sel),
                orElse: () => DailyLog(
                  date: sel,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => DailyLogForm(initial: log.id != null ? log : null, initialDate: sel)),
              );
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                final log = logs.where((l) => isSameDay(l.date, day)).firstOrNull;
                final isFertile = fertile?.contains(day) ?? false;
                if (log == null && !isFertile) return null;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (log != null && log.flow != FlowIntensity.none)
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      ),
                    if (isFertile)
                      Container(
                        margin: const EdgeInsets.only(top: 24, left: 4),
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                      ),
                  ],
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Legend(color: Colors.red, label: 'Flusso'),
                _Legend(color: Colors.green, label: 'Finestra fertile'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
