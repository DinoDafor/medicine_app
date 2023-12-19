import 'package:flutter/material.dart';
import '../core/app_export.dart';


import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomTextStyles {
  static get labelMediumTealA700 => theme.textTheme.labelMedium!.copyWith(
    color: appTheme.tealA700,
    fontWeight: FontWeight.w700,
  );

  static get titleMediumGray500 => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.gray500,
    fontWeight: FontWeight.w600,
  );

  static get labelLargeGray300 => theme.textTheme.labelLarge!.copyWith(
    color: appTheme.gray300,
  );
  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.gray900,
  );
  static get titleMediumTealA700 => theme.textTheme.titleMedium!.copyWith(
    color: appTheme.tealA700,
    fontWeight: FontWeight.w600,
  );
  static get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
    fontSize: 16.fSize,
  );

  static get bodyLargeErrorContainer => theme.textTheme.bodyLarge!.copyWith(
    color: theme.colorScheme.errorContainer,
    fontSize: 17.fSize,
  );
  static get bodyLargeErrorContainer17 => theme.textTheme.bodyLarge!.copyWith(
    color: theme.colorScheme.errorContainer,
    fontSize: 17.fSize,
  );
  static get bodyLargeOnPrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
    color: theme.colorScheme.onPrimaryContainer,
    fontSize: 17.fSize,
  );
}


extension TextStyleExtension on TextStyle {
  TextStyle get urbanist {
    return copyWith(
      fontFamily: 'Urbanist',
    );
  }

  TextStyle get cabin {
    return copyWith(
      fontFamily: 'Cabin',
    );
  }
}

