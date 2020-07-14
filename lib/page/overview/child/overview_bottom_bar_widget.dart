// framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

class OverviewBottomBarWidget extends StatelessWidget {
  const OverviewBottomBarWidget({
    Key key,
    @required this.isAdderAreaExpanded,
  }) : super(key: key);

  final bool isAdderAreaExpanded;

  @override
  Widget build(BuildContext context) {
    final ThemeWrap theme = ThemeNotifier.getTheme(context);

    // TODO [UX] react to exapnsion of adder area (show "done"; indicate active/staged target based on input; show "cancel")
    return Container(
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
            child: InkWell(
              onTap: () => BlocProvider.of<OverviewBloc>(context).add(
                OvEventToggleAdderAreaExpansion(
                  isExpanded:
                      !isAdderAreaExpanded, // TODO should always be true since button gone when expanded
                ),
              ),
              child: Icon(Icons.add_box),
            ),
          ),
        ],
      ),
    );
  }
}
