import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medicine_app/bloc/authentication_bloc.dart';
import 'package:medicine_app/bloc/navigation_bloc.dart';
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
  StreamController<bool>? _isVerification = StreamController<bool>.broadcast();
  Future<bool>? hasBio;
  int attempts = 0;

  @override
  void initState() {
    authService.isEnabledStream;

    ///this._isVerification = authService.isEnabledStream;
    super.initState();
  }

  void _onCallback(String enteredCode) async {
    bool correct = await authService.verifyCode(enteredCode);
    print(" is Correct ${correct}");
    this._isVerification!.add(correct);

    // this._isVerification!.listen((isValid) {
    //   print(
    //     "IS VALID ${isValid}",
    //   );
    //   if (isValid) {
    //     context.pop(enteredCode);
    //   } else {
    //     setState(() => attempts += 1);
    //     if (attempts == 5) {
    //       context.pop(null);
    //     }
    //   }
  }

  void _onCancel() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  // Future<void> authenticate(bool supportBio) async {
  //   if(supportBio)
  //   final isAuthenticated = await localAuth.authenticate(
  //       localizedReason: 'Do something',
  //       options: AuthenticationOptions(
  //         stickyAuth: true,
  //         useErrorDialogs: true,
  //       ));
  //   authService.isEnabledController.add(isAuthenticated);
  //   if (isAuthenticated) {
  //     final creds = await authService.getCredsByBio();
  //     BlocProvider.of<AuthenticationBloc>(context)
  //         .add(AuthenticationSighInEvent(creds!["email"]!, creds["password"]!));
  //   }
  // }
  void _isValidCallback() async {
    final creds = await authService.getCreds();
    BlocProvider.of<AuthenticationBloc>(context)
        .add(AuthenticationSighInEvent(creds!["email"], creds["password"]));
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<bool>(
    //     future: authService.checkSupportBioAuth(),
    //     builder: (context, snapshot) {

    return PasscodeWidget(
      this._isVerification!,
      this._onCallback,
      this._onCancel,
      this._isValidCallback,
    );
  }
}
///}
