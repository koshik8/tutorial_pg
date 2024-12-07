// lib/viewmodels/tutorial_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../models/tutorial_target.dart';
import '../views/next_pg.dart';

class TutorialViewModel {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  int currentIndex = 0;
  static bool isTutorialDone = false;
  late Function updateMethod;

  void initTargets(List<TutorialTarget> tutorialTargets, Function childBuilder) {
    targets = tutorialTargets
        .map((tutorial) => tutorial.toTargetFocus(childBuilder))
        .toList();
  }

  void showTutorial(BuildContext context, {required VoidCallback onFinish}) {
    tutorialCoachMark = TutorialCoachMark(
      hideSkip: true,
      targets: targets,
      colorShadow: Colors.black.withOpacity(0.8),
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: onFinish,
      onClickTarget: (target) {
        currentIndex = targets.indexWhere((t) => t.identify == target.identify);
      },
    );
    if (!tutorialCoachMark.isShowing) {
    tutorialCoachMark.show(context: context);
  }
  }

  void next() {
    if (currentIndex < targets.length - 1) {
      currentIndex++;
      tutorialCoachMark.next();
    }
  }

  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      tutorialCoachMark.previous();
    }
  }

  void skip() {
    tutorialCoachMark.skip();
  }

  void  nextPg(BuildContext context) {
    tutorialCoachMark.finish();
    Navigator.push(context, MaterialPageRoute(builder: (context) => NextPg(),));
  }

  void setmethod(Function method){
    updateMethod = method;
  }

  
}
