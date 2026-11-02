import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/daily_log.dart';
import '../../providers/daily_log_provider.dart';

class DailyLogForm extends ConsumerStatefulWidget {
  final DailyLog? initial;
  final DateTime? initialDate;

  const DailyLogForm({super.key, this.initial, this.initialDate});

  @override
  ConsumerState<DailyLogForm> createState() => _DailyLogFormState();
}

class _DailyLogFormState extends ConsumerState<DailyLogForm> {
  late DateTime _date;
  FlowIntensity _flow = FlowIntensity.none;
  CervicalMucusType _mucus = CervicalMucusType.none;
  final Set<MoodType> _moods = {};
  final Set<SymptomType> _symptoms = {};
  int? _sleepQuality;
  bool? _hadSex;
  bool? _sexProtected;
  final _notesCtrl = TextEditingController();
  final _bbtCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _hydrationCtrl = TextEditingController();
  final _sleepCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final init = widget.initial;
    _date = init?.date ?? widget.initialDate ?? DateTime.now();
    if (init != null) {
      _flow = init.flow;
      _mucus = init.mucus;
      _moods.addAll(init.moods);
      _symptoms.addAll(init.symptoms);
      _sleepQuality = init.sleepQuality;
      _hadSex = init.hadSex;
      _sexProtected = init.sexProtected;
      _notesCtrl.text = init.notes ?? '';
      if (init.bbt != null) _bbtCtrl.text = init.bbt!.toStringAsFixed(2);
      if (init.weight != null) _weightCtrl.text = init.weight!.toString();
      if (init.hydrationLiters != null) _hydrationCtrl.text = init.hydrationLiters!.toString();
      if (init.sleepHours != null) _sleepCtrl.text = init.sleepHours!.toString();
    }
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    _bbtCtrl.dispose();
    _weightCtrl.dispose();
    _hydrationCtrl.dispose();
    _sleepCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final now = DateTime.now();
    final log = DailyLog(
      id: widget.initial?.id,
      date: _date,
      flow: _flow,
      mucus: _mucus,
      moods: _moods.toList(),
      symptoms: _symptoms.toList(),
      bbt: double.tryParse(_bbtCtrl.text.replaceAll(',', '.')),
      weight: double.tryParse(_weightCtrl.text.replaceAll(',', '.')),
      hydrationLiters: double.tryParse(_hydrationCtrl.text.replaceAll(',', '.')),
      sleepHours: double.tryParse(_sleepCtrl.text.replaceAll(',', '.')),
      sleepQuality: _sleepQuality,
      hadSex: _hadSex,
      sexProtected: _sexProtected,
      notes: _notesCtrl.text.isEmpty ? null : _notesCtrl.text,
      createdAt: widget.initial?.createdAt ?? now,
      updatedAt: now,
    );

