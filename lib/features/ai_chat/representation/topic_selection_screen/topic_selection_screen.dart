import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shyraq_ai/features/ai_chat/representation/ai_chat_screen/ai_chat_screen.dart';
import 'package:shyraq_ai/features/ai_chat/representation/topic_selection_screen/widgets/topic_carousel.dart';
import 'package:shyraq_ai/features/ai_chat/topic.dart';

class TopicSelectionScreen extends StatefulWidget {
  const TopicSelectionScreen({super.key});

  @override
  State<TopicSelectionScreen> createState() => _TopicSelectionScreenState();
}

class _TopicSelectionScreenState extends State<TopicSelectionScreen> {
  final List<String> levels = ['A1', 'A2', 'B1', 'B2', 'C1'];
  String selectedLevel = 'A1';
  List<Topic> topics = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadTopics(selectedLevel);
  }

  Future<void> loadTopics(String level) async {
    final jsonString = await rootBundle.loadString('assets/topics.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    if (jsonMap.containsKey(level)) {
      final List<dynamic> levelList = jsonMap[level];
      setState(() {
        topics = levelList.map((e) => Topic.fromJson(e)).toList();
        currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topic selection')),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(20, 20, 20, 1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            topLeft: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              "Select level",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: _buildLevelSelector(),
            ),
            //CustomTopicCreator(onCreate: (newTopic) {}),
            TopicCarousel(
              onIndexChanged: (int value) {
                setState(() {
                  currentIndex = value;
                });
              },
              topics: topics,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final selectedTopic = topics[currentIndex];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AiChatScreen(topic: selectedTopic),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text('Start Chat'),
                      style: ElevatedButton.styleFrom(
                        overlayColor: Theme.of(context).colorScheme.onPrimary,
                        iconSize: 20,
                        minimumSize: const Size.fromHeight(50),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelSelector() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoSegmentedControl<String>(
        selectedColor: Theme.of(context).colorScheme.surface,
        unselectedColor: Colors.white,
        groupValue: selectedLevel,
        children: {
          for (final level in levels)
            level: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(level, style: TextStyle(color: Colors.black)),
            ),
        },
        onValueChanged: (value) {
          setState(() {
            selectedLevel = value;
            topics = [];
          });
          loadTopics(value);
        },
      );
    } else {
      return ToggleButtons(
        isSelected: levels.map((e) => e == selectedLevel).toList(),
        onPressed: (index) {
          final value = levels[index];
          setState(() {
            selectedLevel = value;
            topics = [];
          });
          loadTopics(value);
        },
        borderRadius: BorderRadius.circular(12),
        selectedColor: Colors.white,
        color: Colors.grey,
        fillColor: Theme.of(context).colorScheme.surface,
        children:
            levels
                .map(
                  (level) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(level),
                  ),
                )
                .toList(),
      );
    }
  }
}
