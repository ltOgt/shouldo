import 'package:flutter/material.dart';

abstract class ThemeWrap {
  final ThemeData themeData;
  Color get headerColor;
  double get sidePadding => 22;

  const ThemeWrap({
    @required this.themeData,
  });
}

class DarkTheme extends ThemeWrap {
  ThemeData themeData;

  @override
  Color get headerColor => const Color(0xFF1E1E1E);

  DarkTheme() {
    this.themeData = ThemeData.dark().copyWith(
      backgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      scaffoldBackgroundColor: const Color(0xFF121212),
    );
  }
}

class LightTheme extends ThemeWrap {
  ThemeData themeData;

  @override
  Color get headerColor => const Color(0xFFCCCCCC);

  LightTheme() {
    this.themeData = ThemeData.light();
  }
}
