import 'package:agaquiz/features/admin/model/answer_model.dart';
import 'package:agaquiz/features/admin/model/qa_model.dart';
import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:agaquiz/features/admin/presentation/states/admin_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class AdminController extends StateNotifier<AdminState> {
  AdminController() : super(AdminState()) {
    _init();
  }
  FirebaseFirestore fireBaseData = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void _init() {
    getData();
  }

  void getData() async {
    try {
      state = state.copyWith(isLoadingQuestion: true);
      CollectionReference collection = fireBaseData.collection('quiz');
      QuerySnapshot querySnapshot = await collection.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        var quizInitialize = QuizModel.fromJson(data);
        state = state.copyWith(
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
        question: 'pregunta ${state.quizEditable!.questionAndAnswer.length + 1}',
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
    final questions = state.quizEditable!.questionAndAnswer;
    final currentQuestion = questions.firstWhere((q) => q == indexQuestion);
    final answers = currentQuestion.answers;

    // answers.add('Respuesta #${answers.length + 1}');
    answers.add(
      AnswerModel(
        id: answers.length + 1,
        value: 'Respuesta #${answers.length + 1}',
      ),
    );
    state = state.copyWith(quizEditable: state.quizEditable);
  }

  void removeAnswer(QuestionAndAnswer indexQuestion, AnswerModel answer) {
    if (state.quizEditable?.questionAndAnswer == null) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }
    final questions = state.quizEditable!.questionAndAnswer;
    final currentQuestion = questions.firstWhere((q) => q == indexQuestion);
    final answers = currentQuestion.answers;

    answers.remove(answer);
    state = state.copyWith(quizEditable: state.quizEditable);
  }

  void removeQuestion(QuestionAndAnswer indexQuestion) {
    if (state.quizEditable?.questionAndAnswer == null) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }
    final questions = state.quizEditable!.questionAndAnswer;
    final currentQuestion = questions.firstWhere((q) => q == indexQuestion);

    questions.remove(currentQuestion);
    state = state.copyWith(quizEditable: state.quizEditable);
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
    var answerSelect = currentQuestion.answers.where((value) => value.id == answer.id);

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

  void updateAnswers(QuestionAndAnswer indexQuestion, AnswerModel value, String newValue) {
    if (state.quizEditable?.questionAndAnswer == null) {
      // Manejo de error: la lista de preguntas es nula o el índice está fuera de rango.
      return;
    }

    var currentQuestion = state.quizEditable!.questionAndAnswer.firstWhere((q) => q == indexQuestion);
    var indexAnswer = currentQuestion.answers.indexWhere((answer) => answer.id == value.id);

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
      return;
    }
  }

  /// Sube el logo y actualiza el quiz. Muestra un snackbar en caso de error.
  Future<void> uploadLogoAndUpdateQuiz(
    XFile imageFile, {
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoadingLogo: true);
    try {
      print('Iniciando carga de logo...');
      final String fileName = 'logo_quiz_${DateTime.now().millisecondsSinceEpoch}';
      final Reference storageRef = _storage.ref().child('logos/$fileName');
      print('Se guardara en $storageRef...');
      final bytes = await imageFile.readAsBytes();
      final UploadTask uploadTask = storageRef.putData(bytes);
      final TaskSnapshot snapshot = await uploadTask;
      print('Logo cargado, obteniendo URL de descarga...');
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      print('URL de descarga obtenida: $downloadUrl');
      final updatedQuiz = state.quizEditable!..logo = downloadUrl;
      state = state.copyWith(quizEditable: updatedQuiz);
      print('Modelo de quiz actualizado, persistiendo cambios...');
      await updateData();
      print('Cambios persistidos con éxito.');
    } on FirebaseException catch (e) {
      print('FirebaseException al subir el logo: ${e.code} - ${e.message}');
      if (e.message != null && e.message!.toLowerCase().contains('cors')) {
        _showErrorSnackbar(context,
            'Error de CORS al subir el logo. Revisa la configuración de CORS en Firebase Storage y asegúrate de que el origen y los métodos estén permitidos.');
      } else {
        _showErrorSnackbar(context, 'Error de Firebase al subir el logo: ${e.message ?? e.code}');
      }
    } on NetworkImageLoadException catch (e) {
      print('Error de red al subir el logo: $e');
      _showErrorSnackbar(context, 'Error de red al subir el logo. Verifica tu conexión.');
    } on Exception catch (e) {
      print('Error inesperado al subir el logo: $e');
      if (e.toString().toLowerCase().contains('cors')) {
        _showErrorSnackbar(context,
            'Error de CORS al subir el logo. Revisa la configuración de CORS en Firebase Storage y asegúrate de que el origen y los métodos estén permitidos.');
      } else {
        _showErrorSnackbar(context, 'Ocurrió un error inesperado al subir el logo. Intenta nuevamente.');
      }
    } finally {
      state = state.copyWith(isLoadingLogo: false);
    }
  }

  /// Muestra un snackbar con el mensaje de error.
  void _showErrorSnackbar(BuildContext context, String message) {
    // Se recomienda usar ScaffoldMessenger para mostrar el snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFD32F2F), // rojo de error
      ),
    );
  }
}
