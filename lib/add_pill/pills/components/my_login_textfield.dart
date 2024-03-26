import 'package:flutter/cupertino.dart';

class MyLoginTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final validator;
 //// static String login ="";

  const MyLoginTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyLoginTextFieldState();
}

class _MyLoginTextFieldState extends State<MyLoginTextField> {
  int validated = 0;
  String errorMsg = "Пожалуйста, введите правильную почту";
  var borderColor = CupertinoColors.lightBackgroundGray;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          CupertinoTextField(
            padding: const EdgeInsets.all(15),
            controller: widget.controller,
            placeholder: widget.hintText,
            onChanged: (text) {
              setState(() {
                if (widget.validator(text) == 1) {
                  validated = 1;
                  borderColor = CupertinoColors.activeGreen;
                 /// MyLoginTextField.login=text;
                } else if (widget.validator(text) == 2) {
                  validated = 2;
                  borderColor = CupertinoColors.systemRed;
                 //// MyLoginTextField.login="";
                }
              });
            },
            suffix: CupertinoButton(
              onPressed: () {},
              child: Column(children: [
                if (validated == 1)
                  Icon(
                    CupertinoIcons.check_mark,
                    color: borderColor,
                    size: 20,
                  )
                else if (validated == 2)
                  Icon(
                    CupertinoIcons.clear,
                    color: borderColor,
                    size: 20,
                  ),
                const SizedBox(
                  width: 20,
                ),
              ]),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10)),
            cursorColor: CupertinoColors.activeGreen,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            validated == 2 ? errorMsg : "",
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: CupertinoColors.systemRed,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
