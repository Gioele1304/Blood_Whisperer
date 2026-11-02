import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../providers/database_provider.dart';
import '../../providers/daily_log_provider.dart';
import '../../services/flo_data_importer.dart';
import '../../models/flo_import.dart';

class FloImportScreen extends ConsumerStatefulWidget {
  const FloImportScreen({super.key});

  @override
  ConsumerState<FloImportScreen> createState() => _FloImportScreenState();
}

class _FloImportScreenState extends ConsumerState<FloImportScreen> {
  File? _file;
  bool _importing = false;
  FloImportResult? _result;

  Future<void> _pick() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'json'],
    );
    if (picked != null && picked.files.single.path != null) {
      setState(() {
        _file = File(picked.files.single.path!);
        _result = null;
      });
    }
  }

  Future<void> _import() async {
    if (_file == null) return;
    setState(() => _importing = true);

    final db = ref.read(databaseProvider);
    final importer = FloDataImporter(db);
    final ext = _file!.path.split('.').last.toLowerCase();

    FloImportResult result;
    try {
      result = ext == 'csv'
          ? await importer.importCsv(_file!)
          : await importer.importJson(_file!);
    } catch (e) {
      result = FloImportResult(
        totalRows: 0,
        imported: 0,
        skipped: 0,
        errors: ['Errore: $e'],
      );
    }

    await ref.read(dailyLogsProvider.notifier).load();

    setState(() {
      _importing = false;
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Importa da Flo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.file_upload),
              title: Text(_file == null
                  ? 'Nessun file selezionato'
                  : _file!.path.split('/').last),
              subtitle: const Text('CSV o JSON esportato da Flo'),
              trailing: FilledButton(onPressed: _pick, child: const Text('Scegli')),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _file == null || _importing ? null : _import,
            icon: _importing
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.download),
            label: Text(_importing ? 'Importazione...' : 'Importa'),
          ),
          if (_result != null) ...[
            const SizedBox(height: 24),
            Card(
              color: _result!.errors.isEmpty
                  ? Colors.green.shade50
                  : Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Righe totali: ${_result!.totalRows}'),
                    Text('Importate: ${_result!.imported}'),
                    Text('Saltate: ${_result!.skipped}'),
                    if (_result!.errors.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Text('Errori:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ..._result!.errors
                          .take(5)
                          .map((e) => Text('• $e',
                              style: const TextStyle(fontSize: 12))),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
