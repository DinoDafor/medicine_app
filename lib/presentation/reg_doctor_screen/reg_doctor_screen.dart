import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medicine_app/presentation/LoginCustoms/app_export.dart';
import 'package:medicine_app/presentation/LoginCustoms/custom_elevated_button.dart';
import 'package:medicine_app/presentation/LoginCustoms/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var userData = {
        'firstName': userFieldController.text,
        'lastName': 'Doctor',
        'email': emailFieldController.text,
        'password': overflowMenuField1Controller.text,
        'specialization': '',
        'contactNumber': callFieldController.text,
        'clinicAddress': 'null',
        'otherRelevantInfo': ''
      };

      var response = await http.post(
        Uri.parse('http://ezhidze.su:8080/medApp/doctors/registration'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        await saveLoginCredentials(emailFieldController.text, overflowMenuField1Controller.text);
        Navigator.pushNamed(context, '/thirtyfive_container_screen');
      } else {
        final snackBar = SnackBar(content: Text('Ошибка регистрации: ${response.body}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future<void> saveLoginCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
    await prefs.setString('userPassword', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 45.v),
          child: Column(
            children: [
              Spacer(flex: 59),
              Text("Регистрация/Доктор", style: theme.textTheme.headlineLarge),
              SizedBox(height: 42.v),
              _buildEmailField(context),
              SizedBox(height: 35.v),
              _buildUserField(context),
              SizedBox(height: 36.v),
              _buildCallField(context),
              SizedBox(height: 35.v),
              _buildPasswordField(context),
              SizedBox(height: 35.v),
              _buildRepeatPasswordField(context),
              SizedBox(height: 44.v),
              _buildRegisterButton(context),
              Spacer(flex: 40),
              _buildBottomText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
        focusNode: emailFieldFocusNode,
        controller: emailFieldController,
        hintText: "Email",
        validator: _validateEmail,
        prefix: _buildPrefixContainer(ImageConstant.imgVectorPrimary),
        prefixConstraints: BoxConstraints(maxHeight: 35.v),
      ),
    );
  }

  Widget _buildUserField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
        focusNode: userFieldFocusNode,
        controller: userFieldController,
        hintText: "Ваше имя",
        validator: _validateName,
        prefix: _buildPrefixContainer(ImageConstant.imgUser),
        prefixConstraints: BoxConstraints(maxHeight: 35.v),
      ),
    );
  }

  Widget _buildCallField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
        focusNode: callFieldFocusNode,
        controller: callFieldController,
        hintText: "Номер телефона",
        validator: _validatePhone,
        prefix: _buildPrefixContainer(ImageConstant.imgCall),
        prefixConstraints: BoxConstraints(maxHeight: 35.v),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
        focusNode: overflowMenuField1FocusNode,
        controller: overflowMenuField1Controller,
        hintText: "Пароль",
        validator: _validatePassword,
        prefix: _buildPrefixContainer(ImageConstant.imgOverflowmenuPrimary),
        prefixConstraints: BoxConstraints(maxHeight: 35.v),
      ),
    );
  }

  Widget _buildRepeatPasswordField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
        focusNode: overflowMenuField2FocusNode,
        controller: overflowMenuField2Controller,
        hintText: "Повторите пароль",
        validator: (value) {
          if (value != overflowMenuField1Controller.text) {
            return 'Пароли не совпадают';
          }
          return null;
        },
        prefix: _buildPrefixContainer(ImageConstant.imgOverflowmenuPrimary),
        prefixConstraints: BoxConstraints(maxHeight: 35.v),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Регистрация",
      margin: EdgeInsets.symmetric(horizontal: 4.h),
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email не может быть пустым';
    }
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Введите валидный email адрес';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пароль не может быть пустым';
    }
    if (value.length < 8) {
      return 'Пароль должен содержать не менее 8 символов';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Телефон не может быть пустым';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Имя не может быть пустым';
    }
    return null;
  }

  Container _buildPrefixContainer(String imagePath) {
    return Container(
      margin: EdgeInsets.all(10.h),
      child: CustomImageView(
        imagePath: imagePath,
        height: 20.adaptSize,
        width: 20.adaptSize,
      ),
    );
  }
}



