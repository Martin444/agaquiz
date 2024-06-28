import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/Login/presentation/state/login_state_abs.dart';
import 'package:agaquiz/widgets/buttons/button_primary.dart';
import 'package:agaquiz/widgets/inputs/text_input_principal.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginstate = ref.watch(loginStateProvider);
    var loginfunctions = ref.watch(loginStateProvider.notifier);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStars(),
          Center(
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
                        controller: loginstate.nameController,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ButtonPrimary(
                        title: 'Continuar',
                        onPressed: () {
                          var isEqual = loginfunctions.postNameUser();
                          print(isEqual);
                          if (isEqual) context.beamToNamed('/admin');
                          // context.beamToNamed('/admin');
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
          ),
        ],
      ),
    );
  }
}
