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
  bool _hasMadeSubSelection = false;

  void _onSubSelectionMade() {
    setState(() {
      _hasMadeSubSelection = true;
    });
  }

  Widget _buildSubSelection() {
    switch (_selectedIndex) {
      case 1:
        return Column(
          children: [
            const Text('Select Exam Number'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _onSubSelectionMade,
              child: const Text('Exam #1 (Demo)'),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            const Text('Select Topic'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _onSubSelectionMade,
              child: const Text('Topic: Grammar (Demo)'),
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            const Text('Select Starting Question'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _onSubSelectionMade,
              child: const Text('Start from Q1 (Demo)'),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  bool get _canStart {
    if (_selectedIndex == 0 || _selectedIndex == 4) return true;
    return _hasMadeSubSelection;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  GestureDetector(
                    child: QuestionSelectionButton(
                      title: "Random",
                      icon: Icons.shuffle_rounded,
                      isSelected: _selectedIndex == 0,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        _hasMadeSubSelection = false;
                      });
                    },
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    child: QuestionSelectionButton(
                      title: "Exam Number",
                      icon: Icons.numbers,
                      isSelected: _selectedIndex == 1,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                        _hasMadeSubSelection = false;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    child: QuestionSelectionButton(
                      title: "Topic",
                      icon: Icons.topic_rounded,
                      isSelected: _selectedIndex == 2,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                        _hasMadeSubSelection = false;
                      });
                    },
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    child: QuestionSelectionButton(
                      title: "In a row",
                      icon: Icons.table_rows_rounded,
                      isSelected: _selectedIndex == 3,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                        _hasMadeSubSelection = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          GestureDetector(
            child: PracticeMistakesButton(isSelected: _selectedIndex == 4),
            onTap: () {
              setState(() {
                _selectedIndex = 4;
                _hasMadeSubSelection = false;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSubSelection(),
          if (_canStart)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ElevatedButton.icon(
                onPressed: () {
                  adaptiveNavigatorPush(
                    context: context,
                    builder:
                        (context) =>
                            PracticeScreen(practiceType: _selectedIndex),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start"),
              ),
            ),
        ],
      ),
    );
  }
}
