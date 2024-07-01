import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/on_boarding/presentation/state/on_boardin_game_state.dart';
import 'package:agaquiz/widgets/buttons/button_primary.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusGamePage extends ConsumerWidget {
  const StatusGamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var onBoardController = ref.watch(onBoardingStateProvider);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStars(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '${onBoardController.quizEditable!.questionAndAnswer.length}/${onBoardController.quizInitial!.questionAndAnswer.length}',
                      style: AqTextStyle.primaryTextStyle,
                    ),
                    Text(
                      '¡Bien hecho continúa intentando!',
                      textAlign: TextAlign.center,
                      style: AqTextStyle.textDescriptionTitle2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${onBoardController.corrects?.length}',
                      style: AqTextStyle.primaryTextStyle,
                    ),
                    Text(
                      '¡Correctas!',
                      style: AqTextStyle.textDescriptionTitle2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${onBoardController.incorrects?.length}',
                      style: AqTextStyle.primaryTextStyle,
                    ),
                    Text(
                      '¡Incorrectas!',
                      style: AqTextStyle.textDescriptionTitle2,
                    ),
                  ],
                ),
                ButtonPrimary(
                  title: 'Volver a intentar',
                  onPressed: () {
                    context.beamToReplacementNamed('/iniciar');
                  },
                  load: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
