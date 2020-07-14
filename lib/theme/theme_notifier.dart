// framework
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// children
import 'theme_wrap.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeWrap theme;

  static ThemeWrap getTheme(BuildContext context) {
    return Provider.of<ThemeNotifier>(context, listen: false).theme;
  }

  static ThemeNotifier of(BuildContext context, {listen: false}) {
    return Provider.of<ThemeNotifier>(context, listen: listen);
  }

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
