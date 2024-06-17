import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/Login/controllers/login_controller.dart';
import 'package:agaquiz/widgets/buttons/button_primary.dart';
import 'package:agaquiz/widgets/inputs/text_input_principal.dart';
import 'package:beamer/beamer.dart';
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
              return Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Image.asset('assets/agapitalogo.png'),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '¡Bienvenido a AgaQuiz!',
                            textAlign: TextAlign.center,
                            style: AqTextStyle.primaryTextStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextInputPrincipal(
                            hintText: 'Ingresá tu nombre',
                            inputType: TextInputType.multiline,
                            controller: controller.nameController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ButtonPrimary(
                            title: 'Continuar',
                            onPressed: () {
                              controller.postNameUser();
                              context.beamToNamed('/admin');
                            },
                            load: false,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
