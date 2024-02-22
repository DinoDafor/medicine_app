import 'message_model.dart';

class Chat {
  final int chatId;

  //todo нейминг
  final int otherUserId;

  final String chatName;

  //todo отдельные http запросы для картинок
  final Message lastMessage;

  Chat({
    required this.chatId,
    required this.otherUserId,
    required this.chatName,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'] ?? 0,
      otherUserId: json['otherUserId'] ?? 0,
      chatName: json['chatName'] ?? "",
      lastMessage: Message.fromJson(json['lastMessage'] ?? {}),
    );
  }
}
