import 'package:agaquiz/features/admin/controllers/admin_controller.dart';
import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminState {
  QuizModel? quizInitial;
  TextEditingController? descriptionQuiz;
  TextEditingController? durationQuiz;

  List<QuestionAndAnswer>? listQuestion;

  bool? isLoadingQuestion;

  AdminState({
    this.quizInitial,
    this.descriptionQuiz,
    this.durationQuiz,
    this.listQuestion,
    this.isLoadingQuestion,
  });
}

// Define un provider para el estado que quieres manejar
final adminStateProvider =
    StateNotifierProvider<AdminController, AdminState>((ref) {
  return AdminController();
});
