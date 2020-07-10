// framework
import 'dart:async';
import 'package:meta/meta.dart';
// package
import 'package:bloc/bloc.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';
import 'package:shouldo/page/overview/data/overview_dao.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  OverviewDao dao;

  OverviewBloc({
    @required this.dao,
  }) : super(OvStateInitial());

  @override
  Stream<OverviewState> mapEventToState(
    OverviewEvent event,
  ) async* {
    if (event is OvEventLoadForDate) {
      // TODO replace Mock Data
      yield OvStateLoaded(
        focusedDate: event.focusedDate,
        completedTasks:
            await dao.getGetCompletedForDate(date: event.focusedDate),
        activeTasks: await dao.getGetActiveForDate(date: event.focusedDate),
        stagedTasks: await dao.getGetStagedForDate(date: event.focusedDate),
      );
    }
    // : Seal
    else {
      throw ("OverviewBloc; Unmapped Event: $event");
    }
  }
}
