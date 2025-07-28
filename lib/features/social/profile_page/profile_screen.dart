import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/main_view/main_view.dart';
import 'package:shyraq_ai/features/social/widgets/friend_toggle_button.dart';
import 'package:shyraq_ai/features/social/widgets/friends_list.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';

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
        title: const Text("Profile"),
        actions: [
          if (FirebaseAuth.instance.currentUser != null)
            Row(
              children: [
                if (user.id != FirebaseAuth.instance.currentUser!.uid)
                  FriendToggleButton(user: user),
                if (user.id == FirebaseAuth.instance.currentUser!.uid)
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const MainView()),
                        );
                      }
                    },
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
          Text("XP: ${user.xp}"),
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
