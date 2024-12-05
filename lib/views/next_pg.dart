// lib/views/next_pg.dart
import 'package:flutter/material.dart';
import '../viewmodels/nextpg_viewmodel.dart';
import '../models/tutorial_target.dart';

class NextPg extends StatefulWidget {
  @override
  State<NextPg> createState() => _NextPgState();
}

class _NextPgState extends State<NextPg> {
  final NextPgViewModel viewModel = NextPgViewModel();

  final GlobalKey keyHome1 = GlobalKey();
  final GlobalKey keyCalendar1 = GlobalKey();
  final GlobalKey keyGroups1 = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tutorialTargets = [
        TutorialTarget(
          identify: "Home1",
          keyTarget: keyHome1,
          description: "Home screen for today's schedule.",
          showPrevious: false,
        ),
        TutorialTarget(
          identify: "Calendar1",
          keyTarget: keyCalendar1,
          description: "Week-view/Month-view of daily schedules.",
        ),
        TutorialTarget(
          identify: "Groups1",
          keyTarget: keyGroups1,
          description: "To Add Contacts and Groups used in Shared Tasks.",
          showNext: false,
        ),
      ];

      // Pass tutorialTargets and tutorialContent to the ViewModel
      viewModel.showTutorialIfNotShown(context, tutorialTargets, tutorialContent, () {
        print("Tutorial finished");
      });
    });
  }

  Widget tutorialContent(String text, bool showNext, bool showPrevious) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: viewModel.skip,
              icon: const Icon(Icons.close, color: Colors.blue),
            ),
          ],
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (showPrevious)
              IconButton(
                onPressed: viewModel.previous,
                icon: const Icon(Icons.arrow_circle_left),
                iconSize: 32,
                color: Colors.blue,
              ),
            if (showNext)
              IconButton(
                onPressed: viewModel.next,
                icon: const Icon(Icons.arrow_circle_right),
                iconSize: 32,
                color: Colors.blue,
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Next Page',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2a65d2),
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add search functionality here
            },
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
              size: 33,
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              key: keyHome1,
              icon: const Icon(Icons.home_outlined),
              onPressed: () {},
              iconSize: 38,
            ),
            IconButton(
              key: keyCalendar1,
              icon: const Icon(Icons.calendar_month_outlined),
              onPressed: () {},
              iconSize: 38,
            ),
            IconButton(
              key: keyGroups1,
              icon: const Icon(Icons.groups_2_outlined),
              onPressed: () {},
              iconSize: 38,
            ),
          ],
        ),
      ],
    );
  }
}
