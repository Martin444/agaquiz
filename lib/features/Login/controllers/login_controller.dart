import 'package:agaquiz/core/config.dart';
import 'package:agaquiz/features/Login/presentation/state/login_state_abs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<LoginStateManage> {
  LoginController() : super(LoginStateManage());

  bool postNameUser() {
    if (state.nameController.text.isNotEmpty) {
      if (state.nameController.text == ADMIN_NAME) {
        return true;
      }

      USER_NAME = state.nameController.text;
      return false;
    }
    return false;
  }
}
