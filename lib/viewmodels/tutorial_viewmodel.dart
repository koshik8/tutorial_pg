// lib/viewmodels/tutorial_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../models/tutorial_target.dart';
import '../views/next_pg.dart';

class TutorialViewModel {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];
  int currentIndex = 0;
  static bool isTutorialShown = false;
  

  void initTargets(List<TutorialTarget> tutorialTargets, Function childBuilder) {
    targets = tutorialTargets
        .map((tutorial) => tutorial.toTargetFocus(childBuilder))
        .toList();
  }

  void showTutorial(BuildContext context,{int con=0,required VoidCallback onFinish}) {
    tutorialCoachMark = TutorialCoachMark(
      hideSkip: true,
      targets: (con==0)?targets:targets.sublist(con)+targets.sublist(0,con),
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
    else{
      currentIndex = 0;
    tutorialCoachMark.goTo(currentIndex);
    }
  }

  void previous() {
    if (currentIndex > 0) {
      currentIndex--;
      tutorialCoachMark.previous();
    }
    else{
      currentIndex = 4;
    tutorialCoachMark.goTo(currentIndex);
    }
  }

  void skip() {
    isTutorialShown = true;
    tutorialCoachMark.skip();
  }

  Future <bool>  nextPg(BuildContext context) async{
    tutorialCoachMark.finish();
    final bool res = await Navigator.push(context, MaterialPageRoute(builder: (context) => NextPg(),)) as bool;
    if (res == true){
      currentIndex = 0;
      return true;
    }
    return false;
  }

  

  void disp1(BuildContext context){
    showTutorial(context, con:4,onFinish: () {
                      print("Tutorial finished");
                    });
    
  }
  
}
