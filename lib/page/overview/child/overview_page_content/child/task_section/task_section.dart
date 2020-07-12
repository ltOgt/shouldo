import 'package:flutter/material.dart';
import 'package:shouldo/data/composite/task_composite.dart';

import 'child/single_task_widget.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({
    Key key,
    @required this.title,
    @required this.tasks,
  }) : super(key: key);

  final String title;
  final List<TaskComposite> tasks;

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
              // TODO add switch for multi task widget
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SingleTaskWidget(
                  taskData: this.tasks.elementAt(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
