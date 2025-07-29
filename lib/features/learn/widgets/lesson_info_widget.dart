import 'package:flutter/material.dart';

class LessonInfoWidget extends StatefulWidget {
  final Map<String, dynamic> lesson;
  final VoidCallback onClose;

  const LessonInfoWidget({
    super.key,
    required this.lesson,
    required this.onClose,
  });

  @override
  State<LessonInfoWidget> createState() => _LessonInfoWidgetState();
}

class _LessonInfoWidgetState extends State<LessonInfoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _slide = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.reverse().then((_) => widget.onClose());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.black.withAlpha(80),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _close,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: SlideTransition(
                    position: _slide,
                    child: Material(
                      elevation: 12,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.lesson['title'],
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: _close,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.lesson['description'],
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "XP: ${widget.lesson['xp']}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
