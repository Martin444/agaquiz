// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AqColors {
  static var backgroundColorLinear = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFED8F42),
      Color(0xFFEDC042),
    ],
  );

  static var text_withe_title1 = const Color(0xffffffff);
  static var text_black_btn1 = const Color(0xFF000000);
  static var bg_button_black = const Color(0xff393B43);
  static var bg_button_white = const Color(0xffffffff);
  static var bg_active_success = const Color(0xff24E837);
  static var bg_active_error = Color(0xFFE76F6F);
}
