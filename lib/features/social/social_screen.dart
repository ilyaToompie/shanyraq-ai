import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/meetup/meetup_screen.dart';
import 'package:shyraq_ai/features/social/voice_chat/voice_chat_screen.dart';
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
                const Row(
                  children: [
                    MeetupsButton(),
                    SizedBox(width: 8),
                    VoiceChatButton(),
                  ],
                ),
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
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

    return Expanded(
      child: ElevatedButton(
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              const Icon(Icons.people_outline_rounded, size: 30),
              const SizedBox(height: 8),
              Text('find-meetups'.tr(), style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class VoiceChatButton extends StatelessWidget {
  const VoiceChatButton({super.key});

  final List<String> uids = const [
    'paGRMah5H5SJsmjEJzNhToPkl5G3',
    'Yon11dr4LScqkuEwyI0NWvmGmsv2',
    '44XFJXl1OSV1NUbbNKjoxt7v8zu2',
    '9IotvoB4iqhrUduA6Ymwf6t5wwr2',
    'fTAOwc6DxUfavYo9yxVtpapQweS2',
    'ueS7HxsQqKdhjVObJLpav0OXCL43',
    'xfWOP170INSMAtCgj8yaW5xJ34C3',
  ];

  /// Loads all users from Firestore using your fetch method
  Future<List<AppUser>> _loadParticipants() async {
    final users = <AppUser>[];
    for (final uid in uids) {
      final user = await fetchUserByUid(uid);
      if (user != null) users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Expanded(
      child: ElevatedButton(
        onPressed: null,
        /*onPressed: () async {
          final participants = await _loadParticipants();
          final elapsed = const Duration(minutes: 32);

          if (context.mounted) {
            adaptiveNavigatorPush(
              context: context,
              builder:
                  (context) => VoiceChatRoom(
                    roomName: 'Играем в слова на Казахском',
                    participants: participants,
                    elapsed: elapsed,
                  ),
            );
          }
        },*/
        style: ElevatedButton.styleFrom(
          backgroundColor: color.primary,
          foregroundColor: color.onPrimary,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              const Icon(Icons.voice_chat, size: 30),
              const SizedBox(height: 8),
              Text('voice_chats'.tr(), style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
