import 'package:flutter/material.dart';
import 'package:medicine_app/presentation/main_chat_screen/message/customs/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Label text style
  static get labelLargeGray300 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.gray300,
  );
  // Title text style
  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.gray900,
  );
}

extension on TextStyle {
  TextStyle get urbanist {
    return copyWith(
      fontFamily: 'Urbanist',
    );
  }
}
