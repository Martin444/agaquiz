import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/bling_background.dart';
import 'package:agaquiz/features/Login/controllers/login_controller.dart';
import 'package:agaquiz/widgets/inputs/text_input_principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStars(),
          Consumer<LoginController>(
            builder: (context, controller, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Image.asset('assets/agapitalogo.png'),
                    Text(
                      '¡Bienvenido a AgaQuiz!',
                      textAlign: TextAlign.center,
                      style: AqTextStyle.primaryTextStyle,
                    ),
                    TextInputPrincipal(
                      hintText: 'hintText',
                      inputType: TextInputType.multiline,
                      controller: controller.nameController,
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class BackgroundStars extends StatefulWidget {
  const BackgroundStars({
    super.key,
  });

  @override
  State<BackgroundStars> createState() => _BackgroundStarsState();
}

class _BackgroundStarsState extends State<BackgroundStars>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: AqColors.backgroundColorLinear),
        ),
        CustomPaint(
          painter: StarPainter(animation: _controller!),
          child: Container(),
        )
      ],
    );
  }
}
