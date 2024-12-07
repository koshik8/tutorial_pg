// lib/viewmodels/nextpg_viewmodel.dart
import 'tutorial_viewmodel.dart';
import 'package:flutter/material.dart';
import '../models/tutorial_target.dart';

class NextPgViewModel extends TutorialViewModel {
  static bool isTutorialShown = false;
  

  // Accept tutorialTargets and tutorialContent as parameters
  void showTutorialIfNotShown(BuildContext context, List<TutorialTarget> tutorialTargets, Widget Function(String text, bool showNext, bool showPrevious) tutorialContent, VoidCallback onFinish) {
    if (!isTutorialShown) {
      initTargets(tutorialTargets, tutorialContent);
      showTutorial(context, onFinish: onFinish);
      //isTutorialShown = true;  // Set the static variable to true after showing tutorial
    }
  }

  void prevpg(BuildContext context){
    tutorialCoachMark.finish();
    Navigator.pop(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateMethod();
      //showTutorial(context,  onFinish: (){print("finish");});
      tutorialCoachMark.goTo(4);
    
  });
  }

  void complete(){
    isTutorialShown = true;
    tutorialCoachMark.finish();
  }  
}
