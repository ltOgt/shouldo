// framework
import 'package:flutter/material.dart';
// package
import 'package:provider/provider.dart';
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
        Provider.of<ThemeNotifier>(context, listen: false);

    return InkWell(
      child: Icon(
        themeNotifier.theme is LightTheme ? Icons.tonality : Icons.wb_sunny,
        size: 28,
      ),
      onTap: themeNotifier.toggle,
    );
  }
}
