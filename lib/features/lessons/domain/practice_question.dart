class PracticeQuestion {
  final int id;
  final String question;
  final List<String> options;
  final String answer;
  final String topic;

  PracticeQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
    required this.topic,
  });

  factory PracticeQuestion.fromJson(Map<String, dynamic> json) {
    return PracticeQuestion(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
      topic: json['topic'],
    );
  }
}
