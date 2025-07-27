import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String id;
  final String region;
  final Uri avatarUri;
  User({
    required this.name,
    required this.email,
    required this.id,
    required this.avatarUri,
    required this.region,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      region: data['region'] ?? '',
      id: doc.id,
      avatarUri: data['avatarUri'] ?? '',
    );
  }
  Map<String, dynamic> toMap() => {'name': name, 'email': email};
}
