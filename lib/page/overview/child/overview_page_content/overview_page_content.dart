// framework
import 'package:flutter/material.dart';
// project
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';

import 'child/task_section/task_section.dart';

class OverviewPageContent extends StatelessWidget {
  const OverviewPageContent({
    Key key,
    @required this.state,
  }) : super(key: key);

  final OvStateLoaded state;

  @override
  Widget build(BuildContext context) {
    // : Page Border Padding
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      // : Holds completed, active, staged
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          TaskSection(
            title: "Completed",
            tasks: state.completedTasks,
          ),
          TaskSection(
            title: "Active",
            tasks: state.activeTasks,
          ),
          TaskSection(
            title: "Staged",
            tasks: state.stagedTasks,
          ),
          Container(
            height: 50, // TODO same as bottom bar
          ),
        ],
      ),
    );
  }
}
