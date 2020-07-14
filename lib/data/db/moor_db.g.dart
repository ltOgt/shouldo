// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TaskEntity extends DataClass implements Insertable<TaskEntity> {
  final int id;
  final String title;
  final DateTime dueDate;
  final DateTime startDate;
  final DateTime completionDate;
  TaskEntity(
      {@required this.id,
      @required this.title,
      this.dueDate,
      this.startDate,
      this.completionDate});
  factory TaskEntity.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TaskEntity(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      dueDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}due_date']),
      startDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_date']),
      completionDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}completion_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || completionDate != null) {
      map['completion_date'] = Variable<DateTime>(completionDate);
    }
    return map;
  }

  TaskTableCompanion toCompanion(bool nullToAbsent) {
    return TaskTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      completionDate: completionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completionDate),
    );
  }

  factory TaskEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TaskEntity(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      completionDate: serializer.fromJson<DateTime>(json['completionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'startDate': serializer.toJson<DateTime>(startDate),
      'completionDate': serializer.toJson<DateTime>(completionDate),
    };
  }

  TaskEntity copyWith(
          {int id,
          String title,
          DateTime dueDate,
          DateTime startDate,
          DateTime completionDate}) =>
      TaskEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        dueDate: dueDate ?? this.dueDate,
        startDate: startDate ?? this.startDate,
        completionDate: completionDate ?? this.completionDate,
      );
  @override
  String toString() {
    return (StringBuffer('TaskEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(dueDate.hashCode,
              $mrjc(startDate.hashCode, completionDate.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TaskEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.dueDate == this.dueDate &&
          other.startDate == this.startDate &&
          other.completionDate == this.completionDate);
}

class TaskTableCompanion extends UpdateCompanion<TaskEntity> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> dueDate;
  final Value<DateTime> startDate;
  final Value<DateTime> completionDate;
  const TaskTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
  });
  TaskTableCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    this.dueDate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TaskEntity> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<DateTime> dueDate,
    Expression<DateTime> startDate,
    Expression<DateTime> completionDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (dueDate != null) 'due_date': dueDate,
      if (startDate != null) 'start_date': startDate,
      if (completionDate != null) 'completion_date': completionDate,
    });
  }

  TaskTableCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<DateTime> dueDate,
      Value<DateTime> startDate,
      Value<DateTime> completionDate}) {
    return TaskTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      startDate: startDate ?? this.startDate,
      completionDate: completionDate ?? this.completionDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (completionDate.present) {
      map['completion_date'] = Variable<DateTime>(completionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('dueDate: $dueDate, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate')
          ..write(')'))
        .toString();
  }
}

