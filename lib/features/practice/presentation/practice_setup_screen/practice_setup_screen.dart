import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_setup_screen/widgets/ai_chat_button.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_setup_screen/widgets/question_selection.dart';

class PracticeSetupScreen extends StatelessWidget {
  const PracticeSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        centerTitle: false,
        title: Text("practice".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -12),
              child: Text(
                "challenge-your-knowledge".tr(),
                style: TextStyle(fontSize: 54, letterSpacing: -2, height: 1.1),
              ),
            ),
            const AiChatButton(),
            SizedBox(height: 10),
            Text(
              "or".tr(),
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
              "select-question-type".tr(),
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
