import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';

class CustomTopicCreator extends StatefulWidget {
  final void Function(Topic) onCreate;

  const CustomTopicCreator({super.key, required this.onCreate});

  @override
  State<CustomTopicCreator> createState() => _CustomTopicCreatorState();
}

class _CustomTopicCreatorState extends State<CustomTopicCreator> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  /*
  void _submit() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) return;

    widget.onCreate(Topic(title: title, description: desc));

    _titleController.clear();
    _descController.clear();
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Create Custom Topic",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
