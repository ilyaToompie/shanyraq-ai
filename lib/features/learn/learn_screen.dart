import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shyraq_ai/features/learn/widgets/lesson_info_widget.dart';
import 'package:shyraq_ai/features/learn/widgets/lessons_map.dart';

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

  late OverlayEntry lessonOverlay;

  void showLessonOverlay(BuildContext context, Map<String, dynamic> lesson) {
    lessonOverlay = OverlayEntry(
      builder:
          (_) => LessonInfoWidget(
            lesson: lesson,
            onClose: () => lessonOverlay.remove(),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(lessonOverlay);
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
        automaticallyImplyLeading: false,

        scrolledUnderElevation: 0,
        title: Text("learn".tr(), style: const TextStyle(fontSize: 32)),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("todays-plan".tr(), style: TextStyle(fontSize: 32)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "todays-plan-desc".tr(),
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
              ),
              const SizedBox(height: 12),
              LessonsMap(),
            ],
          ),
        ],
      ),
    );
  }
}
