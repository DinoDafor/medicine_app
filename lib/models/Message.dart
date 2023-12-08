// import 'dart:convert';
//
// Message messageFromJson(String str) => Message.fromJson(json.decode(str));
//
// String messageToJson(Message data) => json.encode(data.toJson());
//
// class Message {
//   String message;
//   String fromUser;
//   String dateCreate;
//
//   Message({
//     required this.message,
//     required this.fromUser,
//     required this.dateCreate,
//   });
//
//   factory Message.fromJson(Map<String, dynamic> json) => Message(
//     message: json["message"],
//     fromUser: json["fromUser"],
//     dateCreate: json["dateCreate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "fromUser": fromUser,
//     "dateCreate": dateCreate,
//   };
// }