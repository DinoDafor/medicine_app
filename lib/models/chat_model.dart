
class Chat {
  final int id;
  final String interlocutor;
  final String lastText;
  final String lastDate;

  Chat({
    required this.id,
    required this.interlocutor,
    required this.lastText,
    required this.lastDate,
  });

  factory Chat.fromSqfliteDatabase(Map<String, dynamic> map) => Chat(
        id: map['id']?.toInt() ?? 0,
        interlocutor: map['interlocutor'] ?? '',
        lastText: map['lastText'] ?? '',
        lastDate: map['lastDate'] ?? '',
      );


  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    interlocutor: json["interlocutor"],
    lastText: json["lastText"],
    lastDate: json["lastDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "interlocutor": interlocutor,
    "lastText": lastText,
    "lastDate": lastDate,
  };
}
