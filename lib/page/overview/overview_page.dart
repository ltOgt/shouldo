// framework
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// package
import 'package:flutter_bloc/flutter_bloc.dart';
// project
import 'package:shouldo/data/db/moor_db.dart';
import 'package:shouldo/page/overview/bloc/overview_bloc.dart';

import 'child/overview_page_content/child/bottom_bar/bottom_bar.dart';
import 'child/overview_header_widget.dart';
import 'child/overview_page_content/overview_page_content.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({
    Key key,
  }) : super(key: key);

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
                  daysInPast: state.page,
                ),
                // : PAGE CONTENT; incl BOTTOM BAR ====
                Flexible(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    // : Used to react to page changes and to navigate
                    controller: state.pageController,
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemBuilder: (_, __) => OverviewPageContent(state: state),
                  ),
                ),
                // TODO MERGE bottom bar with expandable
                BottomBar(
                  state: state,
                ),
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
