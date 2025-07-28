import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/widgets/adaptive_dialogue.dart';

class FriendToggleButton extends StatefulWidget {
  final AppUser user;

  const FriendToggleButton({super.key, required this.user});

  @override
  State<FriendToggleButton> createState() => _FriendToggleButtonState();
}

class _FriendToggleButtonState extends State<FriendToggleButton> {
  late bool isFriend = false;
  late String currentUid;
  late DocumentReference userDoc;

  @override
  void initState() {
    super.initState();
    currentUid = FirebaseAuth.instance.currentUser!.uid;
    userDoc = FirebaseFirestore.instance.collection('users').doc(currentUid);
    _initFriendStatus();
  }

  Future<void> _initFriendStatus() async {
    final snapshot = await userDoc.get();
    final data = snapshot.data() as Map<String, dynamic>?;
    final currentFriends = List<String>.from(data?['friends'] ?? []);
    setState(() {
      isFriend = currentFriends.contains(widget.user.id);
    });
  }

  Future<void> _toggleFriend() async {
    final action = isFriend ? 'Remove' : 'Add';
    final confirmed = await adaptiveDialog<bool>(
      context: context,
      title: '$action Friend',
      content: 'Do you want to $action ${widget.user.username} as a friend?',
      confirmText: action,
      cancelText: 'Cancel',
    );

    if (confirmed != true) return;

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);
      if (!snapshot.exists) throw Exception("User document not found");

      final data = snapshot.data() as Map<String, dynamic>?;

      final currentFriends = List<String>.from(data?['friends'] ?? []);

      if (isFriend) {
        currentFriends.remove(widget.user.id);
      } else {
        currentFriends.add(widget.user.id);
      }

      transaction.update(userDoc, {'friends': currentFriends});
    });

    setState(() {
      isFriend = !isFriend;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.user.id == currentUid) return const SizedBox();

    return IconButton(
      icon: Icon(
        isFriend ? Icons.person_remove_rounded : Icons.person_add_rounded,
      ),
      onPressed: _toggleFriend,
    );
  }
}
