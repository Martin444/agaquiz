import 'package:agaquiz/features/admin/model/quiz_model.dart';
import 'package:agaquiz/features/admin/presentation/states/admin_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController extends AdminStateManage {
  FirebaseFirestore fireBaseData = FirebaseFirestore.instance;
  @override
  void getData() async {
    try {
      listQuestion?.clear();
      isLoadingQuestion = true;
      CollectionReference collection = fireBaseData.collection('quiz');
      QuerySnapshot querySnapshot = await collection.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        quizInitial = QuizModel.fromJson(data);
        descriptionQuiz.text = quizInitial?.description ?? '';
        durationQuiz.text = quizInitial?.duration.toString() ?? '';
        listQuestion = quizInitial?.questionAndAnswer;
        isLoadingQuestion = false;
      }
    } on FirebaseException catch (e) {
      print('ERROR DE FIREBASEE');
      print(e.toString());
    }
  }
}
