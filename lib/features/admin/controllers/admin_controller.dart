import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:agaquiz/features/admin/presentation/states/admin_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminController extends StateNotifier<AdminState> {
  AdminController() : super(AdminState()) {
    _init();
  }
  FirebaseFirestore fireBaseData = FirebaseFirestore.instance;

  void _init() {
    getData();
  }

  void getData() async {
    try {
      state = AdminState(isLoadingQuestion: true);
      CollectionReference collection = fireBaseData.collection('quiz');
      QuerySnapshot querySnapshot = await collection.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        var quizInitialize = QuizModel.fromJson(data);

        state = AdminState(
          quizInitial: quizInitialize,
          descriptionQuiz: TextEditingController(
            text: quizInitialize.description,
          ),
          durationQuiz: TextEditingController(
            text: quizInitialize.duration.toString(),
          ),
          listQuestion: quizInitialize.questionAndAnswer,
          isLoadingQuestion: false,
        );
      }
    } on FirebaseException catch (e) {
      print('ERROR DE FIREBASEE');
      print(e.toString());
    }
  }

  void addQuestion() {
    var quizable = state.listQuestion;

    quizable!.add(
      QuestionAndAnswer(
        index: 0,
        question: 'pregunta ${state.listQuestion!.length + 1}',
        answers: [],
      ),
    );

    state = AdminState(
      listQuestion: quizable,
    );
  }

  void addAnswer(int indexQuestion) {
    if (state.listQuestion == null ||
        indexQuestion >= state.listQuestion!.length) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }
    var questions = state.listQuestion;
    var currentQuestion = questions![indexQuestion];
    var answers = currentQuestion.answers;

    answers.add('Respuesta #${answers.length + 1}');

    state = AdminState(
      listQuestion: questions,
    );
  }
}
