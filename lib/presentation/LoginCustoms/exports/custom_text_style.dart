import 'package:flutter/material.dart';
import 'package:medicine_app/presentation/LoginCustoms/app_export.dart';


class CustomTextStyles {
  // Body text style
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
  // Title text style
  static get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
    fontSize: 16.fSize,
  );
}

extension on TextStyle {
  TextStyle get cabin {
    return copyWith(
      fontFamily: 'Cabin',
    );
  }
}