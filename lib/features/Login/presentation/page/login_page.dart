import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/bling_background.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundStars(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  '¡Bienvenido a AgaQuiz!',
                  textAlign: TextAlign.center,
                  style: AqTextStyle.primaryTextStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BackgroundStars extends StatelessWidget {
  const BackgroundStars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: AqColors.backgroundColorLinear),
        ),
        CustomPaint(
          painter: StarPainter(),
          child: Container(),
        )
      ],
    );
  }
}
