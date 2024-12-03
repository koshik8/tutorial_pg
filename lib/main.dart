import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TutorialScreen(),
    );
  }
}

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final GlobalKey keyHome = GlobalKey();
  final GlobalKey keyCalendar = GlobalKey();
  final GlobalKey keyGroups = GlobalKey();
  final GlobalKey keyIdeas = GlobalKey();
  final GlobalKey keyProfile = GlobalKey();

  late TutorialCoachMark tutorialCoachMark;

  List<TargetFocus> targets = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initTargets();
      showTutorial();
    });
  }

  void initTargets() {
    targets = [
      TargetFocus(
        identify: "Home",
        keyTarget: keyHome,
        
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: tutorialContent(
              "Home screen for today's schedule.",
              showPrevious: false,
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Calendar",
        keyTarget: keyCalendar,
        
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: tutorialContent(
              "Week-view/Month-view of daily schedules.",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Groups",
        keyTarget: keyGroups,
        
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: tutorialContent(
              "To Add Contacts and Groups used in Shared Tasks",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Ideas",
        keyTarget: keyIdeas,
        
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: tutorialContent(
              "The Ideas section helps you capture new thoughts.",
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "Profile",
        keyTarget: keyProfile,
        
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: tutorialContent(
              "Access your events settings here.",
              showNext: false,
            ),
          ),
        ],
      ),
    ];
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      hideSkip: true,
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.8),
      
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("Tutorial finished");
      },
      onClickTarget: (target) {
        print("Clicked target: ${target.identify}");
      },
      onSkip: () {
        print("Tutorial skipped");
        return true;
      },
      onClickOverlay: (target) {
        print("Clicked overlay: ${target.identify}");
      },
    )..show(context:context);
  }

  Widget tutorialContent(String text, {bool showNext = true, bool showPrevious = true}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: ()=>{tutorialCoachMark.skip()}, icon: Icon(Icons.close,color: Colors.blue ,)),
          ],
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (showPrevious)
              IconButton(
                onPressed: () {
                  if (currentIndex > 0) {
                    currentIndex--;
                    tutorialCoachMark.previous();
                  }
                },
                icon: const Icon(Icons.arrow_circle_left),
                iconSize: 32,
                color: Colors.blue,
              ),
            
            if (showNext)
              IconButton(
                onPressed: () {
                  if (currentIndex < targets.length - 1) {
                    currentIndex++;
                    tutorialCoachMark.next();
                  }
                },
                icon: const Icon(Icons.arrow_circle_right,),
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
              onPressed: () => {
                // handle
              },
              padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 33,
              ),
            ),
          ],
        ),
      persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [IconButton(
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
      ],),],
    );
  }
}