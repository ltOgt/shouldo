import 'package:flutter/material.dart';

abstract class ThemeWrap {
  final ThemeData themeData;

  const ThemeWrap({
    @required this.themeData,
  });
}

class DarkTheme implements ThemeWrap {
  ThemeData themeData;

  DarkTheme() {
    this.themeData = ThemeData.dark();
  }
}

class LightTheme implements ThemeWrap {
  ThemeData themeData;

  LightTheme() {
    this.themeData = ThemeData.light();
  }
}