class $TaskTableTable extends TaskTable
    with TableInfo<$TaskTableTable, TaskEntity> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaskTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dueDateMeta = const VerificationMeta('dueDate');
  GeneratedDateTimeColumn _dueDate;
  @override
  GeneratedDateTimeColumn get dueDate => _dueDate ??= _constructDueDate();
  GeneratedDateTimeColumn _constructDueDate() {
    return GeneratedDateTimeColumn(
      'due_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _startDateMeta = const VerificationMeta('startDate');
  GeneratedDateTimeColumn _startDate;
  @override
  GeneratedDateTimeColumn get startDate => _startDate ??= _constructStartDate();
  GeneratedDateTimeColumn _constructStartDate() {
    return GeneratedDateTimeColumn(
      'start_date',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completionDateMeta =
      const VerificationMeta('completionDate');
  GeneratedDateTimeColumn _completionDate;
  @override
  GeneratedDateTimeColumn get completionDate =>
      _completionDate ??= _constructCompletionDate();
  GeneratedDateTimeColumn _constructCompletionDate() {
    return GeneratedDateTimeColumn(
      'completion_date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, dueDate, startDate, completionDate];
  @override
  $TaskTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'task_table';
  @override
  final String actualTableName = 'task_table';
  @override
  VerificationContext validateIntegrity(Insertable<TaskEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date'], _dueDateMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date'], _startDateMeta));
    }
    if (data.containsKey('completion_date')) {
      context.handle(
          _completionDateMeta,
          completionDate.isAcceptableOrUnknown(
              data['completion_date'], _completionDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskEntity map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskEntity.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TaskTableTable createAlias(String alias) {
    return $TaskTableTable(_db, alias);
  }
}

class TaskDetailEntity extends DataClass
    implements Insertable<TaskDetailEntity> {
  final int id;
  final int fkTaskId;
  final String title;
  final DateTime completionDate;
  TaskDetailEntity(
      {@required this.id,
      @required this.fkTaskId,
      @required this.title,
      @required this.completionDate});
  factory TaskDetailEntity.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return TaskDetailEntity(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      fkTaskId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}fk_task_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      completionDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}completion_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || fkTaskId != null) {
      map['fk_task_id'] = Variable<int>(fkTaskId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || completionDate != null) {
      map['completion_date'] = Variable<DateTime>(completionDate);
    }
    return map;
  }

  TaskDetailTableCompanion toCompanion(bool nullToAbsent) {
    return TaskDetailTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      fkTaskId: fkTaskId == null && nullToAbsent
          ? const Value.absent()
          : Value(fkTaskId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      completionDate: completionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completionDate),
    );
  }

  factory TaskDetailEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TaskDetailEntity(
      id: serializer.fromJson<int>(json['id']),
      fkTaskId: serializer.fromJson<int>(json['fkTaskId']),
      title: serializer.fromJson<String>(json['title']),
      completionDate: serializer.fromJson<DateTime>(json['completionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fkTaskId': serializer.toJson<int>(fkTaskId),
      'title': serializer.toJson<String>(title),
      'completionDate': serializer.toJson<DateTime>(completionDate),
    };
  }

  TaskDetailEntity copyWith(
          {int id, int fkTaskId, String title, DateTime completionDate}) =>
      TaskDetailEntity(
        id: id ?? this.id,
        fkTaskId: fkTaskId ?? this.fkTaskId,
        title: title ?? this.title,
        completionDate: completionDate ?? this.completionDate,
      );
  @override
  String toString() {
    return (StringBuffer('TaskDetailEntity(')
          ..write('id: $id, ')
          ..write('fkTaskId: $fkTaskId, ')
          ..write('title: $title, ')
          ..write('completionDate: $completionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          fkTaskId.hashCode, $mrjc(title.hashCode, completionDate.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TaskDetailEntity &&
          other.id == this.id &&
          other.fkTaskId == this.fkTaskId &&
          other.title == this.title &&
          other.completionDate == this.completionDate);
}

class TaskDetailTableCompanion extends UpdateCompanion<TaskDetailEntity> {
  final Value<int> id;
  final Value<int> fkTaskId;
  final Value<String> title;
  final Value<DateTime> completionDate;
  const TaskDetailTableCompanion({
    this.id = const Value.absent(),
    this.fkTaskId = const Value.absent(),
    this.title = const Value.absent(),
    this.completionDate = const Value.absent(),
  });
  TaskDetailTableCompanion.insert({
    this.id = const Value.absent(),
    @required int fkTaskId,
    @required String title,
    @required DateTime completionDate,
  })  : fkTaskId = Value(fkTaskId),
        title = Value(title),
        completionDate = Value(completionDate);
  static Insertable<TaskDetailEntity> custom({
    Expression<int> id,
    Expression<int> fkTaskId,
    Expression<String> title,
    Expression<DateTime> completionDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fkTaskId != null) 'fk_task_id': fkTaskId,
      if (title != null) 'title': title,
      if (completionDate != null) 'completion_date': completionDate,
    });
  }

  TaskDetailTableCompanion copyWith(
      {Value<int> id,
      Value<int> fkTaskId,
      Value<String> title,
      Value<DateTime> completionDate}) {
    return TaskDetailTableCompanion(
      id: id ?? this.id,
      fkTaskId: fkTaskId ?? this.fkTaskId,
      title: title ?? this.title,
      completionDate: completionDate ?? this.completionDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fkTaskId.present) {
      map['fk_task_id'] = Variable<int>(fkTaskId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (completionDate.present) {
      map['completion_date'] = Variable<DateTime>(completionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskDetailTableCompanion(')
          ..write('id: $id, ')
          ..write('fkTaskId: $fkTaskId, ')
          ..write('title: $title, ')
          ..write('completionDate: $completionDate')
          ..write(')'))
        .toString();
  }
}

class $TaskDetailTableTable extends TaskDetailTable
    with TableInfo<$TaskDetailTableTable, TaskDetailEntity> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaskDetailTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _fkTaskIdMeta = const VerificationMeta('fkTaskId');
  GeneratedIntColumn _fkTaskId;
  @override
  GeneratedIntColumn get fkTaskId => _fkTaskId ??= _constructFkTaskId();
  GeneratedIntColumn _constructFkTaskId() {
    return GeneratedIntColumn('fk_task_id', $tableName, false,
        $customConstraints: 'REFERENCES task_table(id)');
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completionDateMeta =
      const VerificationMeta('completionDate');
  GeneratedDateTimeColumn _completionDate;
  @override
  GeneratedDateTimeColumn get completionDate =>
      _completionDate ??= _constructCompletionDate();
  GeneratedDateTimeColumn _constructCompletionDate() {
    return GeneratedDateTimeColumn(
      'completion_date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, fkTaskId, title, completionDate];
  @override
  $TaskDetailTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'task_detail_table';
  @override
  final String actualTableName = 'task_detail_table';
  @override
  VerificationContext validateIntegrity(Insertable<TaskDetailEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('fk_task_id')) {
      context.handle(_fkTaskIdMeta,
          fkTaskId.isAcceptableOrUnknown(data['fk_task_id'], _fkTaskIdMeta));
    } else if (isInserting) {
      context.missing(_fkTaskIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completion_date')) {
      context.handle(
          _completionDateMeta,
          completionDate.isAcceptableOrUnknown(
              data['completion_date'], _completionDateMeta));
    } else if (isInserting) {
      context.missing(_completionDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskDetailEntity map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TaskDetailEntity.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TaskDetailTableTable createAlias(String alias) {
    return $TaskDetailTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TaskTableTable _taskTable;
  $TaskTableTable get taskTable => _taskTable ??= $TaskTableTable(this);
  $TaskDetailTableTable _taskDetailTable;
  $TaskDetailTableTable get taskDetailTable =>
      _taskDetailTable ??= $TaskDetailTableTable(this);
  OverviewDao _overviewDao;
  OverviewDao get overviewDao =>
      _overviewDao ??= OverviewDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [taskTable, taskDetailTable];
}
