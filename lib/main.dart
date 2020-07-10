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

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    this.pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    this.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);

    return MaterialApp(
      theme: themeNotifier.theme.themeData,
      home: SafeArea(
        child: Scaffold(
          // TODO might have to pull bloc up to here in order to keep header and footer static
          // TODO could potentially also use horizontal list view instead of page view
          body: OverviewPage(daysInPast: 0, goToFirstPage: null),
          // PageView.builder(
          //   reverse: true,
          //   controller: this.pageController,
          //   physics: const BouncingScrollPhysics(),
          //   itemBuilder: (BuildContext context, int index) {
          //     return OverviewPage(
          //       daysInPast: index,
          //       goToFirstPage: () => this.pageController.jumpToPage(0),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
