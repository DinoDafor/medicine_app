import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';
import 'package:medicine_app/widgets/custom_elevated_button.dart';
import 'package:medicine_app/widgets/custom_text_form_field.dart';

class LoginPatientScreen extends StatelessWidget {
  LoginPatientScreen({Key? key})
      : super(
    key: key,
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController overflowmenuController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
            vertical: 45.v,
          ),
          child: Column(
            children: [
              Spacer(
                flex: 52,
              ),
              Text(
                "Авторизация/Пациент",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 56.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 9.h,
                  right: 15.h,
                ),
                child: CustomTextFormField(
                  focusNode: emailFocusNode,
                  controller: emailController,
                  hintText: "Email ",
                  textInputType: TextInputType.emailAddress,
                  autofocus: false,
                  prefix: Container(
                    margin: EdgeInsets.only(right: 25.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgVector,
                      height: 20.adaptSize,
                      width: 20.adaptSize,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(
                    maxHeight: 36.v,
                  ),
                ),
              ),
              SizedBox(height: 33.v),
              _buildStackWithOverflowMenu(context),
              SizedBox(height: 53.v),
              CustomElevatedButton(
                text: "Авторизоваться",
                margin: EdgeInsets.only(
                  left: 9.h,
                  right: 15.h,
                ),
              ),
              Spacer(
                flex: 47,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Вы у нас впервые?",
                      style: CustomTextStyles.bodyLargeOnPrimaryContainer,
                    ),
                    TextSpan(
                      text: " ",
                    ),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.regPatientScreen);
                        },
                        child: Text(
                          "Зарегистрируйтесь",
                          style: theme.textTheme.titleMedium?.copyWith(color: Colors.green) ??
                              TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStackWithOverflowMenu(BuildContext context) {
    return SizedBox(
      height: 38.v,
      width: 342.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          CustomTextFormField(
            width: 342.h,
            focusNode: passwordFocusNode,
            controller: overflowmenuController,
            hintText: "Пароль",
            textInputAction: TextInputAction.done,
            autofocus: false,
            alignment: Alignment.bottomCenter,
            prefix: Container(
              margin: EdgeInsets.only(
                left: 1.h,
                right: 27.h,
                bottom: 14.v,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgOverflowmenu,
                height: 20.v,
                width: 17.h,
              ),
            ),
            prefixConstraints: BoxConstraints(
              maxHeight: 35.v,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "Забыли пароль?",
              style: CustomTextStyles.titleMedium16,
            ),
          ),
        ],
      ),
    );
  }
}
