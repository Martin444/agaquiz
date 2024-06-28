import 'package:agaquiz/features/Login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateManage {
  TextEditingController nameController = TextEditingController();

  String errorLogin = '';
}

final loginStateProvider =
    StateNotifierProvider<LoginController, LoginStateManage>((ref) {
  return LoginController();
});
