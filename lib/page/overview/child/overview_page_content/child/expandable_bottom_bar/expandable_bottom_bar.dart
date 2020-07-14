import 'package:flutter/material.dart';

import 'child/bottom_bar.dart';
import 'child/expanded_bottom_bar_area.dart';

class ExpandableBottomBar extends StatefulWidget {
  final bool expand;
  ExpandableBottomBar({
    this.expand = false,
  });

  @override
  _ExpandableBottomBarState createState() => _ExpandableBottomBarState();
}

class _ExpandableBottomBarState extends State<ExpandableBottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    this.expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    this.animation = CurvedAnimation(
      // : AnimationController extends Animation
      parent: this.expandController,
      curve: Curves.fastOutSlowIn,
    );
    this.focusNode = FocusNode();
    toggleExpansion();
  }

  @override
  void didUpdateWidget(ExpandableBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    toggleExpansion();
  }

  @override
  void dispose() {
    this.expandController.dispose();
    this.focusNode.dispose();
    super.dispose();
  }

  void toggleExpansion() {
    if (widget.expand) {
      expandController.forward();
    } else {
      focusNode.unfocus();
      expandController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BottomBar(isAdderAreaExpanded: widget.expand),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: animation,
          child: ExpandedBottomBarArea(
            focusNode: focusNode,
          ),
        ),
      ],
    );
  }
}
