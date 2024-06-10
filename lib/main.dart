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
import 'package:medicine_app/add_pill/pills/pages/PageForProvider.dart';

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

import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:medicine_app/screens/lock_screens/lock_screen.dart';
import 'package:medicine_app/screens/lock_screens/login.dart';
import 'package:medicine_app/screens/lock_screens/onboarding.dart';
import 'package:medicine_app/screens/lock_screens/passcodePage.dart';
import 'package:medicine_app/screens/lock_screens/setupPincode.dart';
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:medicine_app/screens/users_chat_screen.dart';
import 'package:medicine_app/add_pill/service_locator.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medicine_app/utils/firebase_options.dart';

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

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
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
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true);
  String? token = await _messaging.getToken();
  print("Firebase token: ${token}");

  //todo скорее всего надо будет переместить в users_chat провайдер
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return RegistrationScreen();
      },
      routes: [
        GoRoute(
            path: 'authentication',
            builder: (BuildContext context, GoRouterState state) {
              return AuthenticationScreen();
            }),
        GoRoute(
            path: 'registration',
            builder: (BuildContext context, GoRouterState state) {
              return const RegistrationScreen();
            }),
        GoRoute(
            path: "setPincode",
            builder: (context, state) {
              return SetupPincode(creds: state.extra as Map<String, String>);
            }),
        GoRoute(
          path: 'onboarding',
          builder: (context, state) => OnboardingPage(
            args: state.extra as ScreenArgs,
          ),
        ),

        GoRoute(
            name: 'passcodePage',
            path: 'passcodePage',
            builder: (context, state) => PasscodePage()),
        GoRoute(
          path: 'chatGPT',
          builder: (context, state) => const GigaChatPage(),
        ),
        // GoRoute(
        //   path: 'lockscreen',
        //   builder: (context, state) => LockScreen(),
        // ),
        GoRoute(
            path: 'pillReminder',
            builder: ((context, state) => DragListScreen())),
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
