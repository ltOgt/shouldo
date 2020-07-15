part of 'overview_bloc.dart';

/// Available Events:
/// [OvEventLoadForPage], [OvEventToggleAdderAreaExpansion], [OvEventAddTask],
@immutable
abstract class OverviewEvent {}

class OvEventLoadForPage implements OverviewEvent {
  /// The page for which data should be loaded
  final int page;

  OvEventLoadForPage({
    @required this.page,
  });
}

class OvEventToggleAdderAreaExpansion implements OverviewEvent {
  final bool isExpanded;

  OvEventToggleAdderAreaExpansion({
    @required this.isExpanded,
  });
}

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
