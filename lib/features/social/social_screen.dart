import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/meetup/meetup_screen.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';
import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: const [ProfileButton(), SizedBox(width: 16)],
        title: const Text('Social'),
        foregroundColor: color.onPrimary,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SocialHeaderCard(),
            SizedBox(height: 16),
            MeetupsButton(),
            SizedBox(height: 24),
            FriendsList(),
            SizedBox(height: 24),
            LeaderboardSection(),
          ],
        ),
      ),
    );
  }
}

class SocialHeaderCard extends StatelessWidget {
  const SocialHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connect & Learn',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Meet with others who want to practice languages'),
        ],
      ),
    );
  }
}

class MeetupsButton extends StatelessWidget {
  const MeetupsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: () {
        adaptiveNavigatorPush(
          context: context,
          builder: (context) => const MeetupScreen(),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color.primary,
        foregroundColor: color.onPrimary,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Find Meetups'),
    );
  }
}

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Friends',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder:
                (_, i) => CircleAvatar(
                  radius: 30,
                  backgroundColor: color.secondary,
                  child: Text(
                    'F$i',
                    style: TextStyle(color: color.onSecondary),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

class LeaderboardSection extends StatefulWidget {
  const LeaderboardSection({super.key});

  @override
  State<LeaderboardSection> createState() => _LeaderboardSectionState();
}

class _LeaderboardSectionState extends State<LeaderboardSection> {
  String selected = 'city';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leaderboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color.onBackground,
          ),
        ),
        const SizedBox(height: 12),
        PlatformLeaderboardToggle(
          selected: selected,
          onChanged: (value) {
            setState(() {
              selected = value!;
            });
          },
        ),
        const SizedBox(height: 12),
        if (selected == 'city') const CityLeaderboard(),
        if (selected == 'country') const CountryLeaderboard(),
      ],
    );
  }
}

class PlatformLeaderboardToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String?> onChanged;

  const PlatformLeaderboardToggle({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (Platform.isIOS) {
      return CupertinoSlidingSegmentedControl<String>(
        groupValue: selected,
        onValueChanged: onChanged,
        children: const {
          'city': Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text('City'),
          ),
          'country': Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text('Kazakhstan'),
          ),
        },
      );
    }

    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'city', label: Text('City')),
        ButtonSegment(value: 'country', label: Text('Kazakhstan')),
      ],
      selected: {selected},
      onSelectionChanged: (v) => onChanged(v.first),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color.surfaceVariant),
        foregroundColor: MaterialStateProperty.all(color.onSurface),
      ),
    );
  }
}

class CityLeaderboard extends StatelessWidget {
  const CityLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'City User ${index + 1}',
              style: TextStyle(color: color.onSurfaceVariant),
            ),
          );
        }),
      ),
    );
  }
}

class CountryLeaderboard extends StatelessWidget {
  const CountryLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'Kazakhstan User ${index + 1}',
              style: TextStyle(color: color.onSurfaceVariant),
            ),
          );
        }),
      ),
    );
  }
}

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color.onBackground,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.primaryContainer,
              child: Icon(Icons.person, color: color.onPrimaryContainer),
            ),
            const SizedBox(width: 12),
            Text(
              'Your Name',
              style: TextStyle(fontSize: 16, color: color.onBackground),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const BadgesGrid(),
      ],
    );
  }
}

class BadgesGrid extends StatelessWidget {
  const BadgesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder:
          (_, i) => Container(
            decoration: BoxDecoration(
              color: color.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Badge ${i + 1}',
                style: TextStyle(color: color.onTertiaryContainer),
              ),
            ),
          ),
    );
  }
}
