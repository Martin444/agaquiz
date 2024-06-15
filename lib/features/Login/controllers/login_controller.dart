import 'package:agaquiz/features/Login/presentation/state/login_state_abs.dart';

class LoginController extends LoginStateManage {
  @override
  void postNameUser() {
    print(nameController.text);
  }
}
