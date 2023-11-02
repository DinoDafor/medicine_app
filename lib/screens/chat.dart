import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/models/Message.dart';

class ChatWithUser extends StatefulWidget {
  const ChatWithUser({super.key});

  @override
  State<ChatWithUser> createState() => _ChatWithUserState();
}

class _ChatWithUserState extends State<ChatWithUser> {
  TextEditingController _controller = TextEditingController();
  List<Message> messages = [
    Message(message: "hello", fromUser: "danya", dateCreate: "12:00"),
    Message(message: "hello!", fromUser: "me", dateCreate: "12:00"),
    Message(message: "Как ты?", fromUser: "danya", dateCreate: "12:01"),
    Message(message: "я хорошо)", fromUser: "me", dateCreate: "12:02"),
    Message(message: "Рад слышать", fromUser: "danya", dateCreate: "12:03"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SvgPicture.asset(
          "assets/icons/back_arrow_icon.svg",
        ),
        title: Row(
          children: [
            Text(
              "Doctor name",
              style: TextStyle(
                color: Color(0xFF212121),
                fontWeight: FontWeight.bold,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/Search.svg",
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              "assets/icons/More Circle.svg",
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        alignment: messages[index].fromUser == "me"
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        padding: EdgeInsets.all(10),
                        child: Text(messages[index].message),
                        decoration: BoxDecoration(
                          color: messages[index].fromUser == "me"
                              ? const Color(0xFF0EBE7E)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                  // return Container(
                  //  color: Colors.red,
                  // );
                }),
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Введите сообщение"),
          )
        ],
      ),
    );
  }
}
