import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/auth/auth_screen.dart';
import 'package:shyraq_ai/features/social/profile_page/profile_screen.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';

class ProfileButton extends StatelessWidget {
  final AppUser? user;
  const ProfileButton({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircleAvatar(
            minRadius: 16,
            maxRadius: 24,
            child: CircularProgressIndicator(),
          );
        }
        if (user == null) {
          return GestureDetector(
            onTap: () {
              adaptiveNavigatorPush(
                context: context,
                builder: (_) => const AuthScreen(),
              );
            },
            child: const CircleAvatar(
              minRadius: 22,
              maxRadius: 22,

              foregroundImage:
                  const AssetImage('assets/avatar.png') as ImageProvider,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              adaptiveNavigatorPush(
                context: context,
                builder: (_) => ProfileScreen(user: user!),
              );
            },
            child: CircleAvatar(
              minRadius: 22,
              maxRadius: 22,
              foregroundImage:
                  (user!.avatarUri == "")
                      ? const AssetImage('assets/avatar.png') as ImageProvider
                      : NetworkImage(user!.avatarUri),
            ),
          );
        }
      },
    );
  }
}
