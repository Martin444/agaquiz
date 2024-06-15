import 'package:flutter/material.dart';

abstract class LoginStateManage extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  void postNameUser();
}
