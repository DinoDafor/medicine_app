import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:passcode_screen/passcode_screen.dart';

// ignore: must_be_immutable
class PasscodeWidget extends StatefulWidget {
  StreamController<bool> verficationStream;
  Function(String) onPassCallback;
  Function? onCancelCallback;
  void Function()? isValidCallback;

  PasscodeWidget(this.verficationStream, this.onPassCallback, onCancelCallback,
      this.isValidCallback);

  @override
  State<PasscodeWidget> createState() => _PasscodeWidgetState();
}

class _PasscodeWidgetState extends State<PasscodeWidget> {
  @override
  Widget build(BuildContext context) {
    return PasscodeScreen(
        shouldTriggerVerification: widget.verficationStream.stream,
        title: Text('Enter your passcode'),
        passwordEnteredCallback: widget.onPassCallback,
        deleteButton: Text('Delete'),
        cancelButton: Text('Cancel'),
        backgroundColor: Colors.indigo[200],
        isValidCallback: widget.isValidCallback);
  }
}
