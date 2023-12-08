import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:medicine_app/models/Message.dart';
import 'package:medicine_app/models/chat_model.dart';
import 'package:medicine_app/token.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:dio/dio.dart';

void main() async {
  Dio dio = Dio();

  var formData = FormData.fromMap({
    "username": "nav@example.com",
    "password": "string",
    "grant_type": '',
    "scope": '',
    "client_id": '',
    "client_secret": '',
  });
  var response = await dio.post(
      'https://5lzxc7kx-8000.euw.devtunnels.ms/auth/login',
      data: formData);
  if (response.statusCode == 200) {
    // Token.token = response.data["access_token"];
    // Options options = Options(
    //     headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    // print(Token.token);
    // var response_chats = await dio
    //     .get('https://5lzxc7kx-8000.euw.devtunnels.ms/chats', options: options);
    //
    // List<dynamic> rawData = response_chats.data;
    // List<Map<String, dynamic>> chatData =
    //     List<Map<String, dynamic>>.from(rawData);
    // for (var chat in chatData) {
    //   Chat chat_f = Chat.fromJson(chat);
    //   print(chat_f.otherUserName);
    //   print(chat_f.lastMessage.content);
    //   var last = chat["last_message"];
    //   if (last != null) {
    //     // print(last["content"]);
    //   }
    // }
    int id = 4;
    Token.token = response.data["access_token"];
    Options options = Options(
             headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var response_chat_mes = await dio
         .get('https://5lzxc7kx-8000.euw.devtunnels.ms/chats/$id', options: options);
print(response_chat_mes.data);


    List<dynamic> rawData = response_chat_mes.data;
    List<Map<String, dynamic>> messData =
        List<Map<String, dynamic>>.from(rawData);
    for (var message in messData) {
      Message message_f = Message.fromJson(message);
      print(message_f.content);
      print(message_f.chatId);
    }
  }

  // print(response_chats);

  // final dio = Dio();
  // final response = await dio.get('http://localhost:3000/chats');
  // if (response.statusCode == 200) {
  //   List<dynamic> list = response.data;
  //   List<Chat> chats = [];
  //   for (int i = 0; i < list.length; i++) {
  //     Map<String, dynamic> map = list[i];
  //     chats.add(Chat.fromJson(map));
  //   }
  //   for (int i = 0; i < chats.length; i++) {
  //     print(chats[i].id);
  //     print(chats[i].interlocutor);
  //     print(chats[i].lastText);
  //     print(chats[i].lastDate);
  //   }
  // }

  // final WebSocketChannel _channel = WebSocketChannel.connect(
  //   Uri.parse('wss://echo.websocket.events'),
  // );
  // {
  //   //збс, берём на вооружение
  //   DateFormat formatter = DateFormat('d.L.yyyy, EE, H:m:s');
  //   String formattedDate = formatter.format(DateTime.now());
  //   print(formattedDate);
  // }

  // _channel.stream.listen((event) {
  //   if (event != 'echo.websocket.events sponsored by Lob.com') {
  //     print(event);
  //     Message mes = Message.fromJson(jsonDecode(event));
  //     print(mes.message);
  //   }
  //
  // });

  // Message mes =
  //     Message(message: "Privet", fromUser: "Misha", dateCreate: "12:00");
  // String jsonString = jsonEncode(mes);
  // _channel.sink.add(jsonString);
}
