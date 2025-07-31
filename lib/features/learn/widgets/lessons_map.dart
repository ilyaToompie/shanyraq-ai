import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/learn/domain/lesson.dart';
import 'package:shyraq_ai/features/lessons/theory/kazakh_introduction_screen.dart';
import 'package:shyraq_ai/features/lessons/theory/kazakh_alphabet.dart';
import 'package:shyraq_ai/features/lessons/theory/kazakh_cases_screen.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';
import 'package:shyraq_ai/shared/widgets/adaptive_dialogue.dart';

class LessonsMap extends StatelessWidget {
  final List<Lesson> lessons = [
    Lesson(
      titleKey: 'introduction_title',
      descriptionKey: 'introduction_description',
      xp: 50,
      timeToComplete: const Duration(minutes: 5),
      exerciseCount: 7,
    ),
    Lesson(
      titleKey: 'alphabet_title',
      descriptionKey: 'alphabet_description',
      xp: 75,
      timeToComplete: const Duration(minutes: 10),
      exerciseCount: 10,
    ),
    Lesson(
      titleKey: 'kazakh_cases_title',
      descriptionKey: 'kazakh_cases_description',
      xp: 70,
      timeToComplete: const Duration(minutes: 8),
      exerciseCount: 10,
    ),
  ];

  LessonsMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(80),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              return LessonWidget(lesson: lessons[index]);
            },
          ),
        ),
      ),
    );
  }
}

class LessonWidget extends StatelessWidget {
  final Lesson lesson;

  const LessonWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.titleKey.tr(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              lesson.descriptionKey.tr(),
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.timer, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text('${lesson.timeToComplete.inMinutes} ${'minutes'.tr()}'),
                const SizedBox(width: 16),
                const Icon(Icons.task_alt, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text('${lesson.exerciseCount} ${'exercises'.tr()}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.stars, size: 18, color: Colors.amber),
                const SizedBox(width: 6),
                Text('${lesson.xp} ${'xp'.tr()}'),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser != null) {
                      switch (lesson.titleKey) {
                        case 'alphabet_title':
                          adaptiveNavigatorPush(
                            context: context,
                            builder:
                                (context) =>
                                    KazakhAlphabetScreen(xpReward: lesson.xp),
                          );
                          break;
                        case 'introduction_title':
                          adaptiveNavigatorPush(
                            context: context,
                            builder:
                                (context) =>
                                    KazakhGreetingsScreen(xpReward: lesson.xp),
                          );
                          break;
                        case 'kazakh_cases_title':
                          adaptiveNavigatorPush(
                            context: context,
                            builder:
                                (context) =>
                                    KazakhCasesScreen(xpReward: lesson.xp),
                          );
                          break;
                      }
                    } else {
                      adaptiveDialog(
                        context: context,
                        title: 'Войдите в аккаунт',
                        content: "Чтобы начать изучение казахского языка!",
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4,
                    ),
                    child: Text('start'.tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
