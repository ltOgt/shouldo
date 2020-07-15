// framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
    @required this.isAdderAreaExpanded,
    @required this.onDone,
  }) : super(key: key);

  final bool isAdderAreaExpanded;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final ThemeWrap theme = ThemeNotifier.getTheme(context);

    // TODO [UX] react to exapnsion of adder area (show "done"; indicate active/staged target based on input; show "cancel")
    return Container(
      color: Color(0xCC000000),
      height: theme.adderBarHeight,
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
          if (this.isAdderAreaExpanded)
            Container(
              child: InkWell(
                onTap: this.onDone,
                child: Icon(Icons.done),
              ),
            ),
          Container(
            child: InkWell(
              onTap: () => BlocProvider.of<OverviewBloc>(context).add(
                OvEventToggleAdderAreaExpansion(
                  isExpanded: !this
                      .isAdderAreaExpanded, // TODO should always be true since button gone when expanded
                ),
              ),
              child:
                  Icon(this.isAdderAreaExpanded ? Icons.cancel : Icons.add_box),
            ),
          ),
        ],
      ),
    );
  }
}
