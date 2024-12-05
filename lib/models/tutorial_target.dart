// lib/models/tutorial_target.dart
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialTarget {
  final String identify;
  final GlobalKey keyTarget;
  final String description;
  final bool showNext;
  final bool showPrevious;

  TutorialTarget({
    required this.identify,
    required this.keyTarget,
    required this.description,
    this.showNext = true,
    this.showPrevious = true,
  });

  TargetFocus toTargetFocus(Function childBuilder) {
    return TargetFocus(
      identify: identify,
      keyTarget: keyTarget,
      shape: ShapeLightFocus.Circle,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: childBuilder(description, showNext, showPrevious),
        ),
      ],
    );
  }
}
