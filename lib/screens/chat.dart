import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/models/Message.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/chat_model.dart';
import '../token.dart';
import 'camera_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../models/ChatNotifier.dart';

class ChatWithUser extends StatefulWidget {
  final int chatId;

  const ChatWithUser({super.key, required this.chatId});

  @override
  State<ChatWithUser> createState() => _ChatWithUserState();
}

class _ChatWithUserState extends State<ChatWithUser> {
  //todo не сохраняется чат, надо сделать

  @override
  void initState() {
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
            context.go("/chats");
          },
        ),
        title: Text(
          widget.chatId.toString(),
          style: const TextStyle(
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
                      deleteChat();
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
                      sendChat();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: ScrollableChat(chatId: widget.chatId),
    );
  }

  void deleteChat() {
    print("Удаление чата...");
    // todo логика удаления чата
  }

  void sendChat() {
    print("Отправка чата...");
    // todo логика отправки чата
  }
}

class ScrollableChat extends StatefulWidget {
  final int chatId;

  const ScrollableChat({super.key, required this.chatId});

  @override
  State<ScrollableChat> createState() => _ScrollableChatState();
}

class _ScrollableChatState extends State<ScrollableChat> {
  final TextEditingController _controller = TextEditingController();
  late Future<int> fd;
  late int userOwner = 6;
  Dio dio = Dio();
  final List<Message> _messages = [];

  //todo сделать запрос на получение всех сообщений с доктором
//https://5lzxc7kx-8000.euw.devtunnels.ms/${chat_id}/ws/${client_id}
//   final _channel = WebSocketChannel.connect(
//     // Uri.parse('wss://echo.websocket.events/'),
//     Uri.parse('https://5lzxc7kx-8000.euw.devtunnels.ms/${widget.chatId}/ws/${widget.chatId}'),
//   );
  late final WebSocketChannel _channel;

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getMyID();
    _channel = WebSocketChannel.connect(
      // Uri.parse('wss://echo.websocket.events/'),
      Uri.parse(
          'wss://5lzxc7kx-8000.euw.devtunnels.ms/ws/${widget.chatId}'),
    );
  }

  Future<void> getMyID() async {
    //dynamic
    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var response = await dio.get(
        'https://5lzxc7kx-8000.euw.devtunnels.ms/users/me',
        options: options);
    if (response.statusCode == 200) {
      print("ID: $userOwner");

      userOwner = response.data["id"];
    }
    userOwner = -1;
    //todo пустой, сделать обработку
  }

  Future<List<Message>> getMessages() async {
    //dynamic
    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var response = await dio.get(
        'https://5lzxc7kx-8000.euw.devtunnels.ms/chats/${widget.chatId}',
        options: options);
    if (response.statusCode == 200) {
      List<dynamic> rawData = response.data;
      List<Map<String, dynamic>> messData =
          List<Map<String, dynamic>>.from(rawData);
      for (var message in messData) {
        print("Message: ${message["sender_id"]}");
        _messages.add(Message.fromJson(message));
      }
      return _messages;
      //
    }
    //todo пустой, сделать обработку
    return _messages;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: Future.wait([
              // getMyID(),
              getMessages(),
            ]),
            // future: getMessages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Ошибка: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Нет старых сообщений');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: _messages[index].senderId == userOwner
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _messages[index].senderId == userOwner
                                ? const Color(0xFF0EBE7E)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              _messages[index].content,
                              style: TextStyle(
                                color: _messages[index].senderId == userOwner
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFF212121),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
        Expanded(
          child: Consumer<ChatModel>(
            builder: (context, chatModel, child) {
              return StreamBuilder(
                  stream: _channel.stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      case ConnectionState.none:
                        {
                          return const Text('ConnectionState.done');
                        }
                      case ConnectionState.active:
                        {
                          if (snapshot.hasError) {
                            //todo добавить обработчики ошибок
                            print("Ошибка в потоке. Ошибка: ${snapshot.error}");
                          }
                          if (snapshot.hasData) {
                            print("Data from channel: ${snapshot.data}");
                            if (snapshot.data !=
                                'echo.websocket.events sponsored by Lob.com') {
                              _messages.add(
                                  Message.fromJson(jsonDecode(snapshot.data)));
                              // chatModel.add(
                              //     Message.fromJson(jsonDecode(snapshot.data)));
                              // _scrollToBottom(_messages);
                            }
                          }
                        }
                      case ConnectionState.done:
                        {
                          //todo делать реконнект?
                          return const Text('ConnectionState.done');
                        }
                    }

                    return ListView.separated(
                      // itemScrollController: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: _messages[index].senderId == userOwner
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _messages[index].senderId == userOwner
                                  ? const Color(0xFF0EBE7E)
                                  : const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                _messages[index].content,
                                style: TextStyle(
                                  color: _messages[index].senderId == userOwner
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFF212121),
                                ),
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
                    );
                  });
            },
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
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.emoji_emotions),
                    suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          onPressed: () {
                            print("pushed attachment");
                            onMediaButtonPressed();
                          },
                          icon: const Icon(Icons.attachment)),
                      IconButton(
                          onPressed: () {
                            print("pushed camera");
                            onCameraButtonPressed();
                          },
                          icon: const Icon(Icons.camera_alt)),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EBE7E),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {

                    print(Message(
                      content: _controller.text.trim(),
                      senderId: userOwner,
                      timestamp: DateTime.now().toString(),
                      isRead: false,
                      chatId: widget.chatId,
                      //todo пока null
                      attachments: [],
                      //todo я хз как айди давать
                      id: 0,
                    ).toJson());
                    // print(jsonEncode(Message(
                    //   content: _controller.text.trim(),
                    //   senderId: userOwner,
                    //   timestamp: DateTime.now().toString(),
                    //   isRead: false,
                    //   chatId: widget.chatId,
                    //   //todo пока null
                    //   attachments: [],
                    //   //todo я хз как айди давать
                    //   id: 0,
                    // ).toJson()));

                    _channel.sink.add(jsonEncode(Message(
                      content: _controller.text.trim(),
                      senderId: userOwner,
                      timestamp: DateTime.now().toString(),
                      isRead: false,
                      chatId: widget.chatId,
                      //todo пока null
                      attachments: [],
                      //todo я хз как айди давать
                      id: 0,
                    ).toJson()));
                    _controller.clear();
                  }
                  // setState(() {}
                  // );
                },
                child: SvgPicture.asset(
                  "assets/icons/send_arrow.svg",
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void onMediaButtonPressed() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickerResults = await _picker.pickMultiImage();

    if (pickerResults != null) {
      if (pickerResults.isNotEmpty) {
        for (XFile xfile in pickerResults) {
          String name = xfile.name;
          int size = await xfile.length();
          print(
              "MyHomePage.onMediaButtonPressed(): Picked file name=${name}, size=${size}, path=${xfile.path}");
          File file = File(xfile.path);
        }
      }
    }
  }

  void onCameraButtonPressed() async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen()));
  }

  void _sendMessage() {}

  void _scrollToBottom(List<Message> messages) {
    _scrollController.scrollTo(
      index: messages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _channel.sink.close(status.goingAway);
    super.dispose();
  }
}
