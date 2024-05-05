import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_app/screen_lock_services/AuthenticationService.dart';
import 'package:medicine_app/screens/lock_screens/widgets/passcodeWidget.dart';

class SetupPincode extends StatefulWidget {
  @override
  _SetupPincodeState createState() => _SetupPincodeState();
}

class _SetupPincodeState extends State<SetupPincode> {
  StreamController<bool>? verficationController;

  void _onCallback(String enteredCode) {
    authService.verifyCode(enteredCode);
    authService.isEnabledStream.listen((isSet) {
      if (isSet) {
        Navigator.pushNamed(context, 'home');
      }
    });
  }

  void _onCancelCakllBack() {
    // Should be disabled since you're already set the bio.
    return;
  }

  void initState() {
    this.verficationController = authService.isEnabledController;
    super.initState();
  }

  @override
  void dispose() {
    this.verficationController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PasscodeWidget(
      this.verficationController!.stream,
      this._onCallback,
      this._onCancelCakllBack,
    );
  }
}
