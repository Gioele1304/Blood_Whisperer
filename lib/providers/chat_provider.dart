import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/chat/models/chat_message.dart';
import '../models/cycle.dart';
import '../models/daily_log.dart';
import '../services/chat_service.dart';
import '../services/cycle_calculation_service.dart';
import 'app_mode_provider.dart';
import 'daily_log_provider.dart';
import 'pregnancy_provider.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;

  const ChatState({
    this.messages = const [],
    this.isTyping = false,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final Ref _ref;
  final ChatService _service = ChatService();
  final CycleCalculationService _cycleCalc = CycleCalculationService();

  ChatNotifier(this._ref) : super(const ChatState()) {
    _initGreeting();
  }

  void _initGreeting() {
    final mode = _ref.read(appModeProvider);
    final phase = _computeCurrentPhase();
    final response = _service.respond(
      userMessage: 'ciao',
      mode: mode,
      currentPhase: phase,
    );
    state = state.copyWith(
      messages: [
        ChatMessage(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          role: ChatRole.bot,
          text:
              'Ciao! Sono il tuo assistente Blood Whisperer. ${response.text}',
          quickReplies: response.quickReplies,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  CyclePhase? _computeCurrentPhase() {
    final logsAsync = _ref.read(dailyLogsProvider);
    final List<DailyLog> logs = logsAsync.maybeWhen(
      data: (d) => d,
      orElse: () => <DailyLog>[],
    );
    if (logs.isEmpty) return null;

    final sorted = [...logs]..sort((a, b) => a.date.compareTo(b.date));
    final firstDay = sorted.first.date;
    final stats = _cycleCalc.computeStatistics([]);
    return _cycleCalc.currentPhase(
      today: DateTime.now(),
      cycleStart: firstDay,
      cycleLength: stats.averageCycleLength.round(),
    );
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      role: ChatRole.user,
      text: text.trim(),
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMsg],
      isTyping: true,
    );

    // Simula latenza naturale
    await Future.delayed(const Duration(milliseconds: 400));

    final mode = _ref.read(appModeProvider);
    final phase = _computeCurrentPhase();
    final logsAsync = _ref.read(dailyLogsProvider);
    final List<DailyLog> logs = logsAsync.maybeWhen(
      data: (d) => d,
      orElse: () => <DailyLog>[],
    );
    final today = DateTime.now();
    final todayLog = logs.firstWhere(
      (l) =>
          l.date.year == today.year &&
          l.date.month == today.month &&
          l.date.day == today.day,
      orElse: () => logs.isNotEmpty ? logs.first : _emptyLog(),
    );
    final pregnancyInfo = _ref.read(pregnancyInfoProvider);

    final response = _service.respond(
      userMessage: text,
      mode: mode,
      currentPhase: phase,
      pregnancyInfo: pregnancyInfo,
      todayLog: logs.isEmpty ? null : todayLog,
      recentLogs: logs,
    );

    final botMsg = ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      role: ChatRole.bot,
      text: response.text,
      suggestions: response.suggestions,
      quickReplies: response.quickReplies,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, botMsg],
      isTyping: false,
    );
  }

  void clear() {
    state = const ChatState();
    _initGreeting();
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>(
  (ref) => ChatNotifier(ref),
);

DailyLog _emptyLog() => DailyLog(
      date: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
