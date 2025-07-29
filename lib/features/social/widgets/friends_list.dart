import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class FriendsList extends StatelessWidget {
  final AppUser? user;

  const FriendsList({required this.user, super.key});

  Future<List<AppUser>> fetchFriends(List<String> uids) async {
    final firestore = FirebaseFirestore.instance;

    final futures = uids.map((uid) async {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) return AppUser.fromFirestore(doc);
      return null;
    });

    final results = await Future.wait(futures);
    return results.whereType<AppUser>().toList();
  }

  Future<List<AppUser>> fetchSuggested(List<String> excludeUids) async {
    final firestore = FirebaseFirestore.instance;
    final query = await firestore.collection('users').get();

    return query.docs
        .where((doc) => !excludeUids.contains(doc.id))
        .map((doc) => AppUser.fromFirestore(doc))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = user;
    if (currentUser == null) return const SizedBox.shrink();

    final excludeUids = [currentUser.id, ...currentUser.friends];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'friends'.tr(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (FirebaseAuth.instance.currentUser != null)
          FutureBuilder<List<AppUser>>(
            future: fetchFriends(currentUser.friends),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final friends = snapshot.data ?? [];

              return SizedBox(
                height: 80,
                child:
                    friends.isEmpty
                        ? Center(child: Text("no-friends-yet".tr()))
                        : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: friends.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(width: 12),
                          itemBuilder:
                              (_, i) => Container(
                                width: 100,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary.withAlpha(200),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    ProfileButton(user: friends[i]),
                                    Text(friends[i].username),
                                  ],
                                ),
                              ),
                        ),
              );
            },
          ),
        const SizedBox(height: 24),
        Text(
          'suggested-people'.tr(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<AppUser>>(
          future: fetchSuggested(excludeUids),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (FirebaseAuth.instance.currentUser == null) {
              return const SizedBox();
            }
            final currentUid = FirebaseAuth.instance.currentUser!.uid;

            final suggested =
                (snapshot.data ?? []).where((u) => u.id != currentUid).toList();
            if (suggested.isEmpty) {
              return const Text("No suggestions available.");
            }

            return SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: suggested.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) {
                  return Container(
                    width: 100,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withAlpha(200),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        ProfileButton(user: suggested[i]),
                        Text(suggested[i].username),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
