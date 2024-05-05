class Message {
  int senderId;
  int recipientId;
  int conversationId;
  String text;
  int sendTimestamp;
  Status status;
  Type type;

  Message({
    required this.senderId,
    required this.recipientId,
    required this.conversationId,
    required this.text,
    required this.sendTimestamp,
    required this.status,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        senderId: json["senderId"],
        recipientId: json["recipientId"],
        conversationId: json["conversationId"],
        text: json["text"],
        sendTimestamp: json["sendTimestamp"],
        status: Status.values.byName(json["status"]),
        type: Type.values.byName(json["type"]));
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recipientId': recipientId,
      'text': text,
      'sendTimestamp': sendTimestamp,
      'status': status.name,
      'type': type.name,
    };
  }
}

enum Status { CONFIRMATION, UNREAD, READ }

enum Type { MESSAGE, MESSAGE_SENT }
