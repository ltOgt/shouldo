import 'package:flutter/material.dart';

abstract class ThemeWrap {
  final ThemeData themeData;

  Color get headerColor;
  Color get dueDateColor; // TODO [UX] add different colors for different phase
  Color
      get startDateColor; // TODO [UX] add different colors for different phase

  double get sidePadding => 22;
  double get adderBarHeight => 50;

  const ThemeWrap({
    @required this.themeData,
  });
}

class DarkTheme extends ThemeWrap {
  ThemeData themeData;

  DarkTheme() {
    this.themeData = ThemeData.dark().copyWith(
      backgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      scaffoldBackgroundColor: const Color(0xFF121212),
    );
  }

  @override
  Color get headerColor => const Color(0xFF1E1E1E);

  @override
  Color get dueDateColor => const Color(0xFF2F2F2F);

  @override
  Color get startDateColor => const Color(0xFF292929);
}

class LightTheme extends ThemeWrap {
  ThemeData themeData;

  LightTheme() {
    this.themeData = ThemeData.light().copyWith(
      backgroundColor: const Color(0xFFEFEFEF),
      cardColor: const Color(0xFF999999),
      scaffoldBackgroundColor: const Color(0xFFEFEFEF),
    );
  }

  @override
  Color get headerColor => const Color(0xFFCCCCCC);

  @override
  Color get dueDateColor => const Color(0xFF6F6F6F);

  @override
  Color get startDateColor => const Color(0xFF696969);
}
