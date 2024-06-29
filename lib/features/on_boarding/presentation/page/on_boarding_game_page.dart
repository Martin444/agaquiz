import 'package:agaquiz/core/config.dart';
import 'package:agaquiz/core/utils/styles/decorators.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/widgets/buttons/button_play.dart';
import 'package:flutter/material.dart';

class OnBoardingGamePage extends StatelessWidget {
  const OnBoardingGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStars(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Hola $USER_NAME',
                    style: AqTextStyle.primaryTextStyle,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: AqDecorators.decoratorCard1,
                  child: Text(
                    '10 preguntas sobre cultura general para desafiar tu conocimiento',
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    '¡Tenes 15 segundos para responder!',
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ButtonNext(
                          title: 'title',
                          onPressed: () {},
                          load: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
