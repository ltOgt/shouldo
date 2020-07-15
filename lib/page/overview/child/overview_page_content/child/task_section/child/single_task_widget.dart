// framework
import 'package:flutter/material.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

import 'task_widget.dart';

class SingleTaskWidget extends StatelessWidget {
  const SingleTaskWidget({
    Key key,
    @required this.taskData,
    this.onCheck,
    this.onUnCheck,
  }) : super(key: key);

  final TaskComposite taskData;
  final VoidCallback onCheck;
  final VoidCallback onUnCheck;

  @override
  Widget build(BuildContext context) {
    ThemeWrap theme = ThemeNotifier.getTheme(context);

    return TaskWidget(
      // TODO [STATE] map to bloc callback
      checkIndicator: Checkbox(
        checkColor: theme.themeData.cardColor,
        value: this.taskData.completionDate != null,
        onChanged: (bool isChecked) =>
            isChecked ? this.onCheck?.call() : this.onUnCheck?.call(),
        // TODO [UX] theme
      ),
      // checkIndicator: Icon(Icons.add_circle_outline), // TODO use for multi
      text: this.taskData.title,
      daysLeft: this.taskData.daysUntilDue,
      daysSince: this.taskData.daysSinceStart,
    );
  }
}
