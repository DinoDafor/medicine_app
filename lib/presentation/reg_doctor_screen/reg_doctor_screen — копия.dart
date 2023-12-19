import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart'; // Подставьте правильный путь
import 'package:medicine_app/widgets/custom_elevated_button.dart';
import 'package:medicine_app/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class RegDoctorScreen extends StatelessWidget {
  RegDoctorScreen({Key? key}) : super(key: key);

  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController userFieldController = TextEditingController();
  final TextEditingController callFieldController = TextEditingController();
  final TextEditingController overflowMenuField1Controller = TextEditingController();
  final TextEditingController overflowMenuField2Controller = TextEditingController();

  final FocusNode emailFieldFocusNode = FocusNode();
  final FocusNode userFieldFocusNode = FocusNode();
  final FocusNode callFieldFocusNode = FocusNode();
  final FocusNode overflowMenuField1FocusNode = FocusNode();
  final FocusNode overflowMenuField2FocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WebSocketChannel? _channel;

  void connectToWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://free.blr2.piesocket.com/v3/1?api_key=qZ28jP8J7r1dvJueRYyQPyfmGi46IFST5NPrnImg&notify_self=1'),
    );

    _channel?.stream.listen(
          (message) {
        print('Received from WebSocket: $message');
      },
      onDone: () {
        print('WebSocket connection closed');
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
    );
  }

  void sendMessage(String message) {
    if (_channel != null) {
      _channel?.sink.add(message);
    }
  }

  void closeWebSocketConnection() {
    if (_channel != null) {
      _channel?.sink.close();
    }
  }

  Future<void> registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var userData = {
        'email': emailFieldController.text,
        'name': userFieldController.text,
        'phone': callFieldController.text,
        'password': overflowMenuField1Controller.text,
      };

      var response = await http.post(
        Uri.parse('wss://free.blr2.piesocket.com/v3/1?api_key=qZ28jP8J7r1dvJueRYyQPyfmGi46IFST5NPrnImg&notify_self=1'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        connectToWebSocket();
        // Отправляем сообщение после короткой задержки, чтобы дать время на установление соединения
        Future.delayed(Duration(seconds: 1), () {
          sendMessage('{"event": "registration", "email": "${emailFieldController.text}"}');
        });

        Navigator.pushNamed(context, '/nextScreen');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ошибка'),
              content: Text('Произошла ошибка при регистрации: ${response.body}'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 35.h,
            vertical: 45.v,
          ),
          child: Column(
            children: [
              Spacer(flex: 59),
              Text(
                "Регистрация/Доктор",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 42.v),
              _buildEmailField(context),
              SizedBox(height: 35.v),
              _buildUserField(context),
              SizedBox(height: 36.v),
              _buildCallField(context),
              SizedBox(height: 35.v),
              _buildOverflowMenuField1(context),
              SizedBox(height: 35.v),
              _buildOverflowMenuField2(context),
              SizedBox(height: 44.v),
              _buildLoginButton(context),
              Spacer(flex: 40),
              _buildBottomText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return CustomTextFormField(
      focusNode: emailFieldFocusNode,
      controller: emailFieldController,
      hintText: "Email ID",
      textInputType: TextInputType.emailAddress,
      autofocus: false,
      prefix: Container(
        margin: EdgeInsets.only(right: 25.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgVectorPrimary,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 35.v),
    );
  }

  Widget _buildUserField(BuildContext context) {
    return CustomTextFormField(
      focusNode: userFieldFocusNode,
      controller: userFieldController,
      hintText: "Ваше имя",
      autofocus: false,
      prefix: Container(
        margin: EdgeInsets.only(left: 1.h, right: 26.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgUser,
          height: 19.v,
          width: 18.h,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 35.v),
    );
  }

  Widget _buildCallField(BuildContext context) {
    return CustomTextFormField(
      focusNode: callFieldFocusNode,
      controller: callFieldController,
      hintText: "Номер телефона",
      autofocus: false,
      prefix: Container(
        margin: EdgeInsets.only(left: 1.h, right: 26.h, bottom: 15.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgCall,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 34.v),
    );
  }

  Widget _buildOverflowMenuField1(BuildContext context) {
    return CustomTextFormField(
      focusNode: overflowMenuField1FocusNode,
      controller: overflowMenuField1Controller,
      hintText: "Пароль",
      autofocus: false,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(1.h, 1.v, 27.h, 13.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgOverflowmenuPrimary,
          height: 20.v,
          width: 17.h,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 33.v),
    );
  }

  Widget _buildOverflowMenuField2(BuildContext context) {
    return CustomTextFormField(
      focusNode: overflowMenuField2FocusNode,
      controller: overflowMenuField2Controller,
      hintText: "Повторите пароль",
      textInputAction: TextInputAction.done,
      autofocus: false,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(1.h, 1.v, 27.h, 13.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgOverflowmenuPrimary,
          height: 20.v,
          width: 17.h,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 33.v),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Регистрация",
      onPressed: () => registerUser(context),
    );
  }

  Widget _buildBottomText(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Вы уже регистрировались?",
              style: CustomTextStyles.bodyLargeOnPrimaryContainer,
            ),
            TextSpan(text: " "),
            TextSpan(
              text: "Войти",
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
