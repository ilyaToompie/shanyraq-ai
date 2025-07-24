import 'package:flutter/material.dart';

class LessonWidget extends StatelessWidget {
  final bool isFinished;
  const LessonWidget({super.key, required this.isFinished});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        height: 200,
        width: 200,
        child: const Column(
          children: [
            Row(children: [Text("data")]),
          ],
        ),
      ),
    );
  }
}
