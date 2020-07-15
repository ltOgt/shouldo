// framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shouldo/data/composite/task_composite.dart';
// project
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

import 'child/task_section/task_section.dart';

class OverviewPageContent extends StatelessWidget {
  const OverviewPageContent({
    Key key,
    @required this.state,
  }) : super(key: key);

  final OvStateLoaded state;

  @override
  Widget build(BuildContext context) {
    ThemeWrap theme = ThemeNotifier.getTheme(context);
    void _fSendToggleEvent(TaskComposite task, bool doComplete) {
      if ((task.completionDate == null) == doComplete) {
        BlocProvider.of<OverviewBloc>(context).add(OvEventToggleTaskCompletion(
          task: task,
          doComplete: doComplete,
        ));
      } else {
        throw ("OverviewPageContent; Task toggled although already in that state: <$task> <$doComplete>");
      }
    }

    // : Page Border Padding
    return Padding(
      padding: EdgeInsets.only(
        left: theme.sidePadding,
        right: theme.sidePadding,
      ),
      // : Holds completed, active, staged
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          TaskSection(
            title: "Completed",
            tasks: state.completedTasks,
            onUnCheck: (TaskComposite task) => _fSendToggleEvent(task, false),
          ),
          TaskSection(
            title: "Active",
            tasks: state.activeTasks,
            onCheck: (TaskComposite task) => _fSendToggleEvent(task, true),
          ),
          TaskSection(
            title: "Staged",
            tasks: state.stagedTasks,
            onCheck: (TaskComposite task) => _fSendToggleEvent(task, true),
          ),
        ],
      ),
    );
  }
}
