import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shyraq_ai/features/users/data/kazakhCities.dart';
import 'package:shyraq_ai/features/users/data/user_repository.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final UserRepository _userRepository = UserRepository();
  String? _userRegionKey;
  String _selectedScope = 'user';
  bool _regionError = false;

  Future<void> _fetchUserRegion() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      if (mounted) setState(() => _regionError = true);
      return;
    }

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final regionKey = doc.data()?['region'];
    if (mounted) {
      if (regionKey != null && kazakhstan_cities.containsKey(regionKey)) {
        setState(() {
          _userRegionKey = regionKey;
          _regionError = false;
        });
      } else {
        setState(() => _regionError = true);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserRegion();
  }

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot;

    if (_selectedScope == 'kazakhstan' ||
        _regionError ||
        _userRegionKey == null) {
      snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .orderBy('xp', descending: true)
              .limit(50)
              .get();
    } else {
      snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('region', isEqualTo: _userRegionKey)
              .orderBy('xp', descending: true)
              .limit(50)
              .get();
    }

    return snapshot.docs.map((doc) {
      return {
        'uid': doc.id,
        'username': doc['username'],
        'xp': doc['xp'] ?? 0,
        'region': doc['region'],
      };
    }).toList();
  }

  String? _getCityName(String? key) {
    return kazakhstan_cities[key]?[context.locale.languageCode] ?? null;
  }

  Widget _buildRegionNotice() {
    if (_selectedScope == 'user' && _regionError) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'please-login-to-view-leaders'.tr(),
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'xp-leaderboard'.tr(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getCityName(_userRegionKey) != null
                ? CupertinoSegmentedControl<String>(
                  groupValue: _selectedScope,
                  children: {
                    'user': Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(_getCityName(_userRegionKey)!),
                    ),
                    'kazakhstan': Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('kazakhstan'.tr()),
                    ),
                  },
                  onValueChanged: (value) {
                    setState(() => _selectedScope = value);
                  },
                )
                : Text(
                  'kazakhstan'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ],
        ),
        _buildRegionNotice(),
        const SizedBox(height: 12),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final users = snapshot.data ?? [];

            if (users.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('No users found.'),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'top-50-users'.tr(
                      args: [
                        if (_selectedScope != 'kazakhstan')
                          _getCityName(_userRegionKey) != null
                              ? _getCityName(_userRegionKey)!
                              : 'kazakhstan'.tr(),
                        if (_selectedScope == 'kazakhstan') 'kazakhstan'.tr(),
                      ],
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(20),
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
                                Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    FutureBuilder<AppUser?>(
                                      future: _userRepository.getUserById(
                                        user['uid'],
                                      ),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const SizedBox.shrink();
                                        }
                                        return ProfileButton(
                                          user: snapshot.data!,
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user['username'],
                                          style: TextStyle(
                                            color: color.onSurfaceVariant,
                                          ),
                                        ),
                                        if (_selectedScope == 'kazakhstan')
                                          Text(
                                            _getCityName(user['region'])!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: color.onSurfaceVariant
                                                  .withAlpha(140),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  '${user['xp']} XP',
                                  style: TextStyle(
                                    color: color.onSurfaceVariant,
                                  ),
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
        ),
      ],
    );
  }
}
