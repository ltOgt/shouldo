import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("TaskEntity")
class TaskTable extends Table {
  // i ().call() ^= ()()
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get dueDate => dateTime()();
  // TODO should be DateTime.now() per default, but can only be constant
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get completionDate => dateTime()();
  // TODO connector table for tags
}
