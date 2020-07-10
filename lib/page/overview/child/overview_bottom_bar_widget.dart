// framework
import 'package:flutter/material.dart';

class OverviewBottomBarWidget extends StatelessWidget {
  const OverviewBottomBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Icon(Icons.add_box),
          ),
        ],
      ),
    );
  }
}
