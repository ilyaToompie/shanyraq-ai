import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shyraq_ai/features/users/domain/user.dart';
import 'package:shyraq_ai/shared/widgets/profile/profile_button.dart';

class VoiceChatRoom extends StatelessWidget {
  final String roomName;
  final List<AppUser> participants; // already fetched using your methods
  final Duration elapsed;

  const VoiceChatRoom({
    super.key,
    required this.roomName,
    required this.participants,
    required this.elapsed,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          children: [
            // Timer and room name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    roomName,
                    style: TextStyle(
                      color: Colors.greenAccent.shade400,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDuration(elapsed),
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Circle of participants
            Expanded(
              child: Center(child: _buildParticipantsLayout(participants)),
            ),
            // Controls
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _controlButton(
                    icon: Icons.mic_off,
                    color: Colors.grey.shade800,
                    onPressed: () {},
                  ),
                  _controlButton(
                    icon: Icons.call_end,
                    color: Colors.redAccent,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantsLayout(List<AppUser> users) {
    final count = users.length;

    if (count == 0) {
      return const Text(
        'Нет участников',
        style: TextStyle(color: Colors.white70),
      );
    }
    if (count == 1) {
      return ProfileButton(maxRadius: 30.0, user: users[0]);
    }
    if (count == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            users
                .map(
                  (u) => Padding(
                    padding: const EdgeInsets.all(12),
                    child: ProfileButton(maxRadius: 30.0, user: u),
                  ),
                )
                .toList(),
      );
    }
    if (count == 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileButton(maxRadius: 30.0, user: users[0]),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                users.sublist(1).map((u) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: ProfileButton(maxRadius: 30.0, user: u),
                  );
                }).toList(),
          ),
        ],
      );
    }

    // 4+ users — ровный круг
    const double size = 300;
    final double radius = size / 2 - 40; // отступ от краёв
    final double center = size / 2;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: List.generate(count, (i) {
          final angle = (2 * math.pi * i) / count;
          final double dx = center + radius * math.cos(angle) - 30;
          final double dy = center + radius * math.sin(angle) - 30;
          return Positioned(
            left: dx,
            top: dy,
            child: ProfileButton(maxRadius: 30.0, user: users[i]),
          );
        }),
      ),
    );
  }

  Widget _controlButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}';
  }
}

// Helper trig functions (no dart:math import requirement here)
double MathSin(double x) =>
    (x - (x * x * x) / 6 + (x * x * x * x * x) / 120); // approx
double MathCos(double x) => (1 - (x * x) / 2 + (x * x * x * x) / 24);
