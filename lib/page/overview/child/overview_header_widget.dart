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
      height: 80,
      color: themeNotifier.theme.headerColor,
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.calendar_today,
                  size: 28,
                  color: DateHelper.isToday(this.focusedDate)
                      ? Colors.green
                      : themeNotifier.theme.themeData.iconTheme.color,
                ),
                if (daysInPast != 0)
                  Container(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      daysInPast.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: DateHelper.isToday(this.focusedDate)
                ? null
                : this.goToFirstPage,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateHelper.weekdayString(this.focusedDate),
                style: TextStyle(fontSize: 24),
              ),
              Text(DateHelper.dateString(this.focusedDate)),
            ],
          ),
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
