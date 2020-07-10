part of 'overview_bloc.dart';

/// Available Events:
/// [OvEventLoadForDate],
@immutable
abstract class OverviewEvent {}

class OvEventLoadForDate implements OverviewEvent {
  /// The date for which the page should be populated
  final DateTime focusedDate;

  OvEventLoadForDate({
    @required this.focusedDate,
  });
}
