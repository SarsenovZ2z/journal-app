import 'package:flutter/material.dart';
import 'package:journal/src/themes/app_theme.dart';

class DarkTheme extends AppTheme {
  @override
  Color backgroundColor = const Color(0xFF222831);

  @override
  Brightness brightness = Brightness.dark;

  @override
  MaterialColor primarySwatch = Colors.green;
}
