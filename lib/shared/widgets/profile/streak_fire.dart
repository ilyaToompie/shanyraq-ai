import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StreakFire extends StatelessWidget {
  final int days;
  final bool isActive;

  const StreakFire({super.key, required this.days, required this.isActive});

  void _showInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // чтобы можно было плавно появляться
      backgroundColor: Colors.transparent, // чтобы скругление выглядело красиво
      builder: (_) => const _BottomSheetWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showInfo(context),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/streak_fire.png',
            color: isActive ? null : Colors.grey,
            fit: BoxFit.fill,
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Text(
                    "$days",
                    style: TextStyle(
                      fontSize: 20,
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.black,
                    ),
                  ),
                  Text(
                    "$days",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetWrapper extends StatelessWidget {
  const _BottomSheetWrapper();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 460, // зафиксируй нужную высоту
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: StreakFireInfo(),
      ),
    );
  }
}

class StreakFireInfo extends StatelessWidget {
  const StreakFireInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Text("streak-fire".tr(), style: TextStyle(fontSize: 32)),
          const SizedBox(height: 32),
          Image.asset('assets/images/streak_fire.png', width: 100, height: 100),
          const SizedBox(height: 32),
          Text(
            "streak-info".tr(),
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Закрыть'),
            ),
          ),
        ],
      ),
    );
  }
}
