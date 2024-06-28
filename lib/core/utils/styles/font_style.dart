import 'package:agaquiz/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AqTextStyle {
  static var primaryTextStyle = GoogleFonts.poppins(
    color: AqColors.text_withe_title1,
    fontSize: 45,
    fontWeight: FontWeight.bold,
  );
  static var textButtonStyle = GoogleFonts.poppins(
    color: AqColors.text_withe_title1,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static var textButtonStyle1 = GoogleFonts.poppins(
    color: AqColors.text_black_btn1,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
}
