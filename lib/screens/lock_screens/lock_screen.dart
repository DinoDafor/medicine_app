import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:medicine_app/screen_lock_services/AuthenticationService.dart';
import 'package:medicine_app/screens/authentication_screen.dart';
import 'package:medicine_app/screens/lock_screens/Register.dart';
import 'package:medicine_app/screens/lock_screens/login.dart';
import 'package:medicine_app/screens/lock_screens/onboarding.dart';
import 'package:medicine_app/screens/lock_screens/passcodePage.dart';
import 'package:medicine_app/screens/lock_screens/setupPincode.dart';
import 'package:medicine_app/screens/registration_screen.dart';
import 'package:medicine_app/screens/users_chat_screen.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  bool _isNewUser = true;

  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  Future<void> getUserStatus() async {
    final val = await authService.read('pin');
    if (val.isNotEmpty) {
      setState(() {
        _isNewUser = false;
      });

      authService.isNewUserController.add(_isNewUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<String>(
          future: authService.read('pin'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return PasscodePage();
            }
            return RegistrationScreen();
          },
        ),
      ),
      routes: {
        'home': (builder) => ChatScreen(),
        'login': (context) => AuthenticationScreen(),
        'register': (context) => RegistrationScreen(),
        'onboarding': (context) => OnboardingPage(),
        'setPincodeScreen': (context) => SetupPincode()
      },
    );
  }
}
