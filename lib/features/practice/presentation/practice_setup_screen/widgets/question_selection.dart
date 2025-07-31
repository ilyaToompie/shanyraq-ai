import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_screen/practice_screen.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_setup_screen/widgets/practice_mistakes_button.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_setup_screen/widgets/question_selection_button.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';

class QuestionSelection extends StatefulWidget {
  const QuestionSelection({super.key});

  @override
  State<QuestionSelection> createState() => _QuestionSelectionState();
}

class _QuestionSelectionState extends State<QuestionSelection> {
  int _selectedIndex = 0;

  void _select(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _select(0),
                      child: QuestionSelectionButton(
                        title: "random".tr(),
                        icon: Icons.shuffle_rounded,
                        isSelected: _selectedIndex == 0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _select(1),
                      child: QuestionSelectionButton(
                        title: "exam".tr(),
                        icon: Icons.numbers,
                        isSelected: _selectedIndex == 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _select(2),
                      child: QuestionSelectionButton(
                        title: "topic".tr(),
                        icon: Icons.topic_rounded,
                        isSelected: _selectedIndex == 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _select(3),
                      child: QuestionSelectionButton(
                        title: "in-a-row".tr(),
                        icon: Icons.table_rows_rounded,
                        isSelected: _selectedIndex == 3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => _select(4),
            child: PracticeMistakesButton(isSelected: _selectedIndex == 4),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              adaptiveNavigatorPush(
                context: context,
                builder: (_) => PracticeScreen(practiceType: _selectedIndex),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                textAlign: TextAlign.center,
                "start-practicing".tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
