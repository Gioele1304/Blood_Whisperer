import 'package:flutter/material.dart';

class CycleRing extends StatelessWidget {
  final int currentDay;
  final int cycleLength;
  final Color color;

  const CycleRing({
    super.key,
    required this.currentDay,
    required this.cycleLength,
    this.color = const Color(0xFFE91E63),
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentDay / cycleLength).clamp(0.0, 1.0);
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Giorno',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '$currentDay',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                'su $cycleLength',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
