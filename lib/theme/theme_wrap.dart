import 'package:flutter/material.dart';

abstract class ThemeWrap {
  final ThemeData themeData;
  Color get headerColor;

  const ThemeWrap({
    @required this.themeData,
  });
}

class DarkTheme implements ThemeWrap {
  ThemeData themeData;

  @override
  Color get headerColor => const Color(0xFF000000);

  DarkTheme() {
    this.themeData = ThemeData.dark();
  }
}

class LightTheme implements ThemeWrap {
  ThemeData themeData;

  @override
  Color get headerColor => const Color(0xFFCCCCCC);

  LightTheme() {
    this.themeData = ThemeData.light();
  }
}
