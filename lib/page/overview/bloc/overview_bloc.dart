// framework
import 'dart:async';
import 'package:flutter/material.dart';
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
  PageController pageController;

  void pageTransitionListener() {
    OverviewState previousState = this.state;
    double currentPage = this.pageController.page;

    if (previousState is OvStateLoaded) {
      if ((currentPage - previousState.page).abs() > 0.5)
        this.add(OvEventLoadForPage(
          page: currentPage.round(),
        ));
    }
  }

  OverviewBloc({
    @required this.dao,
  }) : super(OvStateInitial()) {
    this.pageController = PageController();
    this.pageController.addListener(this.pageTransitionListener);
  }

  @override
  Future<void> close() {
    this.pageController.removeListener(this.pageTransitionListener);
    this.pageController.dispose();
    return super.close();
  }

  @override
  Stream<OverviewState> mapEventToState(
    OverviewEvent event,
  ) async* {
    // : Handle initialization for current page
    if (event is OvEventLoadForPage) {
      DateTime _date = DateTime.now().subtract(Duration(days: event.page));
      bool _isAdderAreaExpanded = false;

      // : should still keep track of whether the adder area was expanded; creation page independant
      OverviewState previousState = this.state;
      if (previousState is OvStateLoaded) {
        _isAdderAreaExpanded = previousState.isAdderAreaExpanded;
      }

      yield OvStateLoaded(
        focusedDate: _date,
        page: event.page,
        pageController: this.pageController,
        completedTasks: await dao.getGetCompletedForDate(date: _date),
        activeTasks: await dao.getGetActiveForDate(date: _date),
        stagedTasks: await dao.getGetStagedForDate(date: _date),
        isAdderAreaExpanded: _isAdderAreaExpanded,
      );
    }
    // : Handle all other events
    else {
      OverviewState previousState = this.state;
      // : Assumption is that previous state is loaded
      if (previousState is OvStateLoaded) {
        // TODO
        if (event is OvEventToggleAdderAreaExpansion) {
          yield previousState.copyWith(
            isAdderAreaExpanded: event.isExpanded,
          );
        }
        // : Seal
        else {
          throw ("OverviewBloc; Unmapped Event: $event");
        }
      } else {
        throw ("OverviewBlox; Assumed Page loaded");
      }
    }
  }
}
