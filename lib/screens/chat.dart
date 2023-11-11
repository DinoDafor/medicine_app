import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/models/Message.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/Chat.dart';

class ChatWithUser extends StatefulWidget {
  const ChatWithUser({super.key});

  @override
  State<ChatWithUser> createState() => _ChatWithUserState();
}

class _ChatWithUserState extends State<ChatWithUser> {
  TextEditingController _controller = TextEditingController();

  //todo не сохраняется чат, надо сделать

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back_arrow_icon.svg",
            fit: BoxFit.scaleDown,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Doctor name",
          style: TextStyle(
              color: Color(0xFF212121),
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        actions: [
          SvgPicture.asset(
            "assets/icons/Search.svg",
          ),
          const SizedBox(
            width: 10,
            height: 10,
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/More Circle.svg",
            ),
            onPressed: () {
              print("tap tap");
            },
          ),
        ],
      ),
      body: ScrollableChat(
        controller: _controller,
      ),
    );
  }
}

class ScrollableChat extends StatefulWidget {
  const ScrollableChat({super.key, required TextEditingController controller})
      : _controller = controller;

  final TextEditingController _controller;

  @override
  State<ScrollableChat> createState() => _ScrollableChatState();
}

class _ScrollableChatState extends State<ScrollableChat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          //todo добавить скролл вниз, когда приходит новое сообщение
          child: Consumer<ChatModel>(
            builder: (context, chatModel, child) => ListView.separated(
              itemCount: chatModel.messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: chatModel.messages[index].fromUser == "me"
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: chatModel.messages[index].fromUser == "me"
                          ? const Color(0xFF0EBE7E)
                          : Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      chatModel.messages[index].message,
                      style: TextStyle(
                        color: chatModel.messages[index].fromUser == "me"
                            ? const Color(0xFFFFFFFF)
                            : Color(0xFF212121),
                      ),
                    ),
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  controller: widget._controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.emoji_emotions),
                    suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          onPressed: () {
                            print("pushed attachment");
                          },
                          icon: Icon(Icons.attachment)),
                      IconButton(
                          onPressed: () {
                            print("pushed camera");
                          },
                          icon: Icon(Icons.camera_alt)),
                    ]),
                    hintText: "Введите сообщение...",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF0EBE7E),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                ),
              ),
              Consumer<ChatModel>(
                builder: (context, chatModel, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0EBE7E),
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      if (widget._controller.text.isNotEmpty) {
                        chatModel.add(Message(
                            message: widget._controller.text.trim(),
                            fromUser: "me",
                            dateCreate: "12:00"));
                        widget._controller.clear();
                      }
                      setState(() {});
                    },
                    child: SvgPicture.asset(
                      "assets/icons/send_arrow.svg",
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage() {}
}
