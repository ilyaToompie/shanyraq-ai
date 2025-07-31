import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shyraq_ai/features/lessons/theory/widgets/start_practicing_button.dart';

// ignore: must_be_immutable
class KazakhCasesScreen extends StatelessWidget {
  int xpReward;
  KazakhCasesScreen({super.key, required this.xpReward});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('kazakh_cases_title'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'kazakh_cases_intro'.tr(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const TextSpan(text: '\n\n'),
                    TextSpan(
                      text: 'kazakh_cases_list_title'.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(text: 'kazakh_cases_nominative'.tr()),
                    const TextSpan(text: '\n'),
                    TextSpan(text: 'kazakh_cases_genitive'.tr()),
                    const TextSpan(text: '\n'),
                    TextSpan(text: 'kazakh_cases_dative'.tr()),
                    const TextSpan(text: '\n'),
                    TextSpan(text: 'kazakh_cases_accusative'.tr()),
                    const TextSpan(text: '\n'),
                    TextSpan(text: 'kazakh_cases_locative'.tr()),
                    const TextSpan(text: '\n'),
                    TextSpan(text: 'kazakh_cases_ablative'.tr()),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              StartPracticingButton(
                topic: 'kazakh_cases',
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