    await ref.read(dailyLogsProvider.notifier).upsert(log);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.initial == null ? 'Nuovo Log' : 'Modifica Log'),
          actions: [
            IconButton(icon: const Icon(Icons.check), onPressed: _save),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sintomi'),
              Tab(text: 'Umore'),
              Tab(text: 'Fluidi'),
              Tab(text: 'Bio'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _symptomsTab(),
            _moodsTab(),
            _fluidsTab(),
            _bioTab(),
          ],
        ),
      ),
    );
  }

  Widget _symptomsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _datePicker(),
        const Divider(height: 32),
        const Text('Sintomi fisici', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: SymptomType.values.map((s) {
            return FilterChip(
              label: Text(_symptomLabel(s)),
              selected: _symptoms.contains(s),
              onSelected: (v) => setState(() {
                if (v) {
                  _symptoms.add(s);
                } else {
                  _symptoms.remove(s);
                }
              }),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _moodsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Umore', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MoodType.values.map((m) {
            return FilterChip(
              label: Text(_moodLabel(m)),
              selected: _moods.contains(m),
              onSelected: (v) => setState(() {
                if (v) {
                  _moods.add(m);
                } else {
                  _moods.remove(m);
                }
              }),
            );
          }).toList(),
        ),
        const Divider(height: 32),
        const Text('Qualità del sonno', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (i) {
            final v = i + 1;
            return IconButton(
              icon: Icon(_sleepQuality != null && v <= _sleepQuality! ? Icons.star : Icons.star_border),
              onPressed: () => setState(() => _sleepQuality = v),
            );
          }),
        ),
      ],
    );
  }

  Widget _fluidsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Flusso mestruale', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: FlowIntensity.values.map((f) {
            return ChoiceChip(
              label: Text(_flowLabel(f)),
              selected: _flow == f,
              onSelected: (_) => setState(() => _flow = f),
            );
          }).toList(),
        ),
        const Divider(height: 32),
        const Text('Muco cervicale', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: CervicalMucusType.values.map((m) {
            return ChoiceChip(
              label: Text(_mucusLabel(m)),
              selected: _mucus == m,
              onSelected: (_) => setState(() => _mucus = m),
            );
          }).toList(),
        ),
        const Divider(height: 32),
        const Text('Attività sessuale', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SwitchListTile(
          title: const Text('Rapporti'),
          value: _hadSex ?? false,
          onChanged: (v) => setState(() => _hadSex = v),
        ),
        if (_hadSex == true)
          SwitchListTile(
            title: const Text('Protetti'),
            value: _sexProtected ?? true,
            onChanged: (v) => setState(() => _sexProtected = v),
          ),
      ],
    );
  }

  Widget _bioTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _bbtCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'BBT (°C)',
            hintText: '36.65',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _weightCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Peso (kg)', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _hydrationCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Idratazione (L)', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _sleepCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Ore di sonno', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _notesCtrl,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Note', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: _save,
          icon: const Icon(Icons.save),
          label: const Text('Salva'),
        ),
      ],
    );
  }

  Widget _datePicker() {
    return ListTile(
      title: const Text('Data'),
      subtitle: Text('${_date.day}/${_date.month}/${_date.year}'),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) setState(() => _date = picked);
      },
    );
  }

  String _flowLabel(FlowIntensity f) {
    const m = {
      FlowIntensity.none: 'Nessuno',
      FlowIntensity.spotting: 'Spotting',
      FlowIntensity.light: 'Leggero',
      FlowIntensity.medium: 'Medio',
      FlowIntensity.heavy: 'Abbondante',
    };
    return m[f] ?? f.name;
  }

  String _mucusLabel(CervicalMucusType m) {
    const labels = {
      CervicalMucusType.none: 'Nessuno',
      CervicalMucusType.dry: 'Asciutto',
      CervicalMucusType.sticky: 'Appiccicoso',
      CervicalMucusType.creamy: 'Cremoso',
      CervicalMucusType.watery: 'Acquoso',
      CervicalMucusType.eggWhite: 'Filante',
    };
    return labels[m] ?? m.name;
  }

  String _moodLabel(MoodType m) {
    const labels = {
      MoodType.happy: 'Felice',
      MoodType.calm: 'Calmo',
      MoodType.anxious: 'Ansioso',
      MoodType.irritable: 'Irritabile',
      MoodType.sad: 'Triste',
      MoodType.energetic: 'Energico',
      MoodType.tired: 'Stanco',
    };
    return labels[m] ?? m.name;
  }

  String _symptomLabel(SymptomType s) {
    const labels = {
      SymptomType.cramps: 'Crampi',
      SymptomType.headache: 'Mal di testa',
      SymptomType.bloating: 'Gonfiore',
      SymptomType.acne: 'Acne',
      SymptomType.breastTenderness: 'Seno',
      SymptomType.fatigue: 'Affaticamento',
      SymptomType.backache: 'Mal di schiena',
      SymptomType.nausea: 'Nausea',
      SymptomType.cravings: 'Voglie',
      SymptomType.insomnia: 'Insonnia',
    };
    return labels[s] ?? s.name;
  }
}
