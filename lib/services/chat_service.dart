import '../models/cycle.dart';
import '../models/daily_log.dart';
import '../models/app_mode.dart';
import '../models/pregnancy_info.dart';

class ChatResponse {
  final String text;
  final List<String> suggestions;
  final List<String> quickReplies;

  const ChatResponse({
    required this.text,
    this.suggestions = const [],
    this.quickReplies = const [],
  });
}

class ChatService {
  /// Genera risposta basata sullo stato ormonale e sulla domanda dell'utente.
  ChatResponse respond({
    required String userMessage,
    required AppMode mode,
    CyclePhase? currentPhase,
    PregnancyInfo? pregnancyInfo,
    DailyLog? todayLog,
    List<DailyLog> recentLogs = const [],
  }) {
    final q = userMessage.toLowerCase();

    // Domande sulla fase corrente
    if (_containsAny(q, ['fase', 'phase', 'dove sono', 'cosa succede'])) {
      return _phaseExplanation(currentPhase, mode);
    }

    // Domande sulla fertilità
    if (_containsAny(q, ['fertile', 'ovulazione', 'ovulo', 'concepire'])) {
      return _fertilityAnswer(mode, currentPhase);
    }

    // Domande sulla gravidanza
    if (_containsAny(q, ['gravidanza', 'incinta', 'settimane', 'parto'])) {
      return _pregnancyAnswer(pregnancyInfo);
    }

    // Domande sui sintomi
    if (_containsAny(q, ['sintomo', 'crampi', 'mal di testa', 'gonfiore'])) {
      return _symptomsAnswer(todayLog, currentPhase);
    }

    // Domande su BBT
    if (_containsAny(q, ['temperatura', 'bbt', 'basale'])) {
      return _bbtAnswer(recentLogs, currentPhase);
    }

    // Domande su umore
    if (_containsAny(q, ['umore', 'ansia', 'stress', 'triste'])) {
      return _moodAnswer(currentPhase, mode);
    }

    // Domande su perimenopausa
    if (_containsAny(q, ['perimenopausa', 'vampate', 'irregolare'])) {
      return _perimenopauseAnswer(mode);
    }

    // Domanda generica
    return _genericAnswer(mode, currentPhase);
  }

  bool _containsAny(String text, List<String> keywords) {
    return keywords.any((k) => text.contains(k));
  }

  ChatResponse _phaseExplanation(CyclePhase? phase, AppMode mode) {
    if (mode == AppMode.pregnancy) {
      return const ChatResponse(
        text:
            'Durante la gravidanza il ciclo è sospeso: il corpo mantiene alti progesterone ed estrogeni per sostenere la gestazione. Non ci sono fasi mestruali fino al post-parto.',
        suggestions: [
          'L\'aumento di estrogeni può causare nausea e stanchezza',
          'Il progesterone favorisce il rilassamento della muscolatura liscia',
        ],
        quickReplies: [
          'Come gestire la nausea?',
          'Quali esami fare nel primo trimestre?',
        ],
      );
    }

    if (phase == null) {
      return const ChatResponse(
        text:
            'Non ho ancora abbastanza dati per determinare la tua fase. Registra qualche giorno di log per farmi calcolare il ciclo.',
        quickReplies: ['Vai al Daily Log', 'Come funziona il calcolo?'],
      );
    }

    switch (phase) {
      case CyclePhase.menstrual:
        return const ChatResponse(
          text:
              'Sei nella fase mestruale. Estrogeni e progesterone sono ai minimi, l\'utero si sfalda. Puoi sentirti stanca e con crampi.',
          suggestions: [
            'Aumenta l\'apporto di ferro (legumi, spinaci, carne rossa)',
            'Riposa di più e usa impacchi caldi per i crampi',
            'Riduci caffeina e alcol',
          ],
          quickReplies: [
            'Come alleviare i crampi?',
            'Quando finisce il ciclo?',
          ],
        );
      case CyclePhase.follicular:
        return const ChatResponse(
          text:
              'Sei nella fase follicolare: gli estrogeni risalgono, l\'energia e l\'umore migliorano. È il momento ideale per attività intense.',
          suggestions: [
            'Ottimo periodo per allenamenti ad alta intensità',
            'Inizia nuovi progetti e attività sociali',
            'Aumenta le proteine per sostenere la crescita follicolare',
          ],
          quickReplies: [
            'Quando sarà la mia ovulazione?',
            'Come calcolo la finestra fertile?',
          ],
        );
      case CyclePhase.ovulatory:
        return const ChatResponse(
          text:
              'Sei nella fase ovulatoria: picco di LH ed estrogeni, l\'ovulo viene rilasciato. È la fase più fertile del ciclo.',
          suggestions: [
            'Finestra fertile: 5 giorni prima + giorno dell\'ovulazione',
            'Il muco cervicale è filante e trasparente come albume',
            'Possibile leggero dolore pelvico (mittelschmerz)',
          ],
          quickReplies: [
            'Come riconoscere il muco fertile?',
            'Quanto dura la finestra fertile?',
          ],
        );
      case CyclePhase.luteal:
        return const ChatResponse(
          text:
              'Sei nella fase luteale: il corpo luteo produce progesterone. Possibili sintomi premestruali (PMS) come irritabilità, gonfiore e fame.',
          suggestions: [
            'Aggiungi magnesio (frutta secca, banane, cioccolato fondente)',
            'Riduci sale e caffeina per limitare il gonfiore',
            'Preferisci attività leggere come yoga o camminate',
          ],
          quickReplies: [
            'Come ridurre i sintomi premestruali?',
            'Quando arriverà il prossimo ciclo?',
          ],
        );
    }
  }

