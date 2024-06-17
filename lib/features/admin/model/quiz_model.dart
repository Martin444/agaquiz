class QuizModel {
  String description;
  int duration;
  List<QuestionAndAnswer> questionAndAnswer;

  QuizModel({
    required this.description,
    required this.duration,
    required this.questionAndAnswer,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        description: json['description'],
        duration: json['duration'],
        questionAndAnswer: List<QuestionAndAnswer>.from(
          json['questionandanswer'].map(
            (x) => QuestionAndAnswer.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'duration': duration,
        'questionandanswer': List<dynamic>.from(
          questionAndAnswer.map((x) => x.toJson()),
        ),
      };
}

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
