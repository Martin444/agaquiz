import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:flutter/material.dart';

abstract class AdminStateManage extends ChangeNotifier {
  QuizModel? quizInitial;
  TextEditingController descriptionQuiz = TextEditingController();
  TextEditingController durationQuiz = TextEditingController();

  List<QuestionAndAnswer>? listQuestion;

  bool isLoadingQuestion = false;

  void getData();
}
