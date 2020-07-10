// framework
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// package
import 'package:flutter_bloc/flutter_bloc.dart';
// project
import 'package:shouldo/data/db/moor_db.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';

import 'child/overview_bottom_bar_widget.dart';
import 'child/overview_header_widget.dart';
import 'child/overview_page_content_loaded_widget.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({
    Key key,
    @required this.daysInPast,
    @required this.goToFirstPage,
  }) : super(key: key);

  final int daysInPast;
  final VoidCallback goToFirstPage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OverviewBloc(
        dao: RepositoryProvider.of<AppDatabase>(context).overviewDao,
      ),
      child: BlocBuilder<OverviewBloc, OverviewState>(
        builder: (context, state) {
          // : Initial Entry
          if (state is OvStateInitial) {
            BlocProvider.of<OverviewBloc>(context).add(
              OvEventLoadForPage(
                page: 0,
              ),
            );
            // TODO [UX] actual loading page
            return Center(child: CircularProgressIndicator());
          }
          // : Data Loaded
          else if (state is OvStateLoaded) {
            bool _TEMP_isEnterMode = false;

            return Column(
              children: <Widget>[
                // : HEADER ===========================
                OverviewHeaderWidget(
                  focusedDate: state.focusedDate,
                  goToFirstPage: () => state.pageController.animateToPage(
                    0,
                    // :animation takes longer the further away, but never longer than a second
                    duration:
                        Duration(milliseconds: min(state.page * 100, 1000)),
                    curve: Curves.easeInOut,
                  ),
                  daysInPast: 0,
                ),
                // : PAGE CONTENT; incl BOTTOM BAR ====
                Flexible(
                  child: Stack(
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        // : Used to react to page changes and to navigate
                        controller: state.pageController,
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemBuilder: (_, __) =>
                            OverviewPageContentLoadedWidget(state: state),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: OverviewBottomBarWidget(),
                      ),
                    ],
                  ),
                ),
                // : BOTTOM BAR EXTENSION AREA =======
                if (_TEMP_isEnterMode) // TODO animate in
                  ...[
                  Container(
                    color: Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextField(),
                        Container(
                          color: Colors.pink,
                          child: Text("Start Now"),
                        ),
                        Container(
                          color: Colors.pink,
                          child: Text("Deadline"),
                        ),
                        Container(
                          color: Colors.pink,
                          child: Text("Add Child"),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          }
          // : Seal
          else {
            throw ("OverviewPage; Unmapped State: $state");
          }
        },
      ),
    );

    /*
    return Column(
      children: <Widget>[
        OverviewHeaderWidget(
          focusedDate: _focusedDate,
          goToFirstPage: goToFirstPage,
          daysInPast: daysInPast,
        ),
        Flexible(
          child: Container(
            child: BlocProvider(
              create: (BuildContext context) => OverviewBloc(
                dao: RepositoryProvider.of<AppDatabase>(context).overviewDao,
              ),
              child: _OverViewPageContent(focusedDate: _focusedDate),
            ),
          ),
        ),
      ],
    );
    */
  }
}

/*
class _OverViewPageContent extends StatelessWidget {
  const _OverViewPageContent({
    Key key,
    @required this.focusedDate,
  }) : super(key: key);

  final DateTime focusedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverviewBloc, OverviewState>(
      builder: (context, state) {
        // : TODO add description
        if (state is OvStateInitial) {
          BlocProvider.of<OverviewBloc>(context).add(OvEventLoadForPage(
            page: this.focusedDate,
          ));
          // TODO [UX] actual loading page
          return Center(child: CircularProgressIndicator());
        } else if (state is OvStateLoaded) {
          return Container(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    if (state.completedTasks.length > 0)
                      TaskTypeColumn(
                        taskList: state.completedTasks,
                        title: "Completed",
                      ),
                    if (state.activeTasks.length > 0)
                      TaskTypeColumn(
                        taskList: state.activeTasks,
                        title: "Active",
                      ),
                    if (state.stagedTasks.length > 0)
                      TaskTypeColumn(
                        taskList: state.stagedTasks,
                        title: "Staged",
                      ),
                  ],
                ),
                SortButton(),
                AddButton(),
              ],
            ),
          );
        }
        // : Seal
        else {
          throw ("OverviewPage; Unmapped State: $state");
        }
      },
    );
  }
}

class TaskTypeColumn extends StatelessWidget {
  const TaskTypeColumn({
    Key key,
    @required this.taskList,
    @required this.title,
  }) : super(key: key);

  final List<TaskComposite> taskList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ] +
            List.generate(
              taskList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TaskRow(
                  task: taskList.elementAt(index),
                ),
              ),
            ),
      ),
    );
  }
}

class TaskRow extends StatelessWidget {
  const TaskRow({
    Key key,
    @required this.task,
  }) : super(key: key);

  final TaskComposite task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // TODO [UX] calculate
            color: Colors.grey,
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(task?.daysUntilDue?.toString() ?? "X"),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // TODO [UX] calculate
            color: Colors.grey,
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(task?.daysSinceStart?.toString() ?? "X"),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Text(task?.title ?? "<No Title>")
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 12,
      child: CircleAvatar(
        // backgroundColor: Colors.red,
        radius: 26,
        child: Center(
          child: IconButton(
            // TODO [UX] add new task
            icon: Icon(Icons.add),
            onPressed: () => null,
            // BlocProvider.of<OverviewBloc>(context).add(OvEventAddNew()),
          ),
        ),
      ),
    );
  }
}

class SortButton extends StatelessWidget {
  const SortButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 12,
      bottom: 12,
      child: CircleAvatar(
        radius: 26,
        child: Center(
          child: IconButton(
            // TODO [UX] sort list based on selection;
            //   -- oldest first
            //      : forward arrow for pointing to past
            //   -- deadline first
            //      : backward arrow for pointing to future
            icon: Icon(Icons.arrow_forward),
            onPressed: () => null,
          ),
        ),
      ),
    );
  }
}

*/
