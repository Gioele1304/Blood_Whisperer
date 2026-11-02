import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/app_mode.dart';
import '../../providers/app_mode_provider.dart';
import '../../providers/pregnancy_provider.dart';
import '../../features/import/flo_import_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(appModeProvider);
    final pregnancy = ref.watch(pregnancyInfoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Impostazioni')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Modalità operativa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          ...AppMode.values.map((m) {
            return RadioListTile<AppMode>(
              title: Text(m.label),
              subtitle: Text(m.description),
              value: m,
              groupValue: mode,
              onChanged: (v) {
                if (v != null) ref.read(appModeProvider.notifier).setMode(v);
              },
            );
          }),
          const Divider(),
          if (mode == AppMode.pregnancy)
            ListTile(
              leading: const Icon(Icons.pregnant_woman),
              title: const Text('Configura gravidanza'),
              subtitle: pregnancy == null
                  ? const Text('Nessuna data impostata')
                  : Text(
                      'Settimana ${pregnancy.gestationalWeeks}, parto previsto '
                      '${pregnancy.calculatedDueDate.day}/'
                      '${pregnancy.calculatedDueDate.month}/'
                      '${pregnancy.calculatedDueDate.year}'),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  helpText: 'Ultima mestruazione',
                );
                if (picked != null) {
                  ref.read(pregnancyInfoProvider.notifier).setLmp(picked);
                }
              },
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Importa dati da Flo'),
            subtitle: const Text('CSV o JSON esportato'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FloImportScreen()),
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Blood Whisperer — v1.0.0\nLe informazioni non sostituiscono il parere medico.',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
