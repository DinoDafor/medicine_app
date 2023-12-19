import 'package:flutter/material.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
    color: appTheme.gray100,
  );
  static BoxDecoration get fillTealA => BoxDecoration(
    color: appTheme.tealA700,
  );
  static BoxDecoration get fillWhiteA => BoxDecoration(
    color: appTheme.whiteA700,
  );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderBL20 => BorderRadius.only(
    topLeft: Radius.circular(8.h),
    topRight: Radius.circular(20.h),
    bottomLeft: Radius.circular(20.h),
    bottomRight: Radius.circular(20.h),
  );
  static BorderRadius get customBorderTL20 => BorderRadius.only(
    topLeft: Radius.circular(20.h),
    topRight: Radius.circular(20.h),
    bottomLeft: Radius.circular(20.h),
    bottomRight: Radius.circular(8.h),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;