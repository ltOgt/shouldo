// framework
import 'package:flutter/material.dart';
// package
import 'package:provider/provider.dart';
// project
import 'package:shouldo/common/widget/theme_toggle_widget.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/common/helper/date_helper.dart';

class OverviewHeaderWidget extends StatelessWidget {
  const OverviewHeaderWidget({
    Key key,
    @required this.focusedDate,
    @required this.goToFirstPage,
    @required this.daysInPast,
  }) : super(key: key);

  final DateTime focusedDate;
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
              color: DateHelper.isToday(this.focusedDate)
                  ? Colors.green
                  : themeNotifier.theme.themeData.iconTheme.color,
            ),
            onTap: DateHelper.isToday(this.focusedDate)
                ? null
                : this.goToFirstPage,
          ),
          SizedBox(
            width: 20,
          ),
          Text(DateHelper.dateString(this.focusedDate)),
          Flexible(
            child: Container(height: 0),
            flex: 1,
          ),
          Text(
            (this.daysInPast == 0
                ? "(Today)"
                : "(" +
                    DateHelper.dayAgoString(this.focusedDate).toString() +
                    ")"),
          ),
          SizedBox(width: 10),
          ThemeToggleWidget(),
        ],
      ),
    );
  }
}
