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
import 'child/overview_page_content/overview_page_content_loaded_widget.dart';

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
                            OverviewPageContent(state: state),
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
  }
}
