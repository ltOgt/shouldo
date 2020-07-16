// framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shouldo/common/helper/date_helper.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

import 'task_widget.dart';

class SingleTaskWidget extends StatelessWidget {
  const SingleTaskWidget({
    Key key,
    @required this.task,
    this.onCheck,
    this.onUnCheck,
  }) : super(key: key);

  final TaskComposite task;
  final VoidCallback onCheck;
  final VoidCallback onUnCheck;

  @override
  Widget build(BuildContext context) {
    ThemeWrap theme = ThemeNotifier.getTheme(context);
    void _addEvent(OverviewEvent event) =>
        BlocProvider.of<OverviewBloc>(context).add(event);

    return TaskWidget(
      // TODO [STATE] map to bloc callback
      // checkIndicator: Icon(Icons.add_circle_outline), // TODO use for multi
      checkIndicator: Checkbox(
        checkColor: theme.themeData.cardColor,
        value: this.task.completionDate != null,
        onChanged: (bool isChecked) =>
            isChecked ? this.onCheck?.call() : this.onUnCheck?.call(),
        // TODO [UX] theme
      ),
      text: this.task.title,
      dueDateChild: TextElseChild(
        toText: this.task.daysUntilDue,
        child: Tooltip(
          message: task.isCompleted ? "No Deadline" : "Set Deadline",
          child: task.isCompleted
              ? Icon(Icons.block)
              : InkWell(
                  onTap: () async {
                    DateTime _now = DateHelper.withoutTime(DateTime.now());
                    DateTime date = await showDatePicker(
                      context: context,
                      initialDate: _now,
                      firstDate: _now,
                      lastDate: _now.add(Duration(days: 365)),
                    );
                    if (date != null) {
                      _addEvent(
                        OvEventSetTaskDueDate(
                          task: this.task,
                          dueDate: date,
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.calendar_today,
                    size: 18,
                  ),
                ),
        ),
      ),
      startDateChild: TextElseChild(
        toText: this.task.daysSinceStart,
        child: Tooltip(
          message: task.isCompleted ? "No Start Date" : "Activate Task",
          child: task.isCompleted
              ? Icon(Icons.block)
              : InkWell(
                  onTap: () => _addEvent(
                    OvEventStartTask(
                      task: this.task,
                    ),
                  ),
                  child: Icon(
                    Icons.eject,
                    size: 20,
                  ),
                ),
        ),
      ),
    );
  }
}

class TextElseChild extends StatelessWidget {
  const TextElseChild({
    Key key,
    @required this.toText,
    @required this.child,
  }) : super(key: key);

  final dynamic toText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (toText == null) {
      return child;
    } else {
      return Text("$toText");
    }
  }
}
