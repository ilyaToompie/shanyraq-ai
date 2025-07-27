import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shyraq_ai/features/users/domain/i_user_repository.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';

class UserRepository implements IUserRepository {
  final _usersRef = FirebaseFirestore.instance.collection('users');
  @override
  Future<void> deleteUser(String id) {
    return _usersRef.doc(id).delete();
  }

  @override
  Stream<List<User>> getAllUsers() {
    return _usersRef.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => User.fromFirestore(doc)).toList(),
    );
  }

  @override
  Future<User?> getUserById(String id) async {
    final doc = await _usersRef.doc(id).get();
    return doc.exists ? User.fromFirestore(doc) : null;
  }

  @override
  Future<List<User?>> getUsersByRegion(String region) async {
    final query = await _usersRef.where('region', isEqualTo: region).get();
    return query.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  @override
  Future<void> updateUser(User user) {
    return _usersRef.doc(user.id).update(user.toMap());
  }
}
