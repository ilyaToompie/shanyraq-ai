import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final int max;
  final int completed;

  const ProgressWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.max,
    required this.completed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.2,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 4, offset: const Offset(2, 2))],
        borderRadius: BorderRadius.circular(48),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Icon(icon, size: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(completed.toString(), style: TextStyle(fontSize: 48)),
                Text(
                  " / $max $title",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.color?.withAlpha(150),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
