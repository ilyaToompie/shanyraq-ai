import 'package:flutter/material.dart';

class MeetupScreen extends StatelessWidget {
  const MeetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Meetups')),
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

class MeetupIntroText extends StatelessWidget {
  const MeetupIntroText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      'Join local language meetups to practice with others in real life. These events help build speaking confidence and meet learners like you.',
      style: textTheme.bodyMedium,
    );
  }
}

class MeetupMap extends StatelessWidget {
  const MeetupMap({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Icon(Icons.map, color: color.onPrimaryContainer)),
    );
  }
}

class MeetupTitle extends StatelessWidget {
  const MeetupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Text(
      'Meetups in your city',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color.onBackground,
      ),
    );
  }
}

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

class MeetupCard extends StatelessWidget {
  final int current;
  final int max;
  final String time;
  final String date;
  final String bossUsername;

  const MeetupCard({
    required this.current,
    required this.max,
    required this.time,
    required this.date,
    required this.bossUsername,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(Icons.group, color: color.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$current / $max people',
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
                Text(
                  'Time: $time',
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
                Text(
                  'Date: $date',
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
                Text(
                  'Boss: $bossUsername',
                  style: TextStyle(color: color.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
