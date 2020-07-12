part of 'overview_bloc.dart';

/// Available Events:
/// [OvEventLoadForPage], [OvEventToggleAdderAreaExpansion],
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
