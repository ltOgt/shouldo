// framework
import 'package:flutter/material.dart';
// package
import 'package:provider/provider.dart';
// project
import 'page/overview/overview_page.dart';
import 'theme/theme_notifier.dart';
import 'theme/theme_wrap.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(initialTheme: DarkTheme()),
      child: App(),
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
          body: PageView.builder(
            controller: this.pageController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return OverviewPage(
                daysInPast: index,
                goToFirstPage: () => this.pageController.jumpToPage(0),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              themeNotifier.toggle();
            },
          ),
        ),
      ),
    );
  }
}
