import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/bloc/chat_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
import 'package:medicine_app/models/chat_model.dart';
import 'package:medicine_app/models/chat_model.dart';
import 'package:medicine_app/models/message_model.dart';
import 'package:medicine_app/utils/conversation.dart';
import 'package:medicine_app/utils/user.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../bloc/chat_bloc.dart';

class ChatScreenNew extends StatefulWidget {
  const ChatScreenNew({super.key});

  @override
  State<ChatScreenNew> createState() => _ChatScreenNewState();
}

class _ChatScreenNewState extends State<ChatScreenNew> {
  final ChatUser _currentUser = ChatUser(id: User.id.toString());
  List<ChatMessage> _messages = <ChatMessage>[];
  late ChatUser _recipentUser;
  @override
  void initState() {
    var chatState = BlocProvider.of<ChatBloc>(context).state;

    if (chatState is ChatLoadedSuccessfulState) {
      List<Message> messages = chatState.messages;

      for (var message in messages) {
        print("Init state ${message.senderId.toString()} sender");
        print("Init state ${_currentUser.id}");
        if (message.senderId.toString() == _currentUser.id) {
          ChatMessage m = ChatMessage(
              user: _currentUser,
              createdAt: DateTime.now(),
              text: message.text);
          _messages.insert(0, m);
        } else {
          _recipentUser = ChatUser(id: message.recipientId.toString());
          ChatMessage m = ChatMessage(
              user: _recipentUser,
              createdAt: DateTime.now(),
              text: message.text);
          _messages.insert(0, m);
        }
      }
    }

    // TODO: implement initState
    super.initState();
  }

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
            BlocProvider.of<ChatBloc>(context).add(ChatLeavingEvent());
            BlocProvider.of<NavigationBloc>(context)
                .add(NavigationToChatsScreenEvent(context: context));
          },
        ),
        title: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoadedSuccessfulState) {
              print("мапа при отрисовке: ");
              print(Conversation.idName);
              return Text(
                //todo hardcode
                Conversation.idName[state.interlocutorId].toString(),
                // widget.chatId.toString(),
                style: const TextStyle(
                    color: Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              );
            }
            return const Text(
              //todo hardcode
              "Ошибка в логике программы",
              // widget.chatId.toString(),
              style: TextStyle(
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            );
          },
        ),
        actions: [
          SvgPicture.asset(
            "assets/icons/Search.svg",
          ),
          const SizedBox(
            width: 10,
            height: 10,
          ),
          PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            icon: SvgPicture.asset(
              "assets/icons/More Circle.svg",
              width: 24,
              height: 24,
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/delete.svg",
                      width: 24,
                      height: 24,
                    ),
                    title: const Text(
                      "Удалить чат",
                      style: TextStyle(
                        color: Color(0xFFF75555),
                      ),
                    ),
                    onTap: () {
                      // deleteChat();
                      Navigator.pop(context);
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/download.svg",
                      width: 24,
                      height: 24,
                    ),
                    title: const Text("Отправить чат"),
                    onTap: () {
                      // sendChat();
                      //todo
                      Navigator.pop(context);
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: DashChat(
          currentUser: _currentUser,
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    var chatState = BlocProvider.of<ChatBloc>(context).state;

    if (chatState is ChatLoadedSuccessfulState) {
      print('My id ${User.id}');
      print('Friend id ${chatState.interlocutorId}');
      ChatUser _recipientUser =
          ChatUser(id: chatState.interlocutorId.toString());
      setState(() {
        _messages.insert(0, m);
      });

      print("зашли в отправку сообщения");
      Message sendMessage = Message(
          senderId: User.id,
          recipientId: chatState.interlocutorId,
          text: m.text,
          sendTimestamp: DateTime.now().millisecondsSinceEpoch,
          status: Status.CONFIRMATION,
          type: Type.MESSAGE_SENT);
      BlocProvider.of<ChatBloc>(context).add(ChatSendMessageEvent(
          message: sendMessage,
          chatId: chatState.chatId,
          messages: chatState.messages,
          interlocutorId: chatState.interlocutorId));

      print("отправили сообщение");
    }
  }
}
