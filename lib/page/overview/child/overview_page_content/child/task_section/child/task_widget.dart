import 'package:flutter/material.dart';

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
  final double height = 50;

  static const Radius radius = const Radius.circular(6);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(radius),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: <Widget>[
          this.checkIndicator,
          Text(this.text),
          Flexible(child: Container(height: 1)),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF292929), // TODO move to theme
              borderRadius: const BorderRadius.only(
                topLeft: radius,
                bottomLeft: radius,
              ),
            ),
            height: this.height,
            width: this.height,
            child: Center(child: Text("$daysLeft")),
          ),
          Container(
            height: this.height,
            width: this.height,
            decoration: BoxDecoration(
              color: const Color(0xFF2F2F2F), // TODO move to theme
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