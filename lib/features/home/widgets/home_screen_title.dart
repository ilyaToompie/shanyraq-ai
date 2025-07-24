import 'package:flutter/material.dart';

class HomeScreenTitle extends StatelessWidget {
  const HomeScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Kazakh tili",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 35),
            ),
          ],
        ),
        Transform.translate(
          offset: const Offset(0, -1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Exam Preparation",
                style: TextStyle(
                  fontSize: 35,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color!.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
