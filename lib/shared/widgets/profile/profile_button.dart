import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/auth/auth_screen.dart';
import 'package:shyraq_ai/features/social/profile_page/profile_screen.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';

class ProfileButton extends StatelessWidget {
  final AppUser? user;
  final double maxRadius;

  const ProfileButton({super.key, required this.user, this.maxRadius = 22});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: loadUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            minRadius: 16,
            maxRadius: maxRadius,
            child: const CircularProgressIndicator(),
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
            child: CircleAvatar(
              minRadius: maxRadius - 2,
              maxRadius: maxRadius,
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
              minRadius: maxRadius - 2,
              maxRadius: maxRadius,
              foregroundImage:
                  (user!.avatarUri.isEmpty)
                      ? const AssetImage('assets/avatar.png') as ImageProvider
                      : NetworkImage(user!.avatarUri),
            ),
          );
        }
      },
    );
  }
}
