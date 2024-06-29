import 'package:agaquiz/core/colors/colors.dart';
import 'package:flutter/material.dart';

class AqLoader extends StatelessWidget {
  const AqLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AqColors.bg_button_white,
      strokeWidth: 7,
      strokeCap: StrokeCap.round,
    );
  }
}
