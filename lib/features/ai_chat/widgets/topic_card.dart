import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final int? index;
  const TopicCard({super.key, required this.topic, required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textAlign: TextAlign.center,
            topic.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            topic.description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          if (index != null)
            Align(
              alignment: Alignment.bottomLeft,
              child: Text("#${index! + 1}"),
            ),
        ],
      ),
    );
  }
}
