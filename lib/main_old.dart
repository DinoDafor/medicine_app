import 'package:flutter/material.dart';
import 'package:medicine_app/screens/users_chat.dart';

void main() {
  runApp(const MyApp());
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
        body: ChatScreen(),
      ),
    );
  }
}
