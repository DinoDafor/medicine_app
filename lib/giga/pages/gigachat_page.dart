import 'dart:convert';
import 'dart:io';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_app/bloc/chat_bloc.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
import 'package:medicine_app/giga/consts.dart';
import 'package:medicine_app/utils/conversation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GigaChatPage extends StatefulWidget {
  const GigaChatPage({super.key});

  @override
  State<GigaChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<GigaChatPage> {
  final ChatUser _chatUser =
      ChatUser(id: '1', firstName: "Mikhael", lastName: "Kreslavskii");

  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: "ИИ -", lastName: "Помощник");

  List<ChatMessage> _messages = <ChatMessage>[];
  List<Map<String, dynamic>> _messagesHistory = [];
  ChatUser _systemUser = ChatUser(id: '3');

  List<ChatUser> _typingUser = <ChatUser>[];
  @override
  void initState() {
    String? PROMPT = dotenv.env["PROMPT"];

    _messagesHistory.add({'role': 'system', 'content': PROMPT});
    ChatMessage initialPrompt = ChatMessage(
        user: _systemUser, createdAt: DateTime.now(), text: PROMPT!);

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
          inputOptions: InputOptions(alwaysShowSend: true),
          messageOptions: MessageOptions(
            currentUserContainerColor: Color.fromARGB(255, 14, 190, 126),
            textColor: Colors.black,
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

    final url = "https://gigachat.devices.sberbank.ru/api/v1/chat/completions";
    final credentials =
        "${dotenv.env["CLIENT_ID"]}:${dotenv.env["SBER_SECRET"]}";
    final encoded_credentials_tmp = base64.encode(utf8.encode(credentials));
    final encoded_credentials = utf8.decode(encoded_credentials_tmp.codeUnits);
    final API_TOKEN = await get_token(dotenv.env["SBER_AUTH"]!);
    print("TOKEN: ${API_TOKEN}");
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${API_TOKEN}'
    };
    final body = {
      "model": "GigaChat",
      "messages": _messagesHistory,
      "temperature": 1,
      "top_p": 0.1,
      "n": 1,
      "stream": false,
      "max_tokens": 512,
      "repetition_penalty": 1,
      "update_interval": 0
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 401) {
      print(get_token(dotenv.env["SBER_AUTH"]!));
    }
    if (response.statusCode == 200) {
      print("Success");
      String content =
          jsonDecode(response.body)['choices'][0]['message']['content'];
      print('${content}');
      if (content != null) {
        _messages.insert(
            0,
            ChatMessage(
                user: _gptChatUser, createdAt: DateTime.now(), text: content));
      }
    }

    setState(() {
      _typingUser.remove(_gptChatUser);
    });
  }

  Future<String?> get_token(String auth,
      {String scope = "GIGACHAT_API_PERS"}) async {
    final rq_uid = (Uuid().v4()).toString();
    final url = "https://ngw.devices.sberbank.ru:9443/api/v2/oauth";
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'RqUID': '${rq_uid}',
      'Authorization': 'Basic ${auth}'
    };

    final payload = {'scope': 'GIGACHAT_API_PERS'};

    try {
      final auth_response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: payload,
      );
      print(auth_response.body);
      return jsonDecode(auth_response.body)['access_token'];
    } on Exception catch (_) {
      print("Ошибка: {str(e)}");
      return null;
    }
  }
}
