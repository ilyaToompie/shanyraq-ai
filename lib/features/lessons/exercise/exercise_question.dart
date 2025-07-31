import 'dart:convert';
import 'package:flutter/services.dart';

class ExerciseQuestion {
  final String questionKey;
  final Map<String, String> options; // option1..option4 keys
  final String correctOptionKey; // 'option1', 'option2', 'option3', 'option4'

  ExerciseQuestion({
    required this.questionKey,
    required this.options,
    required this.correctOptionKey,
  });

  factory ExerciseQuestion.fromJson(Map<String, dynamic> json) {
    return ExerciseQuestion(
      questionKey: json['question-key'] as String,
      options: {
        'option1': json['option1'] as String,
        'option2': json['option2'] as String,
        'option3': json['option3'] as String,
        'option4': json['option4'] as String,
      },
      correctOptionKey: json['correct_answer'] as String,
    );
  }
}

Future<List<ExerciseQuestion>> loadShuffledQuestions(
  String topic,
  int count,
) async {
  final jsonStr = await rootBundle.loadString(
    'assets/problems/lessons/problems_demo.json',
  );
  final Map<String, dynamic> data = jsonDecode(jsonStr);

  final Map<String, dynamic> topicData = data[topic] as Map<String, dynamic>;

  final questions =
      topicData.values
          .map((q) => ExerciseQuestion.fromJson(q as Map<String, dynamic>))
          .toList();

  questions.shuffle();

  return questions.take(count).toList();
}
