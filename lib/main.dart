import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/bloc/authentication_bloc.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:medicine_app/screens/chat_screen.dart';
import 'package:medicine_app/screens/profile_edit_screen.dart';
import 'package:medicine_app/screens/profile_main_screen.dart';
import 'package:medicine_app/screens/profile_security_screen.dart';
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:medicine_app/screens/search_screen.dart';
import 'package:medicine_app/screens/users_chat_screen.dart';

import 'bloc/chat_bloc.dart';
import 'bloc/chats_bloc.dart';
import 'bloc/profile_edit_bloc.dart';
import 'bloc/profile_main_bloc.dart';
import 'bloc/profile_security_bloc.dart';
import 'bloc/search_bloc.dart';

void main() {
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
            path: 'chats',
            builder: (BuildContext context, GoRouterState state) {
              return const ChatScreen();
            },
            routes: [
              GoRoute(
                  path: 'chat',
                  builder: (BuildContext context, GoRouterState state) {
                    return const ChatWithUser();
                  }),
              GoRoute(
                  path: 'search',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SearchScreen();
                  }),
              GoRoute(
                  path: 'profile',
                  builder: (BuildContext context, GoRouterState state) {
                    return ProfileScreen();
                  },
                  routes: [
                    GoRoute(
                        path: 'edit',
                        builder: (BuildContext context, GoRouterState state) {
                          return ProfileEditScreen();
                        }),
                    GoRoute(
                        path: 'security',
                        builder: (BuildContext context, GoRouterState state) {
                          return const ProfileSecurityScreen();
                        }),
                  ]),
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
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileEditBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileMainBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileSecurityBloc(),
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
