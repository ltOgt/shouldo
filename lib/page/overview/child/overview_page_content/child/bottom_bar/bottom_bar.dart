// framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';
import 'package:shouldo/theme/theme_notifier.dart';
import 'package:shouldo/theme/theme_wrap.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  FocusNode focusNode;
  TextEditingController textEditingController;

  bool sTextFocused;
  void _fSetFocus() {
    bool _f = this.focusNode.hasFocus;
    if (_f != this.sTextFocused) {
      setState(() {
        this.sTextFocused = _f;
      });
    }
  }

  void _fPressDone() {
    String _t = this.textEditingController.text;
    // TODO import StringHelper.hasContent as package
    if (_t != null && _t.trim() != "") {
      BlocProvider.of<OverviewBloc>(context).add(
        OvEventAddTask(title: textEditingController.text),
      );
    }
    this.textEditingController.clear();
    this.focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    this.textEditingController = TextEditingController();
    this.focusNode = FocusNode();
    this.focusNode.addListener(this._fSetFocus);
    this.sTextFocused = this.focusNode.hasFocus;
  }

  @override
  void dispose() {
    this.textEditingController.dispose();
    this.focusNode.removeListener(this._fSetFocus);
    this.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeWrap theme = ThemeNotifier.getTheme(context);

    // TODO [UX] react to exapnsion of adder area (show "done"; indicate active/staged target based on input; show "cancel")
    return Container(
      color: Color(0xCC000000),
      height: theme.adderBarHeight,
      width: double.infinity,
      padding: EdgeInsets.only(
        left: theme.sidePadding / 2,
        right: theme.sidePadding / 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // : Change ordering
          Container(
            child: InkWell(
              // TODO reuse expansion toggle for this
              onTap: () => null, //BlocProvider.of<OverviewBloc>(context).add(),
              child: Icon(Icons.swap_vert),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              controller: this.textEditingController,
              focusNode: this.focusNode,
              onEditingComplete: this._fPressDone,
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          // : !FOCUSED => Focus text
          // :  FOCUSED => Create new from text value
          Container(
            child: InkWell(
              onTap: () => this.sTextFocused
                  // : Create from entered text
                  ? this._fPressDone()
                  // : Request focus to start typing (same as tapping textfield directly)
                  : this.focusNode.requestFocus(),
              child: Icon(
                this.sTextFocused ? Icons.done : Icons.add_box,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
