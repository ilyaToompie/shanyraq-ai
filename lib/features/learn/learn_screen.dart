import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shyraq_ai/features/learn/widgets/lesson_info_widget.dart';

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
        title: Text("learn".tr(), style: TextStyle(fontSize: 34)),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("todays-plan".tr(), style: TextStyle(fontSize: 48)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "todays-plan-desc".tr(),
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  color: Colors.black.withAlpha(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.1, 0.9, 1.0],
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          child: ListView.builder(
                            itemCount: lessons.length,
                            itemBuilder: (context, index) {
                              final lesson = lessons[index];
                              final isLast = index == lessons.length - 1;

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap:
                                        () =>
                                            showLessonOverlay(context, lesson),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12.0,
                                                  ),
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      spreadRadius: 0.1,
                                                      blurRadius: 2.5,
                                                    ),
                                                  ],
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                            ),
                                            if (!isLast)
                                              Container(
                                                width: 4,
                                                height: 40,
                                                color: Colors.blueAccent
                                                    .withAlpha(80),
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
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
