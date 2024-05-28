import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medicine_app/bloc/authentication_bloc.dart';
import 'package:medicine_app/screen_lock_services/AuthenticationService.dart';
import 'package:medicine_app/screens/lock_screens/login.dart';
import 'package:medicine_app/screens/lock_screens/widgets/graddientWrapper.dart';
import 'package:medicine_app/screens/lock_screens/widgets/passcodeWidget.dart';
import 'package:medicine_app/screens/users_chat_screen.dart';

class PasscodePage extends StatefulWidget {
  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {
  Stream<bool>? _isVerification;
  Future<bool>? hasBio;
  int attempts = 0;

  @override
  void initState() {
    authService.isEnabledStream;
    this._isVerification = authService.isEnabledStream;
    super.initState();
  }

  void _onCallback(String enteredCode) {
    authService.getCredsByCode(enteredCode);
    this._isVerification!.listen((isValid) {
      if (isValid) {
      } else {
        setState(() => attempts += 1);
        if (attempts == 5) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
    });
  }

  void _onCancel() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> authenticate() async {
    final isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Do something',
        options: AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ));
    authService.isEnabledController.add(isAuthenticated);
    if (isAuthenticated) {
      final creds = await authService.getCredsByBio();
      BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationSighInEvent(creds!["email"]!, creds["password"]!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: localAuth.canCheckBiometrics,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            this.authenticate();

            return GradientWrapper(
              child: Container(
                child: Text(
                  'Please Authenticate with Face ID',
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                margin: EdgeInsets.symmetric(vertical: 100, horizontal: 75.0),
              ),
              mainColor: Colors.green,
            );
          }
          return PasscodeWidget(
            this._isVerification!,
            this._onCallback,
            this._onCancel,
          );
        });
  }
}
