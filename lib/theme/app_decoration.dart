import 'package:flutter/material.dart';
import 'package:medicine_app/core/app_export.dart';

class AppDecoration {
  static final BoxDecoration fillPrimaryContainer = BoxDecoration(
    color: theme.colorScheme.primaryContainer,
  );

  static BoxDecoration get fillGray => BoxDecoration(
    color: appTheme.gray100,
  );

  static final BoxDecoration fillWhiteA = BoxDecoration(
    color: appTheme.whiteA700,
  );

  static BoxDecoration get fillTealA => BoxDecoration(
    color: appTheme.tealA700,
  );
}

class BorderRadiusStyle {
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
