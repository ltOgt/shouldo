// framework
import 'dart:async';
// package
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shouldo/data/composite/task_composite.dart';

// project
part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  OverviewBloc() : super(OvStateInitial());

  @override
  Stream<OverviewState> mapEventToState(
    OverviewEvent event,
  ) async* {
    if (event is OvEventLoadForDate) {
      // TODO replace Mock Data
      yield OvStateLoaded(
        focusedDate: event.focusedDate,
        completedTasks: [
          TaskComposite(
            id: 5,
            dueDate: DateTime.now().add(Duration(days: 4)),
            startDate: DateTime.now().subtract(Duration(days: 4)),
            completionDate: DateTime.now(),
            title: "Uncompleted Task 3-3 (B-T)",
          ),
        ],
        activeTasks: [
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
            title: "Uncompleted Task 2-2 (T-B)",
          ),
        ],
        stagedTasks: [
          TaskComposite(
            id: 4,
            dueDate: null,
            startDate: null,
            completionDate: null,
            title: "Staged Task",
          ),
        ],
      );
    }
    // : Seal
    else {
      throw ("OverviewBloc; Unmapped Event: $event");
    }
  }
}
