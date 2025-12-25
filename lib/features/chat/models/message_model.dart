class MessageModel {
  final String id;
  final String message;
  final String time;
  final bool isSentByMe;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.message,
    required this.time,
    required this.isSentByMe,
    this.isRead = false,
  });
}
