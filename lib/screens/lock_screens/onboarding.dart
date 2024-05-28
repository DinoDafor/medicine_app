import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medicine_app/screen_lock_services/AuthenticationService.dart';
import 'package:medicine_app/screens/lock_screens/Register.dart';
import 'package:medicine_app/screens/lock_screens/widgets/graddientWrapper.dart';
import 'package:medicine_app/screens/registration_screen.dart';

class OnboardingPage extends StatefulWidget {
  final ScreenArgs args;
  OnboardingPage({required this.args});
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool _enabledFingerprint = false;

  String getEmailArg(BuildContext context) {
    log(widget.args.email);
    log(ModalRoute.of(context)!.settings.arguments.toString());

    /// dynamic args = ModalRoute.of(context)!.settings.arguments;
    String email = widget.args.email;
    String password = widget.args.password;
    if (email.indexOf('.') != -1) {
      return email.substring(0, email.indexOf('.'));
    }

    if (email.indexOf('@') != -1) {
      return email.substring(0, email.indexOf('@'));
    }

    return email;
  }

  void showBioMeteric() {
    localAuth.authenticate(localizedReason: 'Add Passcode?');
  }

  String get switchLabel => Platform.isIOS ? 'Face Id' : 'Touch Id';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GradientWrapper(
      mainColor: Colors.green,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: height * .3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Welcome ${this.getEmailArg(context)}",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40),
            SwitchListTile(
              value: this._enabledFingerprint,
              onChanged: (val) {
                setState(() => this._enabledFingerprint = val);
                if (val) {
                  showBioMeteric();
                }
              },
              title: Text(
                'Enable $switchLabel',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                ),
              ),
              activeColor: Colors.green.shade200,
              secondary: Icon(
                Icons.fingerprint,
              ),
            ),
            SizedBox(height: 100),
            TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, 'setPincodeScreen');
                Map<String, String> creds = {
                  "email": widget.args.email,
                  "password": widget.args.password
                };
                context.go("/setPincode", extra: creds);
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '* You could enable it also in settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
