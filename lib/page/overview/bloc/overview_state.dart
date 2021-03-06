part of 'overview_bloc.dart';

/// Available States:
/// [OvStateInitial], [OvStateLoaded],
@immutable
abstract class OverviewState {}

class OvStateInitial extends OverviewState {}

class OvStateLoaded extends OverviewState {
  /// The date that is displayed by the page
  final DateTime focusedDate;

  /// Tasks whose completion date is the currently displayed date
  final List<TaskComposite> completedTasks;

  /// Tasks whose startDate is today or in the past and who have not been completed
  /// (Includes tasks whose deadline has passed)
  // [TODO] potentially only fill for focusedDate==TODAY
  final List<TaskComposite> activeTasks;

  /// Tasks that do not have a startDate nor a dueDate assigned to them and have not been completed
  // [TODO] potentially only fill for focusedDate==TODAY
  final List<TaskComposite> stagedTasks;

  /// To control and react to page transitions
  final PageController pageController;

  // TODO maybe rename to days in past, could also replace focused date with getter based on daysInPast
  // TODO postpone until tackled date change during app use
  final int page;

  final Ordering ordering;

  OvStateLoaded copyWith({
    DateTime focusedDate,
    List<TaskComposite> completedTasks,
    List<TaskComposite> activeTasks,
    List<TaskComposite> stagedTasks,
    PageController pageController,
    int page,
    Ordering ordering,
  }) {
    return OvStateLoaded(
      focusedDate: focusedDate ?? this.focusedDate,
      completedTasks: completedTasks ?? this.completedTasks,
      activeTasks: activeTasks ?? this.activeTasks,
      stagedTasks: stagedTasks ?? this.stagedTasks,
      pageController: pageController ?? this.pageController,
      page: page ?? this.page,
      ordering: ordering ?? this.ordering,
    );
  }

  OvStateLoaded({
    @required this.focusedDate,
    this.completedTasks = const [],
    this.activeTasks = const [],
    this.stagedTasks = const [],
    @required this.pageController,
    @required this.page,
    @required this.ordering,
  })  :
        // TODO [TEST] these are just to cover basic premisses; date day switch might cause problems too
        assert(
          completedTasks.fold(
              true,
              (aggr, element) =>
                  aggr &&
                  element.completionDate != null &&
                  element.completionDate.day == DateTime.now().day),
          "OwStateLoaded.completedTasks must be completed today.",
        ),
        assert(
          activeTasks.fold(
            true,
            (aggr, element) =>
                aggr && !(element.startDate == null && element.dueDate == null),
          ),
          "OwStateLoaded.activeTasks must have a start and-or due date.",
        ),
        assert(
          activeTasks.fold(
            true,
            (aggr, element) =>
                aggr &&
                (element.startDate == null ||
                    !element.startDate.isAfter(DateTime.now())),
          ),
          "OwStateLoaded.activeTasks must start before NOW or have no start date.",
        ),
        // : Due date can actually be in the past; no problem
        // assert(
        //   activeTasks.fold(
        //     true,
        //     (aggr, element) =>
        //         aggr &&
        //         (element.dueDate == null ||
        //             !element.dueDate.isAfter(DateTime.now())),
        //   ),
        //   "OwStateLoaded.activeTasks must end after NOW or have no due date.",
        // ),
        assert(
          stagedTasks.fold(
            true,
            (aggr, element) =>
                aggr && (element.startDate == null && element.dueDate == null),
          ),
          "OwStateLoaded.stagedTasks can neither have a start nor a due date.",
        );
  // TODO [?] what about completion? Can staged tasks be completed{/completable; maybe yes => directly into completed}

}
