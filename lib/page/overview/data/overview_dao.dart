// packages
import 'package:moor_flutter/moor_flutter.dart';
import 'package:shouldo/common/helper/date_helper.dart';
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

  Future<List<TaskComposite>> getGetCompletedForDate({
    @required DateTime date,
  }) async {
    DateTime _startOfToday = DateHelper.withoutTime(date);
    return (select(taskTable)
          ..where((tbl) =>
              isNotNull(tbl.completionDate) &
              // : is today
              tbl.completionDate
                  .isSmallerThanValue(_startOfToday.add(Duration(days: 1))) &
              tbl.completionDate.isBiggerOrEqualValue(_startOfToday)))
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

  Future<List<TaskComposite>> getGetActiveForDate({
    @required DateTime date,
    Ordering ordering = Ordering.DUE_DATE_CLOSEST_FIRST,
  }) async {
    // : Genereate Order Clause based on passed ordering
    OrderingTerm Function($TaskTableTable) orderClause;
    if (ordering == Ordering.DUE_DATE_CLOSEST_FIRST) {
      orderClause = (tbl) => OrderingTerm(
            expression: tbl.dueDate,
            mode: OrderingMode.asc,
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

  Future<List<TaskComposite>> getGetStagedForDate({
    @required DateTime date,
  }) async {
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

  Future<int> createTask({
    @required String title,
    DateTime dueDate,
    DateTime startDate,
  }) {
    return into(taskTable).insert(TaskTableCompanion(
      title: Value(title ?? "No Title"), // TODO this should never occur
      dueDate: dueDate == null ? Value.absent() : Value(dueDate),
      startDate: startDate == null ? Value.absent() : Value(startDate),
    ));
  }

  Future<bool> setTaskCompletion({
    @required bool doComplete,
    @required TaskComposite task,
  }) {
    return update(taskTable).replace(TaskTableCompanion(
      id: Value(task.id),
      title: Value(task.title),
      dueDate: Value(task.dueDate),
      startDate: Value(task.startDate),
      completionDate: doComplete ? Value(DateTime.now()) : Value(null),
    ));
  }

  Future<bool> startTask({
    @required TaskComposite task,
  }) {
    return update(taskTable).replace(TaskTableCompanion(
      id: Value(task.id),
      title: Value(task.title),
      dueDate: Value(task.dueDate),
      startDate: Value(DateTime.now()),
      completionDate: Value(task.completionDate),
    ));
  }

  Future<bool> setDueDateForTaskAndStartIfNotActive({
    @required TaskComposite task,
    @required DateTime dueDate,
  }) {
    return update(taskTable).replace(TaskTableCompanion(
      id: Value(task.id),
      title: Value(task.title),
      dueDate: Value(dueDate),
      startDate: Value(task.isActive ? task.startDate : DateTime.now()),
      completionDate: Value(task.completionDate),
    ));
  }
}
