// framework
import 'package:flutter/material.dart';
// children
import 'theme_wrap.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeWrap theme;

  ThemeNotifier({
    @required ThemeWrap initialTheme,
  }) {
    this.theme = initialTheme;
  }

  void changeTheme(ThemeWrap newTheme) {
    this.theme = newTheme;
    notifyListeners();
  }

  void toggle() {
    if (this.theme is DarkTheme) {
      this.changeTheme(LightTheme());
    } else if (this.theme is LightTheme) {
      this.changeTheme(DarkTheme());
    } else {
      throw ("Unhandled Theme: ${this.theme}");
    }
  }
}
