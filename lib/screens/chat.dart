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
    Message(
        message:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
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
      body: ScrollableChat(messages: messages, controller: _controller),
    );
  }
}

class ScrollableChat extends StatelessWidget {
  const ScrollableChat({
    super.key,
    required this.messages,
    required TextEditingController controller,
  }) : _controller = controller;

  final List<Message> messages;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: messages[index].fromUser == "me"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Flex(
                  direction: Axis.horizontal,
                  children:  [
                    Container(
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      child: Text(messages[index].message),
                      decoration: BoxDecoration(
                        color: messages[index].fromUser == "me"
                            ? const Color(0xFF0EBE7E)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                  ]
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 5,
              );
            },
          ),
        ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: "Введите сообщение"),
        )
      ],
    );
  }
}
