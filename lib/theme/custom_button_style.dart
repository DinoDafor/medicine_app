import 'dart:ui';
import 'package:medicine_app/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomButtonStyles {
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
