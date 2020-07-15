import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shouldo/common/helper/date_helper.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

class ExpandedBottomBarArea extends StatefulWidget {
  const ExpandedBottomBarArea({
    Key key,
    @required this.focusNode,
    @required this.isDone,
  }) : super(key: key);

  final FocusNode focusNode;
  // TODO better solution? but not as complex as listener or stream?
  final bool isDone;

  @override
  _ExpandedBottomBarAreaState createState() => _ExpandedBottomBarAreaState();
}

class _ExpandedBottomBarAreaState extends State<ExpandedBottomBarArea> {
  DateTime _sDueDate;
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    this.textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    this.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeWrap theme = ThemeNotifier.getTheme(context);

    if (widget.isDone) {
      BlocProvider.of<OverviewBloc>(context).add(
        OvEventAddTask(
          // TODO this does not prevent empty text directly
          title: this.textEditingController.text,
          dueDate: this._sDueDate,
        ),
      );
      this.textEditingController.clear();
    }

    return Container(
      color: theme.themeData.cardColor,
      height: theme.adderAreaHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: this.textEditingController,
            decoration: InputDecoration(
              hintText: "Define a task",
            ),
            focusNode: this.widget.focusNode,
          ),
          Container(
            child: Text("Deadline"),
          ),
          InkWell(
            onTap: () async {
              final DateTime _now = DateTime.now();
              final DateTime _select = await showDatePicker(
                context: context,
                initialDate: this._sDueDate ?? _now,
                firstDate: _now,
                lastDate: _now.add(Duration(days: 365)),
              );
              if (_select != null && _select != this._sDueDate)
                setState(() {
                  this._sDueDate = _select;
                });
            },
            child: Row(
              children: <Widget>[
                Container(
                  height: 25,
                  color: this._sDueDate == null ? Colors.blue : Colors.green,
                  child: Center(
                      child: Text(
                          DateHelper.dateString(this._sDueDate) ?? "Select")),
                ),
                Flexible(
                  child: InkWell(
                    onTap: () => setState(() {
                      this._sDueDate = null;
                    }),
                    child: this._sDueDate == null
                        ? Container()
                        : Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
