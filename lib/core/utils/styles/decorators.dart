import 'package:agaquiz/core/colors/colors.dart';
import 'package:flutter/material.dart';

class AqDecorators {
  static final BoxDecoration decoratorCard1 = BoxDecoration(
    color: AqColors.bg_button_white,
    borderRadius: BorderRadius.circular(9.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        spreadRadius: 1,
        blurRadius: 15,
        offset: const Offset(0, 11),
      ),
    ],
  );
}
