import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/social/widgets/leaderboard.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  int gainedXp;

  ResultScreen(
    this.gainedXp, {
    super.key,
    required this.score,
    required this.total,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late ConfettiController _confetti;
  late AnimationController _xpController;
  late Animation<int> _xpAnimation;

  bool _showLeaderboard = false;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: Duration(seconds: 2))..play();
    widget.gainedXp = widget.score * 10;

    _xpController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _loadAndAnimateXp();
  }

  Future<void> _loadAndAnimateXp() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
    final snapshot = await userDoc.get();
    final oldXp = snapshot.data()?['xp'] ?? 0;
    final newXp = oldXp + widget.gainedXp;

    _xpAnimation = IntTween(
      begin: oldXp,
      end: newXp,
    ).animate(CurvedAnimation(parent: _xpController, curve: Curves.easeOut));

    await userDoc.update({'xp': newXp});
    await _xpController.forward();

    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      _showLeaderboard = true;
    });
  }

  @override
  void dispose() {
    _confetti.dispose();
    _xpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confetti,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '🎉 ${'congrats'.tr()}',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Результат: ${widget.score} / ${widget.total}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Исправлено ошибок: ${widget.total - widget.score} / ${widget.total - widget.score}',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              Text(
                '+${widget.gainedXp} XP',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _xpController,
                builder: (context, child) {
                  if (!_xpController.isAnimating && !_showLeaderboard) {
                    return const SizedBox(height: 36); // placeholder
                  }
                  return Column(
                    children: [
                      Text(
                        '${_xpAnimation.value}',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text('current_xp'.tr(), style: TextStyle(fontSize: 16)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text(
                    'back'.tr(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AnimatedOpacity(
                opacity: _showLeaderboard ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                child: _showLeaderboard ? Leaderboard() : SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
