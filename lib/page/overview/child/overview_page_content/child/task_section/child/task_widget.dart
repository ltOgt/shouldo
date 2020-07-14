import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key key,
    @required this.checkIndicator,
    @required this.text,
    @required this.daysLeft,
    @required this.daysSince,
  }) : super(key: key);

  /// E.g. a checkbox
  final Widget checkIndicator;
  final String text;
  final int daysLeft;
  final int daysSince;

  // TODO maybe solve via renderbox reference instead?
  // _ used to make number container fill up row, but not optimal
  final double height = 40;

  static const Radius radius = const Radius.circular(6);

  @override
  Widget build(BuildContext context) {
    final ThemeWrap theme = ThemeNotifier.getTheme(context);

    return Container(
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(radius),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 8,
          ),
          Container(
            width: height / 1.6,
            height: height / 1.6,
            child: this.checkIndicator,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              child: Text(
                this.text,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.startDateColor,
              borderRadius: const BorderRadius.only(
                topLeft: radius,
                bottomLeft: radius,
              ),
            ),
            height: this.height,
            width: this.height,
            child: Center(child: Text("$daysSince")),
          ),
          Container(
            height: this.height,
            width: this.height,
            decoration: BoxDecoration(
              color: theme.dueDateColor,
              borderRadius: const BorderRadius.only(
                topRight: radius,
                bottomRight: radius,
              ),
            ),
            child: Center(child: Text("$daysLeft")),
          ),
        ],
      ),
    );
  }
}
