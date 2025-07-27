import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/social/profile_page/profile_screen.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return GestureDetector(
        child: const CircleAvatar(
          radius: 24,
          foregroundImage: const AssetImage('assets/avatar.png'),
        ),
        onTap: () {
          adaptiveNavigatorPush(
            context: context,
            builder: (context) => const ProfileScreen(),
          );
        },
      );
    }
    return GestureDetector(
      child: const CircleAvatar(
        radius: 24,
        foregroundImage: const AssetImage('assets/avatar.png'),
      ),
      onTap: () {
        adaptiveNavigatorPush(
          context: context,
          builder: (context) => const ProfileScreen(),
        );
      },
    );
  }
}
