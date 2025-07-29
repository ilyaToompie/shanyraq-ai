import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_intro_text.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_list.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_map.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_title.dart';

class MeetupsListScreen extends StatelessWidget {
  const MeetupsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('meetups-title'.tr())),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MeetupIntroText(),
            SizedBox(height: 16),
            MeetupMap(),
            SizedBox(height: 24),
            MeetupTitle(),
            SizedBox(height: 12),
            MeetupList(),
          ],
        ),
      ),
    );
  }
}
