// packages
import 'package:moor_flutter/moor_flutter.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';
import 'package:shouldo/data/db/moor_db.dart';
import 'package:shouldo/data/db/table/task_table.dart';

part 'overview_dao.g.dart';

@UseDao(tables: [
  TaskTable,
])
class OverviewDao extends DatabaseAccessor<AppDatabase>
    with _$OverviewDaoMixin {
  final AppDatabase db;

  OverviewDao(this.db) : super(db);

  Future<List<TaskComposite>> getGetCompletedForDate({DateTime date}) async {
    return [
      TaskComposite(
        id: 5,
        dueDate: DateTime.now().add(Duration(days: 4)),
        startDate: DateTime.now().subtract(Duration(days: 4)),
        completionDate: DateTime.now(),
        title: "Uncompleted Task 4-4 (B-T)",
      ),
    ];
  }

  Future<List<TaskComposite>> getGetActiveForDate({DateTime date}) async {
    return [
      TaskComposite(
        id: 0,
        dueDate: DateTime.now().add(Duration(days: 3)),
        startDate: DateTime.now().subtract(Duration(days: 3)),
        completionDate: null,
        title: "Uncompleted Task 3-3 (B-T)",
      ),
      TaskComposite(
        id: 1,
        dueDate: DateTime.now().add(Duration(days: 2)),
        startDate: DateTime.now().subtract(Duration(days: 2)),
        completionDate: null,
        title: "Uncompleted Task 2-2 (M-M)",
      ),
      TaskComposite(
        id: 2,
        dueDate: DateTime.now().add(Duration(days: 1)),
        startDate: DateTime.now().subtract(Duration(days: 1)),
        completionDate: null,
        title: "Uncompleted Task 1-1 (T-B)",
      ),
    ];
  }

  Future<List<TaskComposite>> getGetStagedForDate({DateTime date}) async {
    return [
      TaskComposite(
        id: 4,
        dueDate: null,
        startDate: null,
        completionDate: null,
        title: "Staged Task",
      ),
    ];
  }
}
