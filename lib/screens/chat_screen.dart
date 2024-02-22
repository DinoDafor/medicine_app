import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/models/message_model.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../bloc/chat_bloc.dart';

class ChatWithUser extends StatefulWidget {


  const ChatWithUser({super.key});

  @override
  State<ChatWithUser> createState() => _ChatWithUserState();
}

class _ChatWithUserState extends State<ChatWithUser> {
  //todo не сохраняется чат, надо сделать

  @override
  void initState() {

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
        title: const Text(
          //todo сделать динамически
          "Доктор Ливси",
          // widget.chatId.toString(),
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
                      Navigator.pop(context);
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: ScrollableChat(),
    );
  }
}

class ScrollableChat extends StatefulWidget {


  const ScrollableChat({super.key});

  @override
  State<ScrollableChat> createState() => _ScrollableChatState();
}

class _ScrollableChatState extends State<ScrollableChat> {
  final TextEditingController _textController = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();
  //todo пока так
  int userOwner = 0;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<ChatBloc>(context).add(ChatLoadingEvent(2));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              // var chatBlocState = chatBloc.state;
              if(state is ChatLoadedSuccessfulState){
               List<Message> _messages =  state.messages;
                print(_messages[0].content);
                print(_messages.length);
                // return Text("data");
                return ScrollablePositionedList.separated(
                  itemScrollController: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment:
                      _messages[index].senderId == userOwner
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                          _messages[index].senderId == userOwner
                              ? const Color(0xFF0EBE7E)
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery
                              .of(context)
                              .size
                              .width *
                              0.7,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            _messages[index].content,
                            style: TextStyle(
                              color: _messages[index].senderId ==
                                  userOwner
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFF212121),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder:
                      (BuildContext context, int index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                );

              }
              else {
                return const Text("AAA");
              }
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
                  controller: _textController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.emoji_emotions),
                    suffixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          onPressed: () {
                            print("pushed attachment");
                            // onMediaButtonPressed();
                          },
                          icon: const Icon(Icons.attachment)),
                      IconButton(
                          onPressed: () {
                            print("pushed camera");
                            // onCameraButtonPressed();
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
                  // if (_textController.text.isNotEmpty) {
                  // }
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

  // void onMediaButtonPressed() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final List<XFile>? pickerResults = await _picker.pickMultiImage();
  //
  //   if (pickerResults != null) {
  //     if (pickerResults.isNotEmpty) {
  //       for (XFile xfile in pickerResults) {
  //         String name = xfile.name;
  //         int size = await xfile.length();
  //         print(
  //             "MyHomePage.onMediaButtonPressed(): Picked file name=${name}, size=${size}, path=${xfile.path}");
  //         File file = File(xfile.path);
  //       }
  //     }
  //   }
  // }

  // void onCameraButtonPressed() async {
  //   Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen()));
  // }

  // void _scrollToBottom(List<Message> messages) {
  //   _scrollController.scrollTo(
  //     index: messages.length - 1,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  @override
  void dispose() {
    // _channel.sink.close(status.goingAway);
    _textController.dispose();
    super.dispose();
  }
}
