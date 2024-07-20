class Message {
  final String text;
  final DateTime createdAt;
  final bool isUser;

  Message({
    required this.text,
    required this.createdAt,
    required this.isUser,
  });
}
