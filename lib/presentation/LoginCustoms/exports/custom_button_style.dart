import 'dart:ui';
import 'package:medicine_app/presentation/LoginCustoms/app_export.dart';
import 'package:flutter/material.dart';

class CustomButtonStyles {
  // text button style
  static ButtonStyle get none => ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    elevation: MaterialStateProperty.all<double>(0),
  );
}