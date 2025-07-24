import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';

class ChatTopicWidget extends StatefulWidget {
  final Topic topic;

  const ChatTopicWidget({super.key, required this.topic});

  @override
  State<ChatTopicWidget> createState() => _ChatTopicWidgetState();
}

class _ChatTopicWidgetState extends State<ChatTopicWidget> {
  late Future<Topic?> topicFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueGrey.shade100),
      ),
      child: Column(
        children: [
          Text(
            widget.topic.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 20, indent: 20, endIndent: 20),
          Text(widget.topic.description, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Topic?>(
      future: topicFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No topic found for this level.');
        } else {
          final topic = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blueGrey.shade100),
            ),
            child: Column(
              children: [
                Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 20, indent: 20, endIndent: 20),
                Text(topic.description, style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        }
      },
    );
  }*/
}
