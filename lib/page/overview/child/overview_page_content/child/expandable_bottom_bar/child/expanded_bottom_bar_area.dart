import 'package:flutter/material.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

class ExpandedBottomBarArea extends StatefulWidget {
  const ExpandedBottomBarArea({
    Key key,
    @required this.focusNode,
  }) : super(key: key);

  final FocusNode focusNode;

  @override
  _ExpandedBottomBarAreaState createState() => _ExpandedBottomBarAreaState();
}

class _ExpandedBottomBarAreaState extends State<ExpandedBottomBarArea> {
  DateTime _sDueDate;

  @override
  Widget build(BuildContext context) {
    ThemeWrap theme = ThemeNotifier.getTheme(context);

    return Container(
      color: theme.themeData.cardColor,
      height: theme.adderAreaHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Define a task",
            ),
            focusNode: this.widget.focusNode,
          ),
          Container(
            child: Text("Deadline"),
          ),
          Container(
            height: 25,
            width: 50,
            color: this._sDueDate == null ? Colors.blue : Colors.green,
            child: Center(child: Text(this._sDueDate ?? "Select")),
          ),
        ],
      ),
    );
  }
}
