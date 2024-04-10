import 'message_model.dart';

class Chat implements Comparable<Chat> {
  int id;
  int firstParticipantId;
  int secondParticipantId;
  List<Message> messages;

  Chat({
    required this.id,
    required this.firstParticipantId,
    required this.secondParticipantId,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    var list = json['messages'] as List;
    List<Message> messages = list.map((i) => Message.fromJson(i)).toList();
    return Chat(
      id: json["id"],
      firstParticipantId: json["firstParticipantId"],
      secondParticipantId: json["secondParticipantId"],
      messages: messages,
    );
  }

  @override
  int compareTo(Chat other) {
    // Сравниваем последние сообщения в чатах
    int thisTimestamp = this.messages.isNotEmpty
        ? this.messages.last.sendTimestamp
        : 0; // Значение по умолчанию, если нет сообщений
    int otherTimestamp = other.messages.isNotEmpty
        ? other.messages.last.sendTimestamp
        : 0; // Значение по умолчанию, если нет сообщений
    return otherTimestamp.compareTo(thisTimestamp);
  }

  int getLatestSendTime() {
    int latestSendTime = 0;
    for (Message message in messages) {
      if (message.sendTimestamp > latestSendTime) {
        latestSendTime = message.sendTimestamp;
      }
    }
    return latestSendTime;
  }

  void sortMessagesBySendTime() {
    messages.sort((message1, message2) {
      return message1.sendTimestamp.compareTo(message2.sendTimestamp);
    });
  }
}
