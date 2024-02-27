import 'dart:io';

import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/message_model.dart';

class ChatService {
  final Dio _dio = Dio();
  final String _URL = 'http://192.168.0.10:3000/messages';
  late WebSocketChannel _channel;
  final List<Message> _messages = [];

  Future<List<Message>> getMessages(int chatId) async {
    //,
    //         options: options
    // Options options = Options(
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var response =
    await _dio.get(_URL, queryParameters: {"chatId": chatId});
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> chatData =
          List<Map<String, dynamic>>.from(response.data);
      _messages.addAll(chatData.map((message) => Message.fromJson(message)));
      return _messages;
      //
    }
    //todo пустой, сделать обработку
    return _messages;
  }

  // todo saveMessages(){
  //
  // }

  deleteMessagesFromLocalList(){
    _messages.clear();
  }

  fddf(int chatId) {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://5lzxc7kx-8000.euw.devtunnels.ms/ws/$chatId'),

//todo это добавить последнее сообщение в список, когда приходит от собеседника
//          if (snapshot.hasData) {
//        print("Data from channel: ${snapshot.data}");
//        if (snapshot.data !=
//            'echo.websocket.events sponsored by Lob.com') {
//          _messages.add(Message.fromJson(
//              jsonDecode(snapshot.data)));
//          // chatModel.add(
//          //     Message.fromJson(jsonDecode(snapshot.data)));
//          // _scrollToBottom(_messages);
//        }

      //todo это когда мы нажимаем отправить сообщение с нашей стороны
      //     if (_textController.text.isNotEmpty) {
      //   // print(Message(
      //   //   content: _textController.text.trim(),
      //   //   senderId: userOwner,
      //   //   timestamp: DateTime.now().toString(),
      //   //   isRead: false,
      //   //   chatId: widget.chatId,
      //   //   //todo пока null
      //   //   attachments: [],
      //   //   //todo я хз как айди давать
      //   //   id: 0,
      //   // ).toJson());
      //
      //   _channel.sink.add(jsonEncode(Message(
      //     content: _textController.text.trim(),
      //     senderId: userOwner,
      //     timestamp: DateTime.now().toString(),
      //     isRead: false,
      //     chatId: widget.chatId,
      //     //todo пока null
      //     attachments: [],
      //     //todo я хз как айди давать
      //     id: 0,
      //   ).toJson()));
      //   _textController.clear();
      // }
    );
  }

// Future<void> getMyID() async {
//   //dynamic
//   Options options = Options(
//       headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
//   var response = await _dio.get(
//       'https://5lzxc7kx-8000.euw.devtunnels.ms/users/me',
//       options: options);
//   if (response.statusCode == 200) {
//     print("ID: $userOwner");
//
//     userOwner = response.data["id"];
//   }
//   userOwner = -1;
//   //todo пустой, сделать обработку
// }

// _channel.sink.add(jsonEncode(Message(
// content: _textController.text.trim(),
// senderId: userOwner,
// timestamp: DateTime.now().toString(),
// isRead: false,
// chatId: widget.chatId,
// //todo пока null
// attachments: [],
// //todo я хз как айди давать
// id: 0,
// ).toJson()));
}
