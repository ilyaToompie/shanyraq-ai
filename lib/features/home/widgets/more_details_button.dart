import 'package:flutter/material.dart';

class MoreDetailsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateColor.resolveWith((states) {
          return Theme.of(context).colorScheme.primary;
        }),
      ),
      onPressed: () {
        null;
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              "More Details",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_circle_right_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
