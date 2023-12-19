import 'package:flutter/material.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/MessageScreen.dart';

void main() {
  runApp(MyChatApp());
}

class MyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OnehundredsevenScreen(),
    );
  }
}
