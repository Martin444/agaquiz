import 'package:agaquiz/features/admin/model/answer_model.dart';

class QuestionAndAnswer {
  int index;
  String question;
  List<AnswerModel> answers;

  QuestionAndAnswer({
    required this.index,
    required this.question,
    required this.answers,
  });

  factory QuestionAndAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionAndAnswer(
        index: json['index'],
        question: json['question'],
        answers: (json['answers'] as List<dynamic>)
            .map((answerJson) => AnswerModel.fromJson(answerJson))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'index': index,
        'question': question,
        'answers': answers.map((answer) => answer.toJson()).toList(),
      };
}
