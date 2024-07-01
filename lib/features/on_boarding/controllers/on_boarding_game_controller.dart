import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/on_boarding/presentation/state/on_boardin_game_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../admin/model/quiz_model.dart';

class OnBoardingGameController extends StateNotifier<OnBoardinGameState> {
  OnBoardingGameController() : super(OnBoardinGameState()) {
    _init();
  }

  FirebaseFirestore fireBaseData = FirebaseFirestore.instance;

  void _init() {
    getData();
  }

  void getData() async {
    try {
      state = OnBoardinGameState(isLoadingQuestion: true);
      CollectionReference collection = fireBaseData.collection('quiz');
      QuerySnapshot querySnapshot = await collection.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        var quizInitialize = QuizModel.fromJson(data);
        var quizEditable = QuizModel.fromJson(data);

        quizEditable.questionAndAnswer = [];

        state = OnBoardinGameState(
          quizInitial: quizInitialize,
          quizEditable: quizEditable,
          isLoadingQuestion: false,
        );
      }
    } on FirebaseException catch (e) {
      print('ERROR DE FIREBASEE');
      print(e.toString());
    }
  }

  void addResponseUser(QuestionAndAnswer question, int indexNewResponse) {
    try {
      if (state.quizEditable?.questionAndAnswer.isNotEmpty == true) {
        var existQuestion = state.quizEditable?.questionAndAnswer.firstWhere(
          (q) => q.question == question.question,
        );
        if (existQuestion != null) {
          // Si la pregunta ya existe, actualiza el índice
          existQuestion.index = indexNewResponse;
        } else {
          // Si la pregunta no existe, agrégala con el nuevo índice
          var newQ = QuestionAndAnswer(
              index: indexNewResponse,
              question: question.question,
              answers: question.answers);
          state.quizEditable?.questionAndAnswer.add(newQ);
        }

        state = OnBoardinGameState(
          quizInitial: state.quizInitial,
          quizEditable: state.quizEditable,
        );
      } else {
        var newQ = QuestionAndAnswer(
            index: indexNewResponse,
            question: question.question,
            answers: question.answers);
        state.quizEditable?.questionAndAnswer.add(newQ);
        state = OnBoardinGameState(
          quizInitial: state.quizInitial,
          quizEditable: state.quizEditable,
        );
      }
    } catch (e) {
      var newQ = QuestionAndAnswer(
          index: indexNewResponse,
          question: question.question,
          answers: question.answers);
      state.quizEditable?.questionAndAnswer.add(newQ);
      state = OnBoardinGameState(
        quizInitial: state.quizInitial,
        quizEditable: state.quizEditable,
      );
    }
  }

  bool isAnswerCorrect(QuestionAndAnswer question, int answerId) {
    try {
      if (state.quizEditable?.questionAndAnswer.isNotEmpty == true) {
        var existQuestion = state.quizEditable?.questionAndAnswer.firstWhere(
          (q) => q.question == question.question,
        );
        if (existQuestion != null) {
          var issameIndex = existQuestion.getAnswerIndex() == answerId;
          return issameIndex;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void getCorrectAnswers() {
    List<QuestionAndAnswer> respCorrect = [];
    List<QuestionAndAnswer> respInCorrect = [];
    for (var questions in state.quizInitial!.questionAndAnswer) {
      var existQuestion = state.quizEditable?.questionAndAnswer.firstWhere(
        (q) => q.question == questions.question,
        orElse: () => QuestionAndAnswer(
          index: 111,
          question: '',
          answers: [],
        ),
      );
      if (existQuestion?.index != 111) {
        var isCorrectanswer =
            existQuestion?.getAnswerIndex() == questions.getAnswerIndex();
        if (isCorrectanswer) {
          respCorrect.add(existQuestion!);
        } else {
          respInCorrect.add(existQuestion!);
        }
      }
    }

    state = OnBoardinGameState(
      quizInitial: state.quizInitial,
      quizEditable: state.quizEditable,
      corrects: respCorrect,
      incorrects: respInCorrect,
    );
  }
}
