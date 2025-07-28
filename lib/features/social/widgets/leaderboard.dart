import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  Future<List<Map<String, dynamic>>> _fetchUsersInSameRegion() async {
    final uid = fb.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final region = userDoc['region'];
    if (region == null) return [];

    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('region', isEqualTo: region)
            .get();

    final users =
        querySnapshot.docs
            .map((doc) => {'username': doc['username'], 'xp': doc['xp'] ?? 0})
            .toList();

    users.sort((a, b) => (b['xp'] as int).compareTo(a['xp'] as int));
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchUsersInSameRegion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (FirebaseAuth.instance.currentUser == null) {}
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leaderboard (Your Region)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text('No users found in your region.'),
            ],
          );
        }

        final users = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leaderboard (Your Region)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: color.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children:
                    users.map((user) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user['username'],
                              style: TextStyle(color: color.onSurfaceVariant),
                            ),
                            Text(
                              '${user['xp']} XP',
                              style: TextStyle(color: color.onSurfaceVariant),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
