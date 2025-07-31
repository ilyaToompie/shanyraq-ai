import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String username;
  final String email;
  final String id;
  final String region;
  final String avatarUri;
  final List<String> friends;
  final int xp;
  final int streak;
  AppUser({
    required this.username,
    required this.email,
    required this.id,
    required this.avatarUri,
    required this.region,
    required this.friends,
    required this.xp,
    required this.streak,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      region: data['region'] ?? '',
      id: doc.id,
      avatarUri: data['avatarUri'] ?? '',
      xp: data['xp'] ?? 0,
      friends: List<String>.from(data['friends'] ?? []),
      streak:
          (data['streak'] is int)
              ? data['streak']
              : int.tryParse(data['streak'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {'name': username, 'email': email};
}

Future<AppUser?> fetchUserByUid(String uid) async {
  final doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

  if (!doc.exists) return null;

  return AppUser.fromFirestore(doc);
}

Future<AppUser?> loadUser() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return null;
  return await fetchUserByUid(uid);
}
