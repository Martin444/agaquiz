import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:agaquiz/features/on_boarding/controllers/on_boarding_game_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardinGameState {
  QuizModel? quizInitial;
  QuizModel? quizEditable;

  bool isLoadingQuestion;

  OnBoardinGameState({
    this.quizInitial,
    this.quizEditable,
    this.isLoadingQuestion = false,
  });
}

// Define un provider para el estado que quieres manejar
final adminStateProvider =
    StateNotifierProvider<OnBoardingGameController, OnBoardinGameState>((ref) {
  return OnBoardingGameController();
});
