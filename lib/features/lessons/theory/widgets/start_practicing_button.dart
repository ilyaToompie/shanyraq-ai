import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/lessons/exercise/exercise_screen.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';

class StartPracticingButton extends StatelessWidget {
  final String topic;
  final int xpReward;
  final int questionCount;

  const StartPracticingButton({
    super.key,
    required this.topic,
    required this.questionCount,
    required this.xpReward,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () {
        adaptiveNavigatorPush(
          context: context,
          builder:
              (context) => ExerciseScreen(
                topic: topic,
                questionCount: questionCount,
                xpReward: xpReward,
              ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
        child: Text(
          "start-practicing".tr(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
