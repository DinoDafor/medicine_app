class Message {
  final int chatId;
  final String content;
  //todo long?
  final String timestamp;
  final bool isRead;
  //inc from back
  final int id;
//client side
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
      isRead: json['isRead'] ?? false,
      id: json['id'] ?? 0,
      chatId: json['chatId'] ?? 0,
      senderId: json['senderId'] ?? 0,
      attachments: json['attachments'] ?? [],
    );


  }
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'timestamp': timestamp,
      'is_read': isRead,
      'chatId': chatId,
      'attachments': attachments,
      'id': id,
    };
  }
}