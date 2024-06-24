import 'package:agaquiz/features/admin/controllers/admin_controller.dart';
import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminState {
  QuizModel? quizInitial;
  QuizModel? quizEditable;

  bool isLoadingQuestion;

  AdminState({
    this.quizInitial,
    this.quizEditable,
    this.isLoadingQuestion = false,
  });
}

// Define un provider para el estado que quieres manejar
final adminStateProvider =
    StateNotifierProvider<AdminController, AdminState>((ref) {
  return AdminController();
});
