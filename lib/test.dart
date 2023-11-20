import 'dart:convert';

import 'package:medicine_app/models/Message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  print(DateTime.now());
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

