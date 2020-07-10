import 'package:moor_flutter/moor_flutter.dart';

@DataClassName("TaskDetailEntity")
class TaskDetailTable extends Table {
  // i ().call() ^= ()()
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fkTaskId =>
      integer().customConstraint("REFERENCES task_table(id)")();
  TextColumn get title => text()();
  // : is null if not yet completed
  DateTimeColumn get completionDate => dateTime()();
}
