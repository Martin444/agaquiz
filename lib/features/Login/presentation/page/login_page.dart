import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/config.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/Login/presentation/state/login_state_abs.dart';
import 'package:agaquiz/widgets/buttons/button_primary.dart';
import 'package:agaquiz/widgets/inputs/text_input_principal.dart';
import 'package:animate_do/animate_do.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginstate = ref.watch(loginStateProvider);
    var loginfunctions = ref.watch(loginStateProvider.notifier);
    return Title(
      color: AqColors.bg_active_error,
      title: 'Bienvenido',
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundStars(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
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
                            ElasticIn(
                              delay: const Duration(milliseconds: 100),
                              child: Image.asset(
                                'assets/quizmalogo.png',
                                height: 180,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeInUp(
                              from: 30,
                              duration: const Duration(milliseconds: 200),
                              delay: const Duration(milliseconds: 1000),
                              child: Text(
                                '¡Bienvenido a Quizma!',
                                textAlign: TextAlign.center,
                                style: AqTextStyle.primaryTextStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FadeInUp(
                              from: 30,
                              delay: const Duration(milliseconds: 1200),
                              child: TextInputPrincipal(
                                hintText: 'Ingresá tu nombre',
                                inputType: TextInputType.name,
                                inputAction: TextInputAction.continueAction,
                                controller: loginstate.nameController,
                                maxLines: 1,
                                onSubmmited: (value) {
                                  try {
                                    var isEqual = loginfunctions.postNameUser();
                                    if (!isEqual) {
                                      try {
                                        Beamer.of(context).beamToNamed(
                                          '/iniciar',
                                          data: {'username': USER_NAME},
                                        );
                                        return;
                                      } catch (e) {
                                        print(e);
                                      }
                                    }

                                    if (isEqual) context.beamToNamed('/admin');
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      FadeInUp(
                        from: 30,
                        delay: const Duration(milliseconds: 1500),
                        child: ButtonPrimary(
                          title: 'Continuar',
                          onPressed: () {
                            try {
                              var isEqual = loginfunctions.postNameUser();
                              if (!isEqual) {
                                try {
                                  Beamer.of(context).beamToNamed(
                                    '/iniciar',
                                    data: {'username': USER_NAME},
                                  );
                                  return;
                                } catch (e) {
                                  print(e);
                                }
                              }

                              if (isEqual) context.beamToNamed('/admin');
                            } catch (e) {
                              print(e);
                            }
                          },
                          load: false,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1200),
                        child: Text(
                          'Versión: $VERSION_RELEASE',
                          style: AqTextStyle.textButtonStyle1,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
