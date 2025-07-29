import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MeetupTitle extends StatelessWidget {
  const MeetupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'meetups-in-your-city'.tr(),
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
