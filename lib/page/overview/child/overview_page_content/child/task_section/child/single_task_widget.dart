// framework
import 'package:flutter/material.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';

import 'task_widget.dart';

class SingleTaskWidget extends StatelessWidget {
  const SingleTaskWidget({
    Key key,
    @required this.taskData,
  }) : super(key: key);

  final TaskComposite taskData;

  @override
  Widget build(BuildContext context) {
    return TaskWidget(
      // TODO [STATE] map to bloc callback
      checkIndicator: Checkbox(
        value: false,
        onChanged: (bool isChecked) => null,

        // TODO [UX] theme
      ),
      // checkIndicator: Icon(Icons.add_circle_outline), // TODO use for multi
      text: this.taskData.title,
      daysLeft: this.taskData.daysUntilDue,
      daysSince: this.taskData.daysSinceStart,
    );
  }
}
