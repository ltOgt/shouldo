// framework
import 'package:flutter/material.dart';
// package
import 'package:provider/provider.dart';
// project
import 'page/overview/overview_page.dart';
import 'theme/theme_notifier.dart';
import 'theme/theme_wrap.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PageController pageController;
  ThemeNotifier themeNotifier;

  @override
  void initState() {
    super.initState();
    this.pageController = PageController(initialPage: 0);
    this.themeNotifier = ThemeNotifier(initialTheme: DarkTheme());
  }

  @override
  void dispose() {
    this.pageController.dispose();
    this.themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>.value(
      value: this.themeNotifier,
      child: MaterialApp(
        theme: this.themeNotifier.theme.themeData,
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
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     Provider.of<ThemeNotifier>(context, listen: false).toggle();
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
