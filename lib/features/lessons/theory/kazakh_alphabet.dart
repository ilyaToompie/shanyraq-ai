import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shyraq_ai/features/lessons/theory/widgets/start_practicing_button.dart';

class KazakhAlphabetScreen extends StatelessWidget {
  final int xpReward;

  const KazakhAlphabetScreen({super.key, required this.xpReward});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('alphabet_title'.tr())),
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
                      text: '${'alphabet_heading'.tr()}\n\n',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(text: '${'alphabet_intro'.tr()}\n\n'),
                    TextSpan(
                      text: '${'alphabet_vowels_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: '${'alphabet_vowels_desc'.tr()}\n\n'),
                    TextSpan(
                      text: '${'alphabet_consonants_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: '${'alphabet_consonants_desc'.tr()}\n\n'),
                    TextSpan(
                      text: '${'alphabet_examples_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(
                      text: '${'alphabet_examples_list'.tr()}\n\n',
                      style: TextStyle(color: Colors.teal[700]),
                    ),
                    TextSpan(
                      text: '${'alphabet_tips_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: '${'alphabet_tips_desc'.tr()}\n\n'),
                    TextSpan(
                      text: '${'alphabet_practice_heading'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(text: '${'alphabet_practice_task'.tr()} '),
                    TextSpan(
                      text: '${'alphabet_practice_example'.tr()}\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    TextSpan(
                      text: '${'alphabet_practice_translation'.tr()}',
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
                topic: 'kazakh_alphabet',
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
