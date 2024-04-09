import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/bloc/chat_bloc.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
import 'package:medicine_app/gpt/consts.dart';
import 'package:medicine_app/utils/conversation.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatUser _chatUser =
      ChatUser(id: '1', firstName: "Mikhael", lastName: "Kreslavskii");

  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: "Chat", lastName: "GPT");

  final _openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 7)),
      enableLog: true);

  List<ChatMessage> _messages = <ChatMessage>[];
  List<Map<String, dynamic>> _messagesHistory = [];
  ChatUser _systemUser = ChatUser(id: '3');

  List<ChatUser> _typingUser = <ChatUser>[];
  @override
  void initState() {
    _messagesHistory.add({'role': 'system', 'content': SYSTEM_PROMPT});
    ChatMessage initialPrompt = ChatMessage(
        user: _systemUser, createdAt: DateTime.now(), text: SYSTEM_PROMPT);

    getChatResponse(initialPrompt);

    ///_messages.add(ChatMessage(user: user, createdAt: createdAt))
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
          messageOptions: MessageOptions(
            currentUserContainerColor: Color.fromARGB(255, 14, 190, 126),
            textColor: Colors.white,
            borderRadius: 20,
          ),
          currentUser: _chatUser,
          typingUsers: _typingUser,
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      if (m.user != _systemUser) {
        _messages.insert(0, m);
      }

      _typingUser.add(_gptChatUser);
    });

    _messagesHistory.addAll(_messages.reversed.map((m) {
      if (m.user == _chatUser) {
        return {
          'role': "user",
          'content': m.text,
        };
      }
      if (m.user == _gptChatUser) {
        return {
          'role': "assistant",
          'content': m.text,
        };
      }
      return {'role': 'system', 'content': m.text};
    }).toList());

    final request = ChatCompleteText(
        model: Gpt4ChatModel(), messages: _messagesHistory, maxToken: 200);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        _messages.insert(
            0,
            ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: element.message!.content));
      }
    }
    setState(() {
      _typingUser.remove(_gptChatUser);
    });
  }
}
