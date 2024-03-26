import 'package:flutter/cupertino.dart';

class MyPassTextField extends StatefulWidget {

  final controller;
  final String hintText;
  final validator;
  final String errorMsg;
 //// static String text = "";

  const MyPassTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.errorMsg,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyPassTextFieldState();
}

class _MyPassTextFieldState extends State<MyPassTextField> {

  // String errorMsg = "Пароль должен содержать хотя "
  //     "бы одну заглавную, строчную латинские буквы, "
  //     "одну цифру и специальный знак ( !@#&*~_/ ).";
  bool flag = false;
  bool obscureText = true;
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
            obscureText: obscureText,
            placeholder: widget.hintText,

            onChanged: (text) {
              setState(() {
                if (widget.validator(text) == 1) {
                  flag = false;
                  borderColor = CupertinoColors.activeGreen;
                } else if (widget.validator(text) == 2) {
                  flag = true;
                  borderColor = CupertinoColors.systemRed;
                  ///text="";
                }
            ///  MyPassTextField.text=text;
              });
            },
            suffix: CupertinoButton(
              onPressed: toggleVisibility,
              child: Column(
                children: [!obscureText
                  ? const Icon(
                      CupertinoIcons.eye_solid,
                      color: CupertinoColors.systemGrey,
                      size: 20,
                    )
                  : const Icon(
                      CupertinoIcons.eye_slash_fill,
                      color: CupertinoColors.systemGrey,
                      size: 20,
                    ),
                  const SizedBox(width: 20,)
                ]
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            cursorColor: CupertinoColors.activeGreen,
          ),
          const SizedBox(height: 5,),
          Text(
            flag ? widget.errorMsg : "",
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

  void toggleVisibility() => setState(() => obscureText = !obscureText);

}
