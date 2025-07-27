import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final List<Map<String, dynamic>> lessons = [];
  Map<String, dynamic>? selectedLesson;

  @override
  void initState() {
    super.initState();
    loadLessonsFromAsset();
  }

  Future<void> loadLessonsFromAsset() async {
    final jsonString = await rootBundle.loadString('assets/lessons.json');
    final data = json.decode(jsonString) as List;
    setState(() {
      lessons.addAll(data.cast<Map<String, dynamic>>());
    });
  }

  void showLessonInfo(Map<String, dynamic> lesson) {
    setState(() => selectedLesson = lesson);
  }

  void closeLessonInfo() {
    setState(() => selectedLesson = null);
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(
      context,
    ).textTheme.bodyLarge?.color?.withAlpha(180);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("Learn", style: TextStyle(fontSize: 42)),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                const Text("Today's plan", style: TextStyle(fontSize: 48)),
                Text(
                  "Look, we've selected lessons specialy for You!",
                  style: TextStyle(fontSize: 25, color: textColor),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      final isLast = index == lessons.length - 1;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => showLessonInfo(lesson),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${lesson['id']}",
                                        style: const TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (!isLast)
                                      Container(
                                        width: 4,
                                        height: 40,
                                        color: Colors.blueAccent.withOpacity(
                                          0.4,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    lesson['title'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          /// Bottom popup panel with lesson info
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            bottom: selectedLesson == null ? -300 : 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 12,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child:
                    selectedLesson == null
                        ? const SizedBox.shrink()
                        : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    selectedLesson!['title'],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: closeLessonInfo,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              selectedLesson!['description'],
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "XP: ${selectedLesson!['xp']}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                disabledBackgroundColor: Colors.blue
                                    .withOpacity(0.6),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Start Lesson",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
