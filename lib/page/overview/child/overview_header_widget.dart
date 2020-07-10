// framework
import 'package:flutter/material.dart';
// package
import 'package:provider/provider.dart';
// project
import 'package:shouldo/common/widget/theme_toggle_widget.dart';
import 'package:shouldo/theme/theme_notifier.dart';

class OverviewHeaderWidget extends StatelessWidget {
  const OverviewHeaderWidget({
    Key key,
    @required DateTime focusedDate,
    @required this.goToFirstPage,
    @required this.daysInPast,
  })  : _focusedDate = focusedDate,
        super(key: key);

  final DateTime _focusedDate;
  final VoidCallback goToFirstPage;
  final int daysInPast;

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: false);

    return Container(
      height: 100,
      color: themeNotifier.theme.headerColor,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Icon(
              Icons.calendar_today,
              color: _focusedDate.day == DateTime.now().day
                  ? Colors.green
                  : themeNotifier.theme.themeData.iconTheme.color,
            ),
            onTap: _focusedDate.day == DateTime.now().day
                ? null
                : this.goToFirstPage,
          ),
          SizedBox(
            width: 20,
          ),
          Text(_focusedDate.toIso8601String() +
              (this.daysInPast == 0
                  ? "  (Today)"
                  : "  (${this.daysInPast} days ago)")),
          Flexible(
            child: Container(height: 0),
            flex: 1,
          ),
          ThemeToggleWidget(),
        ],
      ),
    );
  }
}
