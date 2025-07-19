import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/practice/widgets/practice_mistakes_button.dart';
import 'package:shyraq_ai/features/practice/widgets/question_selection_button.dart';

class QuestionSelection extends StatefulWidget {
  const QuestionSelection({super.key});

  @override
  State<QuestionSelection> createState() => _QuestionSelectionState();
}

class _QuestionSelectionState extends State<QuestionSelection> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
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
                      isSelected: _selectedIndex == 0 ? true : false,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  SizedBox(height: 4),
                  GestureDetector(
                    child: QuestionSelectionButton(
                      title: "Exam Number",
                      icon: Icons.numbers,
                      isSelected: _selectedIndex == 1 ? true : false,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
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
                      isSelected: _selectedIndex == 2 ? true : false,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                  ),
                  SizedBox(height: 4),
                  GestureDetector(
                    child: QuestionSelectionButton(
                      title: "In a row",
                      icon: Icons.table_rows_rounded,
                      isSelected: _selectedIndex == 3 ? true : false,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          GestureDetector(
            child: PracticeMistakesButton(
              isSelected: _selectedIndex == 4 ? true : false,
            ),
            onTap: () {
              setState(() {
                _selectedIndex = 4;
              });
            },
          ),
        ],
      ),
    );
  }
}
