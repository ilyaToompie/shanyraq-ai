import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shyraq_ai/features/users/domain/i_user_repository.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';

class UserRepository implements IUserRepository {
  final _usersRef = FirebaseFirestore.instance.collection('users');
  @override
  Future<void> deleteUser(String id) {
    return _usersRef.doc(id).delete();
  }

  @override
  Stream<List<AppUser>> getAllUsers() {
    return _usersRef.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => AppUser.fromFirestore(doc)).toList(),
    );
  }

  @override
  Future<AppUser?> getUserById(String id) async {
    final doc = await _usersRef.doc(id).get();
    return doc.exists ? AppUser.fromFirestore(doc) : null;
  }

  @override
  Future<List<AppUser>> getUsersByRegion(String region) async {
    final query = await _usersRef.where('region', isEqualTo: region).get();
    return query.docs.map((doc) => AppUser.fromFirestore(doc)).toList();
  }

  @override
  Future<void> upsertUser(String userId, Map<String, dynamic> userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData, SetOptions(merge: true));
  }

  Future<AppUser?> getCurrentUser() async {
    final currentUser = auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
    if (!doc.exists) return null;
    return AppUser.fromFirestore(doc);
  }

  Future<void> createUserDocument(
    String uid,
    String email,
    String username,
    String region,
  ) {
    return FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
      'username': username,
      'region': 'region',
      'xp': 0,
      'friends': [],
    });
  }
}
