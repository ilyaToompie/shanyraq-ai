import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';

class AvatarSection extends StatelessWidget {
  final AppUser? user;

  const AvatarSection({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage:
              (user!.avatarUri.isNotEmpty)
                  ? NetworkImage(user!.avatarUri)
                  : const AssetImage('assets/avatar.png') as ImageProvider,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user!.username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your XP: ${user!.xp}",
            ), // Replace with actual XP if you have it
          ],
        ),
      ],
    );
  }
}
