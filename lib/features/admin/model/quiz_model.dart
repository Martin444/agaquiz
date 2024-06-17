import 'package:agaquiz/features/admin/model/qa_model.dart';

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
