import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreenTitle extends StatelessWidget {
  const HomeScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "kazakh-tili".tr(),
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
                "exam-preparation".tr(),
                style: TextStyle(
                  fontSize: 30,
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
