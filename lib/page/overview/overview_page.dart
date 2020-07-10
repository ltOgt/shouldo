// framework
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// package
import 'package:flutter_bloc/flutter_bloc.dart';
// project
import 'package:shouldo/data/composite/task_composite.dart';
import 'package:shouldo/data/db/moor_db.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';

import 'child/overview_header_widget.dart';

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
    DateTime _focusedDate =
        DateTime.now().subtract(Duration(days: this.daysInPast));

    return BlocProvider(
      create: (BuildContext context) => OverviewBloc(
        dao: RepositoryProvider.of<AppDatabase>(context).overviewDao,
      ),
      child: BlocBuilder<OverviewBloc, OverviewState>(
        builder: (context, state) {
          // : TODO add description
          if (state is OvStateInitial) {
            BlocProvider.of<OverviewBloc>(context).add(OvEventLoadForDate(
              focusedDate: DateTime.now(),
            ));
            // TODO [UX] actual loading page
            return Center(child: CircularProgressIndicator());
          } else if (state is OvStateLoaded) {
            return Column(
              children: <Widget>[
                OverviewHeaderWidget(
                  focusedDate: state.focusedDate,
                  // goToFirstPage: BlocProvider.of<OverviewBloc>(context).add(
                  //   OvEventJumpToToday(),
                  // )
                  goToFirstPage: null,
                  daysInPast: 0,
                ),
                Flexible(
                  child: Stack(
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemBuilder: (_, __) => Container(
                          margin: EdgeInsets.all(4),
                          color: Colors.red,
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: <Widget>[
                              Container(
                                color: Colors.black,
                                margin: EdgeInsets.all(4),
                                height: 500,
                              ),
                              Container(
                                color: Colors.black,
                                margin: EdgeInsets.all(4),
                                height: 500,
                              ),
                              Container(
                                color: Colors.black,
                                margin: EdgeInsets.all(4),
                                height: 500,
                              ),
                              Container(
                                height: 50, // TODO same as bottom bar
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Color(0xCC000000),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  color: Colors.blue,
                                  height: 1,
                                ),
                              ),
                              Container(
                                child: Icon(Icons.add_box),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
  }
}

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
          BlocProvider.of<OverviewBloc>(context).add(OvEventLoadForDate(
            focusedDate: this.focusedDate,
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
