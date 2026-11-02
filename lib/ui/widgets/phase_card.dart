import 'package:flutter/material.dart';
import '../../models/cycle.dart';

class PhaseCard extends StatelessWidget {
  final CyclePhaseInfo? phaseInfo;

  const PhaseCard({super.key, this.phaseInfo});

  @override
  Widget build(BuildContext context) {
    if (phaseInfo == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nessun dato ancora',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                'Registra qualche giorno per vedere la tua fase fisiologica.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    final info = phaseInfo!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.water_drop, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  info.phaseName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(info.description, style: Theme.of(context).textTheme.bodyMedium),
            const Divider(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.lightbulb_outline, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    info.lifestyleTip,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
