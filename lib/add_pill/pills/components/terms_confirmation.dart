import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsConfirmation extends StatefulWidget {
 static bool checked = false;
  const TermsConfirmation({super.key});

  @override
  State<TermsConfirmation> createState() => _TermsConfirmationState(checked);
  
}

class _TermsConfirmationState extends State<TermsConfirmation> {

 
bool checked;
_TermsConfirmationState(this.checked);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CupertinoButton(
            child: TermsConfirmation.checked
                ? const Icon(
                  CupertinoIcons.checkmark_circle,
                  size: 20,
                  color: CupertinoColors.activeGreen,
                )
                : const Icon(
                  CupertinoIcons.circle,
                  size: 20,
                  color: Colors.grey,
                ),
            onPressed: () {
              setState(() {
                TermsConfirmation.checked = !TermsConfirmation.checked;
                log(checked.toString(), name: "Checked in terms");
              });
            }
        ),
        Text(
          "Я согласен с ",
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Roboto",
              color: Colors.grey[600]
          ),
        ),
        const Text(
          "Политикой конфиденциальности",
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Roboto",
              color: CupertinoColors.activeGreen
          ),
        ),
      ],
    );
  }
}
