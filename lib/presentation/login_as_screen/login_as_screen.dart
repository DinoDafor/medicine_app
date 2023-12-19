import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';
import 'package:medicine_app/presentation/LoginCustoms/custom_elevated_button.dart';

class LoginAsScreen extends StatelessWidget {
  const LoginAsScreen({Key? key})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 36.h,
          vertical: 100.v,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgRoleScreenIllustration,
              height: 360.v,
              width: 308.h,
            ),
            Spacer(),
            CustomElevatedButton(
              text: "Продолжить как пациент",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.loginPatientScreen);
              },
            ),
            SizedBox(height: 59.v),
            CustomElevatedButton(
              text: "Продолжить как доктор",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.loginDoctorScreen);
              },
            ),
            SizedBox(height: 30.v),
          ],
        ),
      ),
    );
  }
}
