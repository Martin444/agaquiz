import 'package:agaquiz/features/admin/controllers/admin_controller.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminState {
  QuizModel? quizInitial;
  QuizModel? quizEditable;

  bool isLoadingLogo;
  bool isLoadingQuestion;

  AdminState({
    this.quizInitial,
    this.quizEditable,
    this.isLoadingLogo = false,
    this.isLoadingQuestion = false,
  });

  AdminState copyWith({
    QuizModel? quizInitial,
    QuizModel? quizEditable,
    bool? isLoadingLogo,
    bool? isLoadingQuestion,
  }) {
    return AdminState(
      quizInitial: quizInitial ?? this.quizInitial,
      quizEditable: quizEditable ?? this.quizEditable,
      isLoadingLogo: isLoadingLogo ?? this.isLoadingLogo,
      isLoadingQuestion: isLoadingQuestion ?? this.isLoadingQuestion,
    );
  }
}

// Define un provider para el estado que quieres manejar
final adminStateProvider = StateNotifierProvider<AdminController, AdminState>((ref) {
  return AdminController();
});
