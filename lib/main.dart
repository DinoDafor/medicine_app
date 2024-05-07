import 'dart:io';

import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:medicine_app/add_pill/mypage.dart';
import 'package:medicine_app/add_pill/pills/data/bloc/pill_bloc.dart';
import 'package:medicine_app/add_pill/pills/data/model/enums/form_enum.dart';
import 'package:medicine_app/add_pill/pills/data/model/enums/status_enum.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';

///import 'package:medicine_app/add_pill/pills/data/bloc/pill_bloc.dart';
import 'package:medicine_app/add_pill/pills/pages/drag_list_screen.dart';
import 'package:medicine_app/add_pill/pills/widget/drag_list.dart';
import 'package:medicine_app/add_pill/service_locator.dart';
import 'package:medicine_app/bloc/authentication_bloc.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
import 'package:medicine_app/giga/pages/gigachat_page.dart';

import 'package:medicine_app/onBoarding/generalScreen.dart';
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:medicine_app/screens/chat_screen.dart';
import 'package:medicine_app/screens/chat_screen_new.dart';
import 'package:medicine_app/screens/lock_screens/lock_screen.dart';
import 'package:medicine_app/screens/lock_screens/onboarding.dart';
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:medicine_app/screens/users_chat_screen.dart';
import 'package:medicine_app/add_pill/service_locator.dart' as di;

import 'bloc/chat_bloc.dart';
import 'bloc/chats_bloc.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpoverrides();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(PillEntityAdapter());
  Hive.registerAdapter(StatusEnumAdapter());
  Hive.registerAdapter(FormEnumAdapter());
  await Hive.openBox<PillEntity>('pillbox');
  await Hive.openBox('mybox');
  //todo скорее всего надо будет переместить в users_chat провайдер
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LockScreen();
      },
      routes: [
        GoRoute(
            path: 'authentication',
            builder: (BuildContext context, GoRouterState state) {
              return const LockScreen();
            }),
        GoRoute(
            path: 'registration',
            builder: (BuildContext context, GoRouterState state) {
              return const LockScreen();
            }),
        // GoRoute(
        //   path: 'onboarding',
        //   builder: (context, state) => OnboardingPage(),
        // ),
        GoRoute(
          path: 'chatGPT',
          builder: (context, state) => const GigaChatPage(),
        ),
        GoRoute(
          path: 'lockscreen',
          builder: (context, state) => LockScreen(),
        ),
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
                    // int chatId = int.parse(state.extra.toString());
                    return const ChatScreenNew();
                  })
            ]),
      ]),
]);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => ChatsBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<PillBloc>(
          create: (context) => sl<PillBloc>(),
          child: DragListScreen(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color(0xFF0EBE7E),
              ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
