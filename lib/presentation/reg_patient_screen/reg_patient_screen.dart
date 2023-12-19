import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';
import 'package:medicine_app/presentation/LoginCustoms/custom_elevated_button.dart';
import 'package:medicine_app/presentation/LoginCustoms/custom_text_form_field.dart';

class RegPatientScreen extends StatelessWidget {
  RegPatientScreen({Key? key}) : super(key: key);

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
            horizontal: 32.h,
            vertical: 45.v,
          ),
          child: Column(
            children: [
              Spacer(flex: 59),
              Text(
                "Регистрация/Пациент",
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
        focusNode: emailFieldFocusNode,
        controller: emailFieldController,
        hintText: "Email ID",
        textInputType: TextInputType.emailAddress,
        autofocus: false,
        prefix: Container(
          margin: EdgeInsets.only(
            top: 1.v,
            right: 25.h,
            bottom: 1.v,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgVectorPrimary,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
        ),
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
        autofocus: false,
        prefix: Container(
          margin: EdgeInsets.only(
            left: 1.h,
            right: 26.h,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgUser,
            height: 19.v,
            width: 18.h,
          ),
        ),
        prefixConstraints: BoxConstraints(maxHeight: 35.v),
      ),
    );
  }

  Widget _buildCallField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 4.h,
        right: 3.h,
      ),
      child: CustomTextFormField(
        focusNode: callFieldFocusNode,
        controller: callFieldController,
        hintText: "Номер телефона",
        autofocus: false,
        prefix: Container(
          margin: EdgeInsets.only(
            left: 1.h,
            right: 26.h,
            bottom: 15.v,
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgCall,
            height: 18.adaptSize,
            width: 18.adaptSize,
          ),
        ),
        prefixConstraints: BoxConstraints(maxHeight: 34.v),
      ),
    );
  }

  Widget _buildOverflowMenuField1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
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
      ),
    );
  }

  Widget _buildOverflowMenuField2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.h),
      child: CustomTextFormField(
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
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Войти",
      margin: EdgeInsets.symmetric(horizontal: 4.h),
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
