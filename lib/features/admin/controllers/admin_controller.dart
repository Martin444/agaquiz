import 'package:agaquiz/features/admin/model/answer_model.dart';
import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:agaquiz/features/admin/presentation/states/admin_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          quizEditable: quizInitialize,
          isLoadingQuestion: false,
        );
      }
    } on FirebaseException catch (e) {
      print('ERROR DE FIREBASEE');
      print(e.toString());
    }
  }

  void addQuestion() {
    var quizable = state.quizEditable?.questionAndAnswer;

    quizable!.add(
      QuestionAndAnswer(
        index: 0,
        question:
            'pregunta ${state.quizEditable!.questionAndAnswer.length + 1}',
        answers: [],
      ),
    );
    state = AdminState(
      quizEditable: state.quizEditable,
    );
  }

  void addAnswer(QuestionAndAnswer indexQuestion) {
    if (state.quizEditable?.questionAndAnswer == null) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }
    var questions = state.quizEditable!.questionAndAnswer;
    var currentQuestion = questions.firstWhere((q) => q == indexQuestion);
    var answers = currentQuestion.answers;

    // answers.add('Respuesta #${answers.length + 1}');
    answers.add(
      AnswerModel(
        id: answers.length + 1,
        value: 'Respuesta #${answers.length + 1}',
      ),
    );

    state = AdminState(
      quizEditable: state.quizEditable,
    );
  }

  void removeAnswer(QuestionAndAnswer indexQuestion, AnswerModel answer) {
    if (state.quizEditable?.questionAndAnswer == null) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }
    var questions = state.quizEditable!.questionAndAnswer;
    var currentQuestion = questions.firstWhere((q) => q == indexQuestion);
    var answers = currentQuestion.answers;

    answers.remove(answer);

    state = AdminState(
      quizEditable: state.quizEditable,
    );
  }

  void removeQuestion(QuestionAndAnswer indexQuestion) {
    if (state.quizEditable?.questionAndAnswer == null) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }
    var questions = state.quizEditable!.questionAndAnswer;
    var currentQuestion = questions.firstWhere((q) => q == indexQuestion);

    questions.remove(currentQuestion);

    state = AdminState(
      quizEditable: state.quizEditable,
    );
  }

  void updateDescription(String newDescription) {
    state.quizEditable!.description = newDescription;
  }

  void updateDuration(String newDuration) {
    state.quizEditable!.duration = int.tryParse(newDuration) ?? 5;
  }

  void updateIndexAnswer(QuestionAndAnswer indexQuestion, AnswerModel answer) {
    var questions = state.quizEditable!.questionAndAnswer;
    var currentQuestion = questions.firstWhere((q) => q == indexQuestion);
    var answerSelect =
        currentQuestion.answers.where((value) => value.id == answer.id);

    currentQuestion.index = answerSelect.first.id;
    state = AdminState(
      quizEditable: state.quizEditable,
    );
  }

  void updateQuestions(QuestionAndAnswer indexQuestion, String newQuestion) {
    var questions = state.quizEditable!.questionAndAnswer;
    var currentQuestion = questions.firstWhere((q) => q == indexQuestion);
    currentQuestion.question = newQuestion;
  }

  void updateAnswers(
      QuestionAndAnswer indexQuestion, AnswerModel value, String newValue) {
    if (state.quizEditable?.questionAndAnswer == null) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }

    var currentQuestion = state.quizEditable!.questionAndAnswer
        .firstWhere((q) => q == indexQuestion);
    var indexAnswer =
        currentQuestion.answers.indexWhere((answer) => answer.id == value.id);

    if (indexAnswer != -1) {
      // Si se encuentra la respuesta, actualiza su valor.
      currentQuestion.answers[indexAnswer] = AnswerModel(
        id: value.id,
        value: newValue,
      );
    }
  }

  Future<void> updateData() async {
    try {
      CollectionReference collection = fireBaseData.collection('quiz');
      DocumentReference documentRef = collection.doc('eJCxsGIDjZt0pt60mYat');
      await documentRef.update(state.quizEditable!.toJson());
      return;
    } catch (e) {
      print('ERROR DE FIREBASE');
      print(e.toString());
    }
  }
}
