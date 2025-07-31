import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/lessons/theory/widgets/start_practicing_button.dart';

class KazakhGreetingsScreen extends StatelessWidget {
  int xpReward;
  KazakhGreetingsScreen({super.key, required this.xpReward});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('greeting_title'.tr(), style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: '${'greeting_heading'.tr()}\n\n',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '${'greeting_intro'.tr()}\n\n'),
                    TextSpan(
                      text: '${'greeting_common_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(
                      text: '${'greeting_common_list'.tr()}\n\n',
                      style: TextStyle(color: Colors.teal[700]),
                    ),
                    TextSpan(
                      text: '${'greeting_formality_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: '${'greeting_formality_desc'.tr()}\n\n'),
                    TextSpan(
                      text: '${'greeting_examples_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(
                      text: '${'greeting_examples_list'.tr()}\n\n',
                      style: TextStyle(color: Colors.teal[700]),
                    ),
                    TextSpan(
                      text: '${'greeting_tips_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: '${'greeting_tips_desc'.tr()}\n\n'),
                    TextSpan(
                      text: '${'greeting_practice_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: '${'greeting_practice_task'.tr()} '),
                    TextSpan(
                      text: '${'greeting_practice_example'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    TextSpan(
                      text: '${'greeting_practice_translation'.tr()}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              StartPracticingButton(
                topic: 'kazakh_introduction',
                questionCount: 10,
                xpReward: xpReward,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
