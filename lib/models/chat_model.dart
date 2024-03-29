import 'message_model.dart';

class Chat {
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
}
