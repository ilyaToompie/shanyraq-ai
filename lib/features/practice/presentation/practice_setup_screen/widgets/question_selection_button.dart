import 'package:flutter/material.dart';

class QuestionSelectionButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  const QuestionSelectionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
  });

  @override
  State<QuestionSelectionButton> createState() =>
      _QuestionSelectionButtonState();
}

class _QuestionSelectionButtonState extends State<QuestionSelectionButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.sizeOf(context).width / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color:
            widget.isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withAlpha(150),
      ),
      duration: const Duration(milliseconds: 200),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color:
                    widget.isSelected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.onPrimary,
                size: 48,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
