import 'package:agaquiz/features/admin/presentation/states/admin_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController extends AdminStateManage {
  FirebaseFirestore fireBaseData = FirebaseFirestore.instance;
  @override
  void getData() async {
    try {
      // Ejemplo para obtener documentos de una colección
      CollectionReference collection = fireBaseData.collection('quiz');
      QuerySnapshot querySnapshot = await collection.get();

      // Itera sobre los documentos y haz algo con ellos
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Usa 'data', que es un Map<String, dynamic> conteniendo tus datos.
        print(data);
      }
    } on FirebaseException catch (e) {
      print('ERROR DE FIREBASEE');
      print(e.toString());
    }
  }
}
