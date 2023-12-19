import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';

String _appTheme = "primary";

class ThemeHelper {
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors(),
  };

  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme,
  };

  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  PrimaryColors _getThemeColors() {
    if (!_supportedCustomColor.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  ThemeData _getThemeData() {
    if (!_supportedColorScheme.containsKey(_appTheme)) {
      throw Exception(
          "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
    }
    var colorScheme = _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.primaryContainer,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  PrimaryColors themeColor() => _getThemeColors();

  ThemeData themeData() => _getThemeData();
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
    headlineSmall: TextStyle(
      color: colorScheme.onPrimaryContainer,
      fontSize: 24.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      color: colorScheme.onPrimaryContainer,
      fontSize: 10.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: colorScheme.onPrimaryContainer,
      fontSize: 9.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: colorScheme.primary,
      fontSize: 18.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      color: colorScheme.onPrimaryContainer,
      fontSize: 14.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      color: appTheme.gray500,
      fontSize: 12.fSize,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
    ),
  );
}


class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    primary: Color(0XFF0EBE7E),
    primaryContainer: Color(0XFFFFFFFF),
    errorContainer: Color(0XFF000000),
    onError: Color(0XFF7D7D7D),
    onPrimary: Color(0XFF141414),
    onPrimaryContainer: Color(0XFF646464),

  );
}


class PrimaryColors {
  Color get blueGray100 => Color(0XFFD9D9D9);
  Color get gray500 => Color(0XFF9E9E9E);
  Color get gray700 => Color(0XFF616161);
  Color get gray900 => Color(0XFF212121);
  Color get tealA700 => Color(0XFF0EBE7E);
  Color get whiteA700 => Color(0XFFFFFFFF);
  Color get gray100 => Color(0XFFF5F5F5);
  Color get gray300 => Color(0XFFE0E0E0);
  Color get gray50 => Color(0XFFF9F9F9);
}

PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
