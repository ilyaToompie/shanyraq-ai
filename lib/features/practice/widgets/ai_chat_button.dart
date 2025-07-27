import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/representation/topic_selection_screen/topic_selection_screen.dart';
import 'package:shyraq_ai/shared/adaptive_navigator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AiChatButton extends StatelessWidget {
  const AiChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        adaptiveNavigatorPush(
          context: context,
          builder: (context) => const TopicSelectionScreen(),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        width: MediaQuery.of(context).size.width - 20,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: FaIcon(
                      FontAwesomeIcons.solidMessage,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    "Chat with an AI",
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    "Chat with an AI to practice dialogue! \nUse pre-made topics.",
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
      ),
    );
  }
}
