// lib/viewmodels/nextpg_viewmodel.dart
import 'tutorial_viewmodel.dart';
import 'package:flutter/material.dart';
import '../models/tutorial_target.dart';

class NextPgViewModel extends TutorialViewModel {
  
  

  // Accept tutorialTargets and tutorialContent as parameters
  void showTutorialIfNotShown(BuildContext context, List<TutorialTarget> tutorialTargets, Widget Function(String text, bool showNext, bool showPrevious) tutorialContent, VoidCallback onFinish) {
    if (!TutorialViewModel.isTutorialShown) {
      initTargets(tutorialTargets, tutorialContent);
      showTutorial(context, onFinish: onFinish);
      //isTutorialShown = true;  // Set the static variable to true after showing tutorial
    }
  }

  void prevpg(BuildContext context){
    tutorialCoachMark.finish();
    Navigator.pop(context,true);
    
  }

  setIsTutorialShown(){
    TutorialViewModel.isTutorialShown = true;
  }

  

  void skip1(BuildContext context){
    setIsTutorialShown();
    tutorialCoachMark.skip();
    Navigator.pop(context);
  }
}
