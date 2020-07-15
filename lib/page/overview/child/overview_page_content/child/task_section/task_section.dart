import 'package:flutter/material.dart';
import 'package:shouldo/data/composite/task_composite.dart';

import 'child/single_task_widget.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({
    Key key,
    @required this.title,
    @required this.tasks,
    this.onCheck,
    this.onUnCheck,
  }) : super(key: key);

  final String title;
  final List<TaskComposite> tasks;

  final void Function(TaskComposite task) onCheck;
  final void Function(TaskComposite task) onUnCheck;

  @override
  Widget build(BuildContext context) {
    // : Padding above title (+ whole content)
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.title,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 8),
          Column(
            children: List.generate(
              this.tasks.length,
              // TODO [UX] add switch for multi task widget
              (index) {
                TaskComposite _task = this.tasks.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SingleTaskWidget(
                    taskData: _task,
                    onCheck: () => this.onCheck?.call(_task),
                    onUnCheck: () => this.onUnCheck?.call(_task),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
