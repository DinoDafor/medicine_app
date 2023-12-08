class Chat {
  final int chatId;
  final int otherUserId;
  final String otherUserName;
  final String otherUserImage;
  final Message lastMessage;

  Chat({
    required this.chatId,
    required this.otherUserId,
    required this.otherUserName,
    required this.otherUserImage,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chat_id'] ?? 0,
      otherUserId: json['other_user_id'] ?? 0,
      otherUserName: json['other_user_name'] ?? "",
      otherUserImage: json['other_user_image'] ?? "",
      lastMessage: Message.fromJson(json['last_message'] ?? {}),
    );
  }
}
class Message {
  final String content;
  final String timestamp;
  final bool isRead;
  final int id;
  final int chatId;
  final int senderId;
  final List<dynamic> attachments;

  Message({
    required this.content,
    required this.timestamp,
    required this.isRead,
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.attachments,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] ?? "",
      timestamp: json['timestamp'] ?? "",
      isRead: json['is_read'] ?? false,
      id: json['id'] ?? 0,
      chatId: json['chat_id'] ?? 0,
      senderId: json['sender_id'] ?? 0,
      attachments: json['attachments'] ?? [],
    );
  }
}