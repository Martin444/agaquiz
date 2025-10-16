import 'package:agaquiz/features/admin/model/qa_model.dart';

class QuizModel {
  String? logo;
  String description;
  int duration;
  List<QuestionAndAnswer> questionAndAnswer;

  QuizModel({
    this.logo,
    required this.description,
    required this.duration,
    required this.questionAndAnswer,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        logo: json['logo'],
        description: json['description'],
        duration: json['duration'],
        questionAndAnswer: List<QuestionAndAnswer>.from(
          (json['questionandanswer'] as List<dynamic>).map(
            (x) => QuestionAndAnswer.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'logo': logo,
        'description': description,
        'duration': duration,
        'questionandanswer': List<dynamic>.from(
          questionAndAnswer.map((x) => x.toJson()),
        ),
      };
}
