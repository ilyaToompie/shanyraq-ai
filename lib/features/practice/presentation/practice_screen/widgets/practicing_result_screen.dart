import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PracticeResultScreen extends StatelessWidget {
  final int score;

  const PracticeResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("result-title".tr())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "your-result".tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              "$score / 10",
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("restart".tr()),
            ),
          ],
        ),
      ),
    );
  }
}
