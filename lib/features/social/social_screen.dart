import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/meetup/meetup_screen.dart';
import 'package:shyraq_ai/features/social/widgets/friends_list.dart';
import 'package:shyraq_ai/features/social/widgets/leaderboard.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';
import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return FutureBuilder(
      future: loadUser(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,

            scrolledUnderElevation: 0,
            actions: [
              ProfileButton(user: snapshot.data),
              const SizedBox(width: 16),
            ],
            title: Text('social'.tr()),
            foregroundColor: color.onPrimary,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SocialHeaderCard(),
                const SizedBox(height: 16),
                const MeetupsButton(),
                const SizedBox(height: 24),
                FriendsList(user: snapshot.data),
                const SizedBox(height: 24),
                const Leaderboard(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SocialHeaderCard extends StatelessWidget {
  const SocialHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: MediaQuery.of(context).size.width - 20,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(blurRadius: 4)],
        color: color.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'connect-n-learn'.tr(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('connect-n-learn-desc'.tr()),
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
          builder: (context) => const MeetupsListScreen(),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color.primary,
        foregroundColor: color.onPrimary,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text('find-meetups'.tr()),
    );
  }
}
