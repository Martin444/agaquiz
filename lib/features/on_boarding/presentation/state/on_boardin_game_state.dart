import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:agaquiz/features/on_boarding/controllers/on_boarding_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardinGameState {
  QuizModel? quizInitial;
  QuizModel? quizEditable;
  PageController? questionScrollController = PageController();
  List<QuestionAndAnswer>? corrects;
  List<QuestionAndAnswer>? incorrects;

  bool isLoadingQuestion;

  OnBoardinGameState({
    this.quizInitial,
    this.quizEditable,
    this.isLoadingQuestion = false,
    this.questionScrollController,
    this.corrects,
    this.incorrects,
  });

  bool getIndexAnswer(int id) {
    return false;
  }
}

// Define un provider para el estado que quieres manejar
final onBoardingStateProvider =
    StateNotifierProvider<OnBoardingGameController, OnBoardinGameState>((ref) {
  return OnBoardingGameController();
});
