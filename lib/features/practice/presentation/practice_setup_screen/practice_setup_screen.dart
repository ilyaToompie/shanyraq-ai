import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_setup_screen/widgets/ai_chat_button.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_setup_screen/widgets/question_selection.dart';

class PracticeSetupScreen extends StatelessWidget {
  const PracticeSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: false,
        title: const Text("Practice"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -12),
              child: const Text(
                "Challenge your knowledge",
                style: TextStyle(fontSize: 54, letterSpacing: -2, height: 1.1),
              ),
            ),
            const AiChatButton(),
            Text(
              "or",
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withAlpha(150),
                letterSpacing: -2,
                height: 1.1,
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
            const SizedBox(height: 16),

            const QuestionSelection(),
          ],
        ),
      ),
    );
  }
}
