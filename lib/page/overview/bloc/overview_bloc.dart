// framework
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
// package
import 'package:bloc/bloc.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';
import 'package:shouldo/data/enum/ordering.dart';
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

      yield OvStateLoaded(
        focusedDate: _date,
        page: event.page,
        pageController: this.pageController,
        completedTasks: await dao.getGetCompletedForDate(date: _date),
        activeTasks: await dao.getGetActiveForDate(date: _date),
        stagedTasks: await dao.getGetStagedForDate(date: _date),
        ordering: Ordering.values[0],
      );
    }
    // : Handle all other events
    else {
      OverviewState previousState = this.state;
      // : Assumption is that previous state is loaded
      if (previousState is OvStateLoaded) {
        // : toggle only expansion
        if (event is OvEventToggleSorting) {
          Ordering _ordering = previousState.ordering.next();
          yield previousState.copyWith(
            activeTasks: await dao.getGetActiveForDate(
              date: previousState.focusedDate,
              ordering: _ordering,
            ),
            ordering: _ordering,
          );
        }
        // : create a new task
        else if (event is OvEventAddTask) {
          await dao.createTask(
            title: event.title,
            dueDate: event.dueDate,
            startDate: event.startDate,
          );
          yield previousState.copyWith(
            activeTasks: await dao.getGetActiveForDate(
              date: previousState.focusedDate,
              ordering: previousState.ordering,
            ),
            stagedTasks:
                await dao.getGetStagedForDate(date: previousState.focusedDate),
          );
        }
        // : complete an existing task
        else if (event is OvEventToggleTaskCompletion) {
          await dao.setTaskCompletion(
            doComplete: event.doComplete,
            task: event.task,
          );
          yield previousState.copyWith(
            completedTasks: await dao.getGetCompletedForDate(
                date: previousState.focusedDate),
            activeTasks: await dao.getGetActiveForDate(
              date: previousState.focusedDate,
              ordering: previousState.ordering,
            ),
            stagedTasks:
                await dao.getGetStagedForDate(date: previousState.focusedDate),
          );
        }
        // : start a staged task
        else if (event is OvEventStartTask) {
          await dao.startTask(
            task: event.task,
          );
          yield previousState.copyWith(
            activeTasks: await dao.getGetActiveForDate(
              date: previousState.focusedDate,
              ordering: previousState.ordering,
            ),
            stagedTasks:
                await dao.getGetStagedForDate(date: previousState.focusedDate),
          );
        }
        // : start a staged task
        else if (event is OvEventSetTaskDueDate) {
          await dao.setDueDateForTaskAndStartIfNotActive(
            task: event.task,
            dueDate: event.dueDate,
          );
          yield previousState.copyWith(
            activeTasks: await dao.getGetActiveForDate(
              date: previousState.focusedDate,
              ordering: previousState.ordering,
            ),
            stagedTasks:
                await dao.getGetStagedForDate(date: previousState.focusedDate),
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
