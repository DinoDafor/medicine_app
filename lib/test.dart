import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:medicine_app/models/Message.dart';
import 'package:medicine_app/models/chat_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:dio/dio.dart';

void main() async {

  final dio = Dio();
  final response = await dio.get('http://localhost:3000/chats');
  if (response.statusCode == 200) {
    List<dynamic> list = response.data;
    List<Chat> chats = [];
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> map = list[i];
      chats.add(Chat.fromJson(map));
    }
    for (int i = 0; i < chats.length; i++) {
      print(chats[i].id);
      print(chats[i].interlocutor);
      print(chats[i].lastText);
      print(chats[i].lastDate);
    }
  }

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
