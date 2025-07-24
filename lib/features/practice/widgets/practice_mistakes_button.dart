import 'package:flutter/material.dart';

class PracticeMistakesButton extends StatefulWidget {
  final bool isSelected;
  const PracticeMistakesButton({super.key, required this.isSelected});

  @override
  State<PracticeMistakesButton> createState() => _PracticeMistakesButtonState();
}

class _PracticeMistakesButtonState extends State<PracticeMistakesButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color:
            widget.isSelected
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withAlpha(150),
      ),
      width: MediaQuery.of(context).size.width - 20,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Mistakes practice",
                  style: TextStyle(
                    fontSize: 30,
                    color:
                        widget.isSelected
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "Practive more the very exam exercices which\nyou're doing worse. You're gonna deal with it!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
