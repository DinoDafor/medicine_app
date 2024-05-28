import 'package:flutter/material.dart';
import 'package:medicine_app/screen_lock_services/AuthenticationService.dart';
import 'package:medicine_app/screens/lock_screens/passcodePage.dart';
import 'package:medicine_app/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isNewUser = true;
  final authService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    getUserStatus();
  }

  Future<void> getUserStatus() async {
    // we need to set value
    final val = await authService.read('pin');
    if (val.isNotEmpty) {
      setState(() {
        isNewUser = false;
      });
    }
    this.authService.isNewUserController.add(isNewUser);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: isNewUser ? RegistrationScreen() : PasscodePage(),
      routes: {
        // 'home': (builder) => MyHomePage(),
        // 'login': (context) => LoginPage(),
        // 'register': (context) => RegisterPage(),
        // 'onboarding': (context) => OnboardingPage(),
        // 'setPincodeScreen': (context) => SetupPincode()
      },
    );
  }
}
