import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/practice/widgets/question_selection.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Practice",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w200,
            color: Theme.of(context).textTheme.bodyLarge!.color?.withAlpha(175),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Transform.translate(
                offset: const Offset(0, -12),
                child: Text(
                  "Challenge your knowledge",
                  style: TextStyle(
                    fontSize: 54,
                    letterSpacing: -2,
                    height: 1.1,
                  ),
                ),
              ),
              Text(
                "Select question type",
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.color?.withAlpha(150),
                  letterSpacing: -2,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 16),

              QuestionSelection(),
            ],
          ),
        ),
      ),
    );
  }
}
