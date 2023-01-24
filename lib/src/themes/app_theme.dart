import 'package:flutter/material.dart';

abstract class AppTheme {
  abstract MaterialColor primarySwatch;

  abstract Color backgroundColor;

  abstract Brightness brightness;

  final String fontFamily = 'Cofo Sans';

  ThemeData getThemeData() => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatch,
          brightness: brightness,
        ),
        fontFamily: fontFamily,
        scaffoldBackgroundColor: backgroundColor,
        brightness: brightness,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
