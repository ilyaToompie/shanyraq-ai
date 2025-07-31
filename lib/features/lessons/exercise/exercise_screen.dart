import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/features/lessons/exercise/exercise_question.dart';
import 'package:shyraq_ai/features/lessons/exercise/result_screen.dart';

class ExerciseScreen extends StatefulWidget {
  final String topic;
  final int questionCount;
  final int xpReward;

  const ExerciseScreen({
    Key? key,
    required this.topic,
    required this.questionCount,
    required this.xpReward,
  }) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<ExerciseQuestion>> _questionsFuture;
  int _currentIndex = 0;
  int _score = 0;
  final List<String> _userAnswers = [];
  bool _hasAnswered = false;
  bool _lastAnswerCorrect = false;
  String _correctAnswerKey = '';
  String _selectedKey = '';
  int _hp = 10;

  late AnimationController _hpShakeController;
  late Animation<double> _hpShakeAnimation;

  @override
  void initState() {
    super.initState();
    _questionsFuture = loadShuffledQuestions(
      widget.topic,
      widget.questionCount,
    );
    _hpShakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _hpShakeAnimation = Tween<double>(
      begin: 0,
      end: 12,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_hpShakeController);
  }

  @override
  void dispose() {
    _hpShakeController.dispose();
    super.dispose();
  }

  void _submitAnswer(String selectedKey, ExerciseQuestion question) {
    final isCorrect = selectedKey == question.correctOptionKey;

    setState(() {
      _hasAnswered = true;
      _selectedKey = selectedKey;
      _lastAnswerCorrect = isCorrect;
      _correctAnswerKey = question.options[question.correctOptionKey]!.tr();

      if (isCorrect) {
        _score++;
      } else {
        _hp--;
        _hpShakeController.forward(from: 0);
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      _userAnswers.add(_selectedKey);
      _currentIndex++;
      _hasAnswered = false;
      _selectedKey = '';
    });
  }

  bool _allOptionsAreShort(Map<String, String> options) {
    return options.values.every((opt) => opt.tr().length <= 16);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExerciseQuestion>>(
      future: _questionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('error_loading'.tr()));
        }

        final questions = snapshot.data!;
        if (_currentIndex >= questions.length || _hp <= 0) {
          return ResultScreen(
            widget.xpReward,
            score: _score,
            total: questions.length,
          );
        }

        final question = questions[_currentIndex];
        final optionKeys = question.options.keys.toList();
        final bool useGrid = _allOptionsAreShort(question.options);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                '${_currentIndex + 1} / ${questions.length}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          AnimatedBuilder(
                            animation: _hpShakeAnimation,
                            builder: (context, child) {
                              final offset =
                                  math.sin(_hpShakeAnimation.value) * 5;
                              return Transform.translate(
                                offset: Offset(offset, 0),
                                child: child,
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.favorite, color: Colors.red),
                                const SizedBox(width: 4),

                                Text(
                                  '$_hp',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(32),
                        value: (_currentIndex + 1) / questions.length,
                        minHeight: 16,
                        backgroundColor: Colors.grey[300],
                        color: Colors.black.withAlpha(140),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        question.questionKey.tr(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      useGrid
                          ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: optionKeys.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 2.5,
                                ),
                            itemBuilder: (context, index) {
                              final key = optionKeys[index];
                              return ElevatedButton(
                                onPressed:
                                    _hasAnswered
                                        ? null
                                        : () => _submitAnswer(key, question),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                  ),
                                  textStyle: const TextStyle(fontSize: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  '${optionKeys.indexOf(key) + 1}. ${question.options[key]!.tr()}',
                                ),
                              );
                            },
                          )
                          : Column(
                            children:
                                optionKeys.asMap().entries.map((entry) {
                                  final key = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: ElevatedButton(
                                      onPressed:
                                          _hasAnswered
                                              ? null
                                              : () =>
                                                  _submitAnswer(key, question),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                          horizontal: 24,
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        '${optionKeys.indexOf(key) + 1}. ${question.options[key]!.tr()}',
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: _hasAnswered ? 0 : -200,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _hasAnswered ? 1 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                _lastAnswerCorrect
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    _lastAnswerCorrect
                                        ? Colors.green
                                        : Colors.red,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _lastAnswerCorrect
                                          ? 'correct'.tr()
                                          : 'incorrect'.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            _lastAnswerCorrect
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                    if (!_lastAnswerCorrect)
                                      Text(
                                        'correct_answer_was'.tr(
                                          args: [_correctAnswerKey],
                                        ),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 36),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _goToNextQuestion,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('next'.tr()),
                            ),
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