  ChatResponse _fertilityAnswer(AppMode mode, CyclePhase? phase) {
    if (mode == AppMode.tryingToConceive) {
      final msg = phase == CyclePhase.ovulatory
          ? 'Sei nel picco fertile! Oggi e i prossimi 1-2 giorni sono i migliori per provare a concepire.'
          : 'La finestra fertile comprende i 5 giorni prima dell\'ovulazione e il giorno stesso. Il picco di fertilità è nelle 48 ore precedenti l\'ovulazione.';
      return ChatResponse(
        text: msg,
        suggestions: const [
          'Monitora la BBT al risveglio: sale di 0,2-0,5°C dopo l\'ovulazione',
          'Osserva il muco cervicale: filante e trasparente indica fertilità',
          'I test di ovulazione rilevano il picco di LH nelle urine',
        ],
        quickReplies: const [
          'Come funziona la BBT?',
          'Quando fare il test di ovulazione?',
        ],
      );
    }
    return const ChatResponse(
      text:
          'La finestra fertile è il periodo in cui la probabilità di concepimento è più alta: comprende i 5 giorni precedenti l\'ovulazione e il giorno stesso. Puoi attivare la modalità "Ricerca Gravidanza" per evidenziarla nel calendario.',
      quickReplies: [
        'Attiva modalità Ricerca Gravidanza',
        'Come si calcola l\'ovulazione?',
      ],
    );
  }

  ChatResponse _pregnancyAnswer(PregnancyInfo? info) {
    if (info == null) {
      return const ChatResponse(
        text:
            'Non hai ancora configurato una gravidanza. Vai nelle impostazioni e inserisci l\'ultima mestruazione (LMP) per calcolare settimane e data presunta del parto.',
        quickReplies: [
          'Configura gravidanza',
          'Come si calcola la data del parto?',
        ],
      );
    }

    final weeks = info.gestationalWeeks;
    final days = info.gestationalDaysRemainder;
    final trimester = info.trimester;

    String trimesterMsg;
    switch (trimester) {
      case 1:
        trimesterMsg =
            'Primo trimestre: si formano gli organi principali. Possibili nausea, stanchezza e sonnolenza.';
        break;
      case 2:
        trimesterMsg =
            'Secondo trimestre: spesso il più confortevole. Iniziano i movimenti fetali percepibili.';
        break;
      default:
        trimesterMsg =
            'Terzo trimestre: crescita rapida del feto, possibili contrazioni di Braxton-Hicks e difficoltà a dormire.';
    }

    return ChatResponse(
      text:
          'Sei a $weeks settimane e $days giorni di gravidanza ($trimester° trimestre).\n\n$trimesterMsg',
      suggestions: [
        'Data presunta del parto: ${_formatDate(info.calculatedDueDate)}',
        'Idratati bene e assumi acido folico',
        'Contatta il ginecologo per eventuali dubbi',
      ],
      quickReplies: [
        'Cosa mangiare in gravidanza?',
        'Quando fare l\'ecografia morfologica?',
      ],
    );
  }

  ChatResponse _symptomsAnswer(DailyLog? today, CyclePhase? phase) {
    if (today == null || today.symptoms.isEmpty) {
      return const ChatResponse(
        text:
            'Non hai registrato sintomi oggi. Puoi aggiungerli nel Daily Log per ricevere suggerimenti personalizzati.',
        quickReplies: ['Vai al Daily Log', 'Quali sintomi sono comuni?'],
      );
    }

    final names = today.symptoms.map(_symptomLabel).join(', ');
    return ChatResponse(
      text:
          'Oggi hai registrato: $names. Molti di questi sintomi sono legati alla fase ${_phaseLabel(phase)}.',
      suggestions: const [
        'Crampi → impacchi caldi e magnesio',
        'Mal di testa → idratazione e riposo',
        'Gonfiore → riduci sale e sale raffinato',
        'Affaticamento → ferro e sonno regolare',
      ],
      quickReplies: [
        'Come alleviare i crampi?',
        'I miei sintomi sono normali?',
      ],
    );
  }

