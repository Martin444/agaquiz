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

        state = OnBoardinGameState(
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
}
