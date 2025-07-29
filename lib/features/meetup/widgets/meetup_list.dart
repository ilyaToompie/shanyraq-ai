import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/meetup/widgets/meetup_card.dart';

class MeetupList extends StatelessWidget {
  const MeetupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (i) => const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: MeetupCard(
            current: 3,
            max: 10,
            time: '18:00',
            date: '2025-07-30',
            bossUsername: '@language_boss',
          ),
        ),
      ),
    );
  }
}
