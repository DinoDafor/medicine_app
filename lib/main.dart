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
import 'package:medicine_app/firebase_options.dart';
import 'package:medicine_app/giga/pages/gigachat_page.dart';

import 'package:medicine_app/onBoarding/generalScreen.dart';
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:medicine_app/screens/chat_screen.dart';
import 'package:medicine_app/screens/profile_edit_screen.dart';
import 'package:medicine_app/screens/profile_main_screen.dart';
import 'package:medicine_app/screens/profile_security_screen.dart';

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
import 'package:medicine_app/screens/search_screen.dart';
import 'package:medicine_app/screens/users_chat_screen.dart';
import 'package:medicine_app/add_pill/service_locator.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/chat_bloc.dart';
import 'bloc/chats_bloc.dart';
import 'bloc/profile_edit_bloc.dart';
import 'bloc/profile_main_bloc.dart';
import 'bloc/profile_security_bloc.dart';
import 'bloc/search_bloc.dart';

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
  print("Body of notification: ${message.notification?.body}");
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
      name: "irecipe", options: DefaultFirebaseOptions.currentPlatform);
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

  ///String? token = await _messaging.getToken();
  ///print("Firebase token: ${token}");

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
