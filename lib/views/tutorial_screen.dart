// lib/views/tutorial_screen.dart
import 'package:flutter/material.dart';
import '../viewmodels/tutorial_viewmodel.dart';
import '../models/tutorial_target.dart';
import './next_pg.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final TutorialViewModel viewModel = TutorialViewModel();

  final GlobalKey keyHome = GlobalKey();
  final GlobalKey keyCalendar = GlobalKey();
  final GlobalKey keyGroups = GlobalKey();
  final GlobalKey keyIdeas = GlobalKey();
  final GlobalKey keyProfile = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tutorialTargets = [
        TutorialTarget(
          identify: "Home",
          keyTarget: keyHome,
          description: "Home screen for today's schedule.",
          showPrevious: false,
        ),
        TutorialTarget(
          identify: "Calendar",
          keyTarget: keyCalendar,
          description: "Week-view/Month-view of daily schedules.",
        ),
        TutorialTarget(
          identify: "Groups",
          keyTarget: keyGroups,
          description: "To Add Contacts and Groups used in Shared Tasks.",
        ),
        TutorialTarget(
          identify: "Ideas",
          keyTarget: keyIdeas,
          description: "The Ideas section helps you capture new thoughts.",
        ),
        TutorialTarget(
          identify: "Profile",
          keyTarget: keyProfile,
          description: "Access your events settings here.",
          showNext: false,
        ),
      ];

      viewModel.initTargets(tutorialTargets, tutorialContent);
      viewModel.showTutorial(context, onFinish: () {
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
      appBar:  AppBar(
        centerTitle: true,
        title: const Text(
          'My Day',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2a65d2),
        leading: IconButton(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NextPg()),
              );
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
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
              key: keyHome,
              icon: const Icon(Icons.home_outlined),
              iconSize: 38,
              onPressed: () {},
            ),
            IconButton(
              key: keyCalendar,
              icon: const Icon(Icons.calendar_month_outlined),
              iconSize: 38,
              onPressed: () {},
            ),
            IconButton(
              key: keyGroups,
              icon: const Icon(Icons.groups_2_outlined),
              iconSize: 38,
              onPressed: () {},
            ),
            IconButton(
              key: keyIdeas,
              icon: const Icon(Icons.lightbulb_outline_sharp),
              iconSize: 38,
              onPressed: () {},
            ),
            IconButton(
              key: keyProfile,
              icon: const Icon(Icons.menu_book),
              iconSize: 38,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
