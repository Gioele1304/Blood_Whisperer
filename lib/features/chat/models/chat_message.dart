enum ChatRole { user, bot }

class ChatMessage {
  final String id;
  final ChatRole role;
  final String text;
  final List<String> suggestions;
  final List<String> quickReplies;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.role,
    required this.text,
    this.suggestions = const [],
    this.quickReplies = const [],
    required this.timestamp,
  });

  bool get isUser => role == ChatRole.user;
}
