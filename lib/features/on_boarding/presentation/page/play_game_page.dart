import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/config.dart';
import 'package:agaquiz/core/utils/styles/decorators.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/on_boarding/presentation/state/on_boardin_game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayGamePage extends ConsumerWidget {
  const PlayGamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var onBoardController = ref.watch(onBoardingStateProvider);
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStars(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$USER_NAME, Responde:',
                      style: AqTextStyle.textDescriptionTitle2,
                    ),
                    Text(
                      '0/${onBoardController.quizInitial?.questionAndAnswer.length}',
                      style: AqTextStyle.textDescriptionTitle2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount:
                        onBoardController.quizInitial?.questionAndAnswer.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: AqDecorators.decoratorCard1,
                            child: Center(
                              child: Text(
                                onBoardController.quizInitial
                                        ?.questionAndAnswer[index].question ??
                                    '-',
                                textAlign: TextAlign.center,
                                style: AqTextStyle.textDescriptionTitle3,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ...onBoardController
                              .quizInitial!.questionAndAnswer[index].answers
                              .map((answer) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: AqDecorators.decoratorCard1,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${answer.id}',
                                    style: AqTextStyle.textDescriptionTitle3,
                                  ),
                                  Container(
                                    height: 15,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    width: 1,
                                    color: AqColors.text_black_btn1,
                                  ),
                                  Expanded(
                                    child: Text(
                                      answer.value,
                                      style: AqTextStyle.textDescriptionTitle3,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    },
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
