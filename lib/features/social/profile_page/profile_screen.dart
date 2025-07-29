import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/main_view/main_view.dart';
import 'package:shyraq_ai/features/social/widgets/friend_toggle_button.dart';
import 'package:shyraq_ai/features/social/widgets/friends_list.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';
import 'package:shyraq_ai/shared/language_selector/language_selector_screen.dart';
import 'package:shyraq_ai/shared/widgets/profile/streak_fire.dart';

class ProfileScreen extends StatelessWidget {
  final AppUser user;

  const ProfileScreen({required this.user, super.key});

  Future<List<AppUser>> fetchFriends(List<String> uids) async {
    final firestore = FirebaseFirestore.instance;

    final futures = uids.map((uid) async {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromFirestore(doc);
      }
      return null;
    });

    final results = await Future.wait(futures);
    return results.whereType<AppUser>().toList();
  }

  @override
  Widget build(BuildContext context) {
    final avatar =
        user.avatarUri.isEmpty ? 'assets/avatar.png' : user.avatarUri;

    return Scaffold(
      appBar: AppBar(
        title: Text("profile".tr()),
        actions: [
          if (FirebaseAuth.instance.currentUser != null)
            Row(
              children: [
                if (user.id != FirebaseAuth.instance.currentUser!.uid)
                  FriendToggleButton(user: user),
                if (user.id == FirebaseAuth.instance.currentUser!.uid)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.language_rounded),
                        onPressed: () {
                          if (context.mounted) {
                            adaptiveNavigatorPush(
                              context: context,
                              builder: (context) => const LanguageSelector(),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const MainView(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
              ],
            ),

          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 48,
            backgroundImage:
                avatar.startsWith('http')
                    ? NetworkImage(avatar)
                    : AssetImage(avatar) as ImageProvider,
          ),
          const SizedBox(height: 12),
          Text(
            user.username,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.xp.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  const Text("XP", style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(width: 48),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: StreakFire(days: 2, isActive: true),
                  ),
                  SizedBox(height: 4),
                  Text("day-streak".tr(), style: TextStyle(fontSize: 24)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (FirebaseAuth.instance.currentUser != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FriendsList(user: user),
            ),
        ],
      ),
    );
  }
}
