import 'package:agaquiz/core/config.dart';
import 'package:agaquiz/core/utils/styles/decorators.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/on_boarding/presentation/state/on_boardin_game_state.dart';
import 'package:agaquiz/widgets/buttons/button_play.dart';
import 'package:agaquiz/widgets/utils/aq_loader.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingGamePage extends ConsumerWidget {
  const OnBoardingGamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var onBoardController = ref.watch(onBoardingStateProvider);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStars(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: onBoardController.isLoadingQuestion
                ? const Center(child: AqLoader())
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Hola $USER_NAME',
                          style: AqTextStyle.primaryTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: AqDecorators.decoratorCard1,
                        child: Text(
                          onBoardController.quizInitial?.description ?? '',
                          textAlign: TextAlign.center,
                          style: AqTextStyle.textDescriptionTitle3,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          '¡Tenes ${onBoardController.quizInitial?.duration} segundos para responder!',
                          style: AqTextStyle.textButtonStyle1,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: ButtonNext(
                                onPressed: () {
                                  context.beamToNamed('/suerte');
                                },
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
