// framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// package
import 'package:provider/provider.dart';
import 'package:shouldo/data/db/moor_db.dart';
// project
import 'page/overview/overview_page.dart';
import 'theme/theme_notifier.dart';
import 'theme/theme_wrap.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (_) => AppDatabase(),
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(initialTheme: DarkTheme()),
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = ThemeNotifier.of(context, listen: true);

    return MaterialApp(
      theme: themeNotifier.theme.themeData,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: themeNotifier.theme.themeData.backgroundColor,
          body: OverviewPage(daysInPast: 0, goToFirstPage: null),
        ),
      ),
    );
  }
}
