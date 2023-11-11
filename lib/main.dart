import 'package:flutter/material.dart';
import 'package:medicine_app/models/Chat.dart';
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:medicine_app/screens/users_chat.dart';
import 'package:provider/provider.dart';

void main() {
  //todo скорее всего надо будет переместить в users_chat провайдер
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ChatModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color(0xFF0EBE7E),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AuthenticationScreen(),
      ),
    );
  }
}
