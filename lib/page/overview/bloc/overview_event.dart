part of 'overview_bloc.dart';

/// Available Events:
/// [OvEventLoadForPage], [OvEventToggleSorting], [OvEventAddTask],
/// [OvEventToggleTaskCompletion], [OvEventSetTaskDueDate], [OvEventStartTask]
@immutable
abstract class OverviewEvent {}

class OvEventLoadForPage implements OverviewEvent {
  /// The page for which data should be loaded
  final int page;

  OvEventLoadForPage({
    @required this.page,
  });
}

class OvEventToggleSorting implements OverviewEvent {}

class OvEventAddTask implements OverviewEvent {
  final DateTime dueDate;
  final DateTime startDate;
  final String title;

  OvEventAddTask({
    @required this.title,
    this.dueDate,
    this.startDate,
  });
}

class OvEventToggleTaskCompletion implements OverviewEvent {
  final TaskComposite task;
  final bool doComplete;

  OvEventToggleTaskCompletion({
    @required this.task,
    @required this.doComplete,
  });
}

class OvEventSetTaskDueDate implements OverviewEvent {
  final TaskComposite task;
  final DateTime dueDate;

  OvEventSetTaskDueDate({
    @required this.task,
    @required this.dueDate,
  });
}

class OvEventStartTask implements OverviewEvent {
  final TaskComposite task;

  OvEventStartTask({
    @required this.task,
  });
}
