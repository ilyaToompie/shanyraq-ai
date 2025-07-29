import 'package:easy_localization/easy_localization.dart';
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
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "mistakes-practice".tr(),
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
                  "practice-desc".tr(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onPrimary,
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
