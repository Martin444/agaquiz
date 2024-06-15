import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
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
                      hintText: 'Ingresá tu nombre',
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
