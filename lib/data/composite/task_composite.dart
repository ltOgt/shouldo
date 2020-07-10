import 'package:flutter/foundation.dart';

class TaskComposite {
  final int id;
  final DateTime dueDate;
  final DateTime startDate;
  final DateTime completionDate;
  final String title;
  // TODO [PROPOSAL]
  // final List<fkTagId> tags;

  TaskComposite({
    @required this.id,
    @required this.dueDate,
    @required this.startDate,
    @required this.completionDate,
    @required this.title,
  });

  int get daysUntilDue => this.dueDate?.difference(DateTime.now())?.inDays;
  int get daysSinceStart => this.startDate != null
      ? DateTime.now().difference(this.startDate)?.inDays
      : null;

  // TODO [DB] { x Moor Setup }
  //factory TaskComposite.fromEntity(TaskEntity entity) {}

  // TODO [DB] { x Moor Setup }
  // TaskTableCompanion toCompanion() {}

}
