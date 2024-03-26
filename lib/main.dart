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
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:medicine_app/screens/chat_screen.dart';
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:medicine_app/screens/users_chat_screen.dart';
import 'package:medicine_app/add_pill/service_locator.dart' as di;

import 'bloc/chat_bloc.dart';
import 'bloc/chats_bloc.dart';

void main() async {
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
        return const AuthenticationScreen();
      },
      routes: [
        GoRoute(
            path: 'registration',
            builder: (BuildContext context, GoRouterState state) {
              return const RegistrationScreen();
            }),
        GoRoute(
          path: 'addPill',
          builder: (context, state) => DragListScreen(),
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
                    return const ChatWithUser();
                  })
            ]),
      ]),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
