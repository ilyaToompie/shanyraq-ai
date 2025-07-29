import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MeetupIntroText extends StatelessWidget {
  const MeetupIntroText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text('meetups-desc'.tr(), style: textTheme.bodyMedium);
  }
}
