import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/models/Chat.dart';
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:medicine_app/screens/chat.dart';
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:medicine_app/screens/users_chat.dart';
import 'package:provider/provider.dart';

void main() {
  //todo скорее всего надо будет переместить в users_chat провайдер
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ChatModel(), child: const MyApp()));
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthenticationScreen();
      },
      routes: [
        GoRoute(
            path: 'registration',
            builder: (BuildContext context, GoRouterState state) {
              return const RegistrationScreen();
            }),
        GoRoute(
            path: 'chats',
            builder: (BuildContext context, GoRouterState state) {
              return const ChatScreen();
            },
            routes: [
              //todo тут надо вставить айдишник с кем мы говорим chat/userid=?
              GoRoute(
                  path: 'chat',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ChatWithUser();
                  })
            ]),
      ]),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color(0xFF0EBE7E),
            ),
      ),
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   body: AuthenticationScreen(),
      // ),
    );
  }
}
