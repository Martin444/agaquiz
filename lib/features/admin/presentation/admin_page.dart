import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/admin/presentation/states/admin_state.dart';
import 'package:agaquiz/widgets/buttons/button_primary.dart';
import 'package:agaquiz/widgets/buttons/button_secundary.dart';
import 'package:agaquiz/widgets/inputs/text_input_principal.dart';
import 'package:agaquiz/widgets/utils/aq_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var adminController = ref.watch(adminStateProvider);
    var adminfunctions = ref.watch(adminStateProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AqColors.backgroundColorLinear,
        ),
        child: Stack(
          children: [
            const BackgroundStars(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Center(
                child: adminController.isLoadingQuestion
                    ? const AqLoader()
                    : Column(
                        children: [
                          Text(
                            '¡Hola Administrador!',
                            style: AqTextStyle.primaryTextStyle,
                          ),
                          TextInputPrincipal(
                            hintText:
                                'Escribe la descripcion del juego o las reglas',
                            inputType: TextInputType.multiline,
                            controller: TextEditingController(
                              text: adminController.quizEditable!.description
                                  .toString(),
                            ),
                            maxLines: 4,
                            onChange: (value) {
                              adminfunctions.updateDescription(value);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextInputPrincipal(
                            hintText: 'Tiempo de duración entre preguntas',
                            inputType: TextInputType.number,
                            controller: TextEditingController(
                              text: adminController.quizEditable!.duration
                                  .toString(),
                            ),
                            onChange: (duration) {
                              adminfunctions.updateDuration(duration);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: adminController
                                  .quizEditable!.questionAndAnswer.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    TextInputPrincipal(
                                      hintText: 'Escribe tu pregunta',
                                      inputType: TextInputType.name,
                                      controller: TextEditingController(
                                        text: adminController.quizEditable!
                                            .questionAndAnswer[index].question,
                                      ),
                                      onChange: (value) {
                                        adminfunctions.updateQuestions(
                                            index, value);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ...adminController.quizEditable!
                                        .questionAndAnswer[index].answers
                                        .map(
                                      (answer) {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onLongPress: () {
                                                adminfunctions.removeAnswer(
                                                  index,
                                                  answer,
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: answer.id ==
                                                        adminController
                                                            .quizEditable!
                                                            .questionAndAnswer[
                                                                index]
                                                            .index,
                                                    activeColor: AqColors
                                                        .bg_active_success,
                                                    onChanged: (state) {
                                                      adminfunctions
                                                          .updateIndexAnswer(
                                                        index,
                                                        answer,
                                                      );
                                                    },
                                                  ),
                                                  Flexible(
                                                    child: TextInputPrincipal(
                                                      hintText:
                                                          'Escribe tu respuesta',
                                                      inputType:
                                                          TextInputType.name,
                                                      controller:
                                                          TextEditingController(
                                                        text: answer.value,
                                                      ),
                                                      onChange: (p0) {
                                                        adminfunctions
                                                            .updateAnswers(
                                                          index,
                                                          answer,
                                                          p0,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(child: SizedBox()),
                                        Flexible(
                                          child: ButtonSecundary(
                                            title: 'Agregar respuesta',
                                            onPressed: () {
                                              adminfunctions.addAnswer(index);
                                            },
                                            load: false,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      height: 4,
                                      thickness: 3,
                                      color: AqColors.text_withe_title1,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ButtonPrimary(
                            title: 'Agregar pregunta',
                            onPressed: () {
                              adminfunctions.addQuestion();
                            },
                            load: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ButtonPrimary(
                            title: 'Actualizar preguntas',
                            onPressed: () {
                              adminfunctions.updateData();
                            },
                            load: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
