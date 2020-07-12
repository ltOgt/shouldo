// framework
import 'package:flutter/foundation.dart';
import 'package:shouldo/common/helper/date_helper.dart';
// project

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

  int get daysUntilDue => DateHelper.daysBetween(this.dueDate, DateTime.now());
  int get daysSinceStart =>
      DateHelper.daysBetween(DateTime.now(), this.dueDate);
}
