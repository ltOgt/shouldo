import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("TaskEntity")
class TaskTable extends Table {
  // i ().call() ^= ()()
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  // TODO should be DateTime.now() per default, but can only be constant
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get completionDate => dateTime().nullable()();
  // TODO connector table for tags
}
