import 'dart:convert';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shyraq_ai/features/lessons/domain/practice_question.dart';
import 'package:shyraq_ai/features/practice/presentation/practice_screen/widgets/practicing_result_screen.dart';

class PracticeScreen extends StatefulWidget {
  final int practiceType;
  final String? selectedTopic;

  const PracticeScreen({
    super.key,
    required this.practiceType,
    this.selectedTopic,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late Future<List<PracticeQuestion>> _futureQuestions;
  late PageController _pageController;
  List<PracticeQuestion> _questions = [];
  final Map<int, String> _selectedAnswers = {};
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _futureQuestions = _loadQuestions();
  }

  Future<List<PracticeQuestion>> _loadQuestions() async {
    final String rawJson = await rootBundle.loadString(
      'assets/problems/practicing/problems.json',
    );
    final List<dynamic> decoded = json.decode(rawJson);

    final typeBlock = decoded.firstWhere(
      (e) => e['type'] == widget.practiceType,
      orElse: () => null,
    );

    if (typeBlock == null) throw Exception("No matching type found");

    List<dynamic> rawProblems = typeBlock['problems'];
    List<PracticeQuestion> questions =
        rawProblems.map((p) => PracticeQuestion.fromJson(p)).toList();

    if (widget.practiceType == 2 && widget.selectedTopic != null) {
      questions =
          questions.where((q) => q.topic == widget.selectedTopic).toList();
    }

    questions.shuffle(Random());
    return questions.take(10).toList();
  }

  void _handleAnswer(int index, String selected) {
    if (_selectedAnswers.containsKey(index)) return;

    final correct = _questions[index].answer;
    if (selected == correct) {
      _score++;
    }

    setState(() {
      _selectedAnswers[index] = selected;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      if (index < _questions.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => PracticeResultScreen(score: _score),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('practice'.tr())),
      body: FutureBuilder<List<PracticeQuestion>>(
        future: _futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          _questions = snapshot.data!;

          return PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              final q = _questions[index];
              final selected = _selectedAnswers[index];
              final isAnswered = selected != null;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    Text(
                      "Сұрақ ${index + 1}/${_questions.length}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(q.question, style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 24),
                    ...q.options.map((opt) {
                      Color color = Colors.white; // default color is white
                      if (isAnswered) {
                        if (opt == q.answer) {
                          color = Colors.green;
                        } else if (opt == selected) {
                          color = Colors.red;
                        }
                      }

                      return Card(
                        color: color,
                        child: ListTile(
                          title: Text(opt),
                          onTap:
                              isAnswered
                                  ? null
                                  : () => _handleAnswer(index, opt),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                    Text(
                      "Тақырып: ${q.topic}",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
