import 'package:flutter/material.dart';

class FertileWindowBadge extends StatelessWidget {
  final bool isFertile;
  final DateTime? ovulationDay;

  const FertileWindowBadge({super.key, required this.isFertile, this.ovulationDay});

  @override
  Widget build(BuildContext context) {
    final color = isFertile ? Colors.green : Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isFertile ? Icons.eco : Icons.eco_outlined, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            isFertile ? 'Finestra fertile' : 'Non fertile',
            style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