  ChatResponse _bbtAnswer(List<DailyLog> logs, CyclePhase? phase) {
    final bbtLogs = logs.where((l) => l.bbt != null).toList();
    if (bbtLogs.isEmpty) {
      return const ChatResponse(
        text:
            'Non hai ancora registrato temperature basali. Misura la BBT ogni mattina appena sveglia, prima di alzarti, e registrala nel Daily Log.',
        quickReplies: ['Come si misura la BBT?', 'A cosa serve la BBT?'],
      );
    }
    final avg = bbtLogs.map((e) => e.bbt!).reduce((a, b) => a + b) /
        bbtLogs.length;
    return ChatResponse(
      text:
          'Hai registrato ${bbtLogs.length} misurazioni di BBT. Media: ${avg.toStringAsFixed(2)}°C. Dopo l\'ovulazione la temperatura sale di 0,2-0,5°C per effetto del progesterone.',
      suggestions: const [
        'Misura sempre alla stessa ora, appena sveglia',
        'Un rialzo sostenuto per 3+ giorni indica ovulazione avvenuta',
        'Registra anche eventuali risvegli notturni',
      ],
      quickReplies: [
        'Ho ovulato questo mese?',
        'La mia BBT è normale?',
      ],
    );
  }

  ChatResponse _moodAnswer(CyclePhase? phase, AppMode mode) {
    final phaseMsg = phase == CyclePhase.luteal
        ? 'Nella fase luteale il calo di estrogeni e l\'aumento di progesterone possono causare irritabilità, ansia e sbalzi d\'umore (PMS).'
        : phase == CyclePhase.menstrual
            ? 'Durante la mestruazione i bassi livelli ormonali possono accentuare stanchezza e tristezza.'
            : 'In questa fase gli estrogeni tendono a stabilizzare l\'umore e aumentare la sensazione di benessere.';

    return ChatResponse(
      text: phaseMsg,
      suggestions: const [
        'Pratica respirazione diaframmatica o meditazione 10 min/giorno',
        'Esposizione alla luce solare mattutina aiuta a regolare l\'umore',
        'Se i sintomi sono invalidanti, consulta uno specialista',
      ],
      quickReplies: [
        'Come distinguere PMS da depressione?',
        'Rimedi naturali per l\'ansia',
      ],
    );
  }

  ChatResponse _perimenopauseAnswer(AppMode mode) {
    if (mode != AppMode.perimenopause) {
      return const ChatResponse(
        text:
            'La perimenopausa è la fase di transizione che precede la menopausa, con cicli irregolari e sintomi come vampate, sudorazione notturna e sbalzi d\'umore. Se sospetti di essere in questa fase, attiva la modalità dedicata.',
        quickReplies: [
          'Attiva modalità Perimenopausa',
          'Quali sono i sintomi tipici?',
        ],
      );
    }
    return const ChatResponse(
      text:
          'In perimenopausa i cicli diventano irregolari per la fluttuazione degli estrogeni. Sintomi comuni: vampate, sudorazione notturna, insonnia, secchezza vaginale, sbalzi d\'umore.',
      suggestions: const [
        'Riduci alcol, caffeina e cibi piccanti per limitare le vampate',
        'Aggiungi fitoestrogeni (soia, lino) se tollerati',
        'Consulta il ginecologo per valutare terapie ormonali',
      ],
      quickReplies: [
        'Come gestire le vampate?',
        'Quando finisce la perimenopausa?',
      ],
    );
  }

  ChatResponse _genericAnswer(AppMode mode, CyclePhase? phase) {
    return ChatResponse(
      text:
          'Sono il tuo assistente Blood Whisperer. Posso aiutarti a capire la tua fase ormonale, i sintomi, la fertilità, la gravidanza e molto altro. Prova a chiedermi qualcosa di specifico.',
      quickReplies: const [
        'In che fase sono?',
        'Quando sarà la mia ovulazione?',
        'Ho sintomi normali?',
        'Come funziona la BBT?',
      ],
    );
  }

  String _phaseLabel(CyclePhase? phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return 'mestruale';
      case CyclePhase.follicular:
        return 'follicolare';
      case CyclePhase.ovulatory:
        return 'ovulatoria';
      case CyclePhase.luteal:
        return 'luteale';
      default:
        return 'attuale';
    }
  }

  String _symptomLabel(SymptomType s) {
    const labels = {
      SymptomType.cramps: 'crampi',
      SymptomType.headache: 'mal di testa',
      SymptomType.bloating: 'gonfiore',
      SymptomType.acne: 'acne',
      SymptomType.breastTenderness: 'sensibilità al seno',
      SymptomType.fatigue: 'affaticamento',
      SymptomType.backache: 'mal di schiena',
      SymptomType.nausea: 'nausea',
      SymptomType.cravings: 'voglie',
      SymptomType.insomnia: 'insonnia',
    };
    return labels[s] ?? s.name;
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
