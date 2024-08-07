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
import 'package:toast/toast.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var adminController = ref.watch(adminStateProvider);
    var adminfunctions = ref.watch(adminStateProvider.notifier);
    ToastContext().init(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AqColors.backgroundColorLinear,
        ),
        child: Stack(
          children: [
            const BackgroundStars(),
            Container(
              // padding: const EdgeInsets.symmetric(
              //   horizontal: 20,
              // ),
              child: Center(
                child: adminController.isLoadingQuestion
                    ? const AqLoader()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                '¡Hola Administrador!',
                                textAlign: TextAlign.center,
                                style: AqTextStyle.primaryTextStyle,
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      TextInputPrincipal(
                                        hintText:
                                            'Escribe la descripcion del juego o las reglas',
                                        inputType: TextInputType.multiline,
                                        controller: TextEditingController(
                                          text: adminController
                                              .quizEditable!.description
                                              .toString(),
                                        ),
                                        maxLines: 4,
                                        onChange: (value) {
                                          adminfunctions
                                              .updateDescription(value);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextInputPrincipal(
                                        hintText:
                                            'Tiempo de duración entre preguntas',
                                        inputType: TextInputType.number,
                                        controller: TextEditingController(
                                          text: adminController
                                              .quizEditable!.duration
                                              .toString(),
                                        ),
                                        onChange: (duration) {
                                          adminfunctions
                                              .updateDuration(duration);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ...adminController
                                          .quizEditable!.questionAndAnswer
                                          .map(
                                        (question) {
                                          return Column(
                                            children: [
                                              TextInputPrincipal(
                                                hintText: 'Escribe tu pregunta',
                                                inputType: TextInputType.name,
                                                controller:
                                                    TextEditingController(
                                                  text: question.question,
                                                ),
                                                onChange: (value) {
                                                  adminfunctions
                                                      .updateQuestions(
                                                    question,
                                                    value,
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ...question.answers.map(
                                                (answer) {
                                                  return Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      GestureDetector(
                                                        onLongPress: () {
                                                          adminfunctions
                                                              .removeAnswer(
                                                            question,
                                                            answer,
                                                          );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Checkbox(
                                                              value: answer
                                                                      .id ==
                                                                  question
                                                                      .index,
                                                              activeColor: AqColors
                                                                  .bg_active_success,
                                                              onChanged:
                                                                  (state) {
                                                                adminfunctions
                                                                    .updateIndexAnswer(
                                                                  question,
                                                                  answer,
                                                                );
                                                              },
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  TextInputPrincipal(
                                                                hintText:
                                                                    'Escribe tu respuesta',
                                                                inputType:
                                                                    TextInputType
                                                                        .name,
                                                                controller:
                                                                    TextEditingController(
                                                                  text: answer
                                                                      .value,
                                                                ),
                                                                onChange: (p0) {
                                                                  adminfunctions
                                                                      .updateAnswers(
                                                                    question,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: ButtonSecundary(
                                                      title:
                                                          'Eliminar pregunta',
                                                      onPressed: () {
                                                        adminfunctions
                                                            .removeQuestion(
                                                                question);
                                                      },
                                                      load: false,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: ButtonSecundary(
                                                      title:
                                                          'Agregar respuesta',
                                                      onPressed: () {
                                                        adminfunctions
                                                            .addAnswer(
                                                                question);
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
                                                color:
                                                    AqColors.text_withe_title1,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
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
                                    title: 'Actualizar',
                                    onPressed: () async {
                                      adminfunctions.updateData();
                                      Toast.show(
                                        "Actualizado",
                                        duration: Toast.lengthShort,
                                        gravity: Toast.bottom,
                                      );
                                    },
                                    load: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
