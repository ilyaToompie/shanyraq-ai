class Topic {
  final String title;
  final String description;

  Topic({required this.title, required this.description});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(title: json['title'], description: json['description']);
  }
}
