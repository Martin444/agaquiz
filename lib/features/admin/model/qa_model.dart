class QuestionAndAnswer {
  int index;
  String question;
  List<String> answers;

  QuestionAndAnswer({
    required this.index,
    required this.question,
    required this.answers,
  });

  factory QuestionAndAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionAndAnswer(
        index: json['index'],
        question: json['question'],
        answers: List<String>.from(json['answers']),
      );

  Map<String, dynamic> toJson() => {
        'index': index,
        'question': question,
        'answers': List<dynamic>.from(answers),
      };
}
