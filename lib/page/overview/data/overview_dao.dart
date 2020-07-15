// packages
import 'package:moor_flutter/moor_flutter.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';
import 'package:shouldo/data/db/moor_db.dart';
import 'package:shouldo/data/db/table/task_table.dart';
import 'package:shouldo/data/enum/ordering.dart';

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
        id: 0,
        dueDate: DateTime.now().add(Duration(days: 3)),
        startDate: DateTime.now().subtract(Duration(days: 3)),
        completionDate: DateTime.now(),
        title: "Completed Task 3-3 (B-T)",
      ),
      TaskComposite(
        id: 1,
        dueDate: DateTime.now().add(Duration(days: 2)),
        startDate: DateTime.now().subtract(Duration(days: 2)),
        completionDate: DateTime.now(),
        title: "Completed Task 2-2 (M-M)",
      ),
      TaskComposite(
        id: 2,
        dueDate: DateTime.now().add(Duration(days: 1)),
        startDate: DateTime.now().subtract(Duration(days: 1)),
        completionDate: DateTime.now(),
        title: "Completed Task 1-1 (T-B)",
      ),
    ];
  }

  Future<List<TaskComposite>> getGetActiveForDate({
    @required DateTime date,
    Ordering ordering = Ordering.DUE_DATE_CLOSEST_FIRST,
  }) async {
    // : Genereate Order Clause based on passed ordering
    OrderingTerm Function($TaskTableTable) orderClause;
    if (ordering == Ordering.DUE_DATE_CLOSEST_FIRST) {
      orderClause = (tbl) => OrderingTerm(
            expression: tbl.startDate,
            mode: OrderingMode.desc,
          );
    } else if (ordering == Ordering.START_DATE_OLDEST_FIRST) {
      orderClause = (tbl) => OrderingTerm(
            expression: tbl.startDate,
            mode: OrderingMode.desc,
          );
    } else {
      throw ("OverviewDao; Unmapped Ordering: <$ordering>");
    }

    // : Executre query with ordering
    return (select(taskTable)
          ..where(
            (tbl) =>
                tbl.startDate.isSmallerOrEqualValue(date) &
                isNull(tbl.completionDate),
          )
          ..orderBy(
            [
              orderClause,
            ],
          ))
        .map(
          (TaskEntity e) => TaskComposite(
            id: e.id,
            dueDate: e.dueDate,
            startDate: e.startDate,
            completionDate: e.completionDate,
            title: e.title,
          ),
        )
        .get();
  }

  Future<List<TaskComposite>> getGetStagedForDate({DateTime date}) async {
    return (select(taskTable)
          ..where(
            (tbl) =>
                isNull(tbl.startDate) &
                isNull(tbl.dueDate) &
                isNull(tbl.completionDate),
          ))
        .map(
          (TaskEntity e) => TaskComposite(
            id: e.id,
            dueDate: e.dueDate,
            startDate: e.startDate,
            completionDate: e.completionDate,
            title: e.title,
          ),
        )
        .get();
  }

  Future<int> createTask({String title, DateTime dueDate, DateTime startDate}) {
    return into(taskTable).insert(TaskTableCompanion(
      title: Value(title ?? "No Title"), // TODO this should never occur
      dueDate: dueDate == null ? Value.absent() : Value(dueDate),
      startDate: startDate == null ? Value.absent() : Value(startDate),
    ));
  }
}
