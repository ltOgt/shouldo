// package
import 'package:moor_flutter/moor_flutter.dart';
// _ table
import 'package:shouldo/data/db/table/task_detail_table.dart';
import 'package:shouldo/data/db/table/task_table.dart';
// _ dao
import 'package:shouldo/page/overview/data/overview_dao.dart';

// target
part 'moor_db.g.dart';

const String DATABASE_PATH = "souldo.sqlite";

@UseMoor(tables: [
  TaskTable,
  TaskDetailTable,
], daos: [
  OverviewDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: DATABASE_PATH,
            logStatements: true, // TODO remove, only for debugging
          ),
        ) {
    this.customStatement("PRAGMA foreign_keys = ON");
  }

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration =>
  //     MigrationStrategy(beforeOpen: (openingDetails) async {
  //       if (true) {
  //         final m = this.createMigrator(); // changed to this
  //         for (final table in allTables) {
  //           await m.deleteTable(table.actualTableName);
  //           await m.createTable(table);
  //         }
  //       }
  //     });
}
