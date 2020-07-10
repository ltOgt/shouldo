// framework
import 'package:flutter/material.dart';
// project
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';

class OverviewPageContentLoadedWidget extends StatelessWidget {
  const OverviewPageContentLoadedWidget({
    Key key,
    @required this.state,
  }) : super(key: key);

  final OvStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
