import 'package:flutter/material.dart';

import 'Message.dart';

class ChatModel extends ChangeNotifier {
  //todo добавить геттер

  List<Message> _messages = [
    Message(
        message:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        fromUser: "danya",
        dateCreate: "12:00"),
    Message(
        message: "This is a short message!",
        fromUser: "me",
        dateCreate: "12:00"),
    Message(
        message: "This is a relatively longer line of text.",
        fromUser: "danya",
        dateCreate: "12:01"),
    Message(message: "Hi!", fromUser: "me", dateCreate: "12:02"),
    Message(message: "Рад слышать", fromUser: "danya", dateCreate: "12:03"),
  ];



  List<Message> get messages => _messages;

  void add(Message message) {
    _messages.add(message);
    // todo закоммнентировал, ругается на использование внутри builder метода от StreamBuilder, а как использовать от Notifier ???
    // notifyListeners();
  }
}
