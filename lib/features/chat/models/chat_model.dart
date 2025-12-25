class ChatModel {
  final String id;
  final String userName;
  final String userImage;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  ChatModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}
