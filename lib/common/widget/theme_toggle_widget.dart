// framework
import 'package:flutter/material.dart';
// package
// project
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier =
        ThemeNotifier.of(context, listen: false);

    return InkWell(
      child: Icon(
        themeNotifier.theme is LightTheme ? Icons.tonality : Icons.wb_sunny,
        size: 28,
      ),
      onTap: themeNotifier.toggle,
    );
  }
}
