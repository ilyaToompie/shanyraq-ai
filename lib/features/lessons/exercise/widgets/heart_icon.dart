import 'package:flutter/material.dart';

class HeartIcon extends StatelessWidget {
  final int hp;

  const HeartIcon({super.key, required this.hp});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.favorite, color: Colors.red),
        const SizedBox(width: 4),
        Text(
          '$hp',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
