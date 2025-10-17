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
import 'package:image_picker/image_picker.dart';
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
            adminController.isLoadingQuestion
                ? const Center(child: AqLoader())
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 32),
                                Text(
                                  '¡Hola Administrador!',
                                  textAlign: TextAlign.center,
                                  style: AqTextStyle.primaryTextStyle,
                                ),
                                const SizedBox(height: 24),
                                // --- Widget para cambiar el logo ---
                                Column(
                                  children: [
                                    const Text(
                                      'Logo del Quiz',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    const SizedBox(height: 16),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 180,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(11),
                                            child: adminController.quizEditable?.logo != null &&
                                                    adminController.quizEditable!.logo!.isNotEmpty
                                                ? Image.network(
                                                    adminController.quizEditable!.logo!,
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context, child, loadingProgress) {
                                                      if (loadingProgress == null) return child;
                                                      return const Center(child: CircularProgressIndicator());
                                                    },
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return const Icon(Icons.error_outline,
                                                          color: Colors.red, size: 48);
                                                    },
                                                  )
                                                : Image.asset(
                                                    'assets/quizmalogo.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        if (adminController.isLoadingLogo)
                                          Container(
                                            height: 180,
                                            width: 180,
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.upload_file),
                                      label: const Text('Cambiar Logo'),
                                      onPressed: adminController.isLoadingLogo
                                          ? null
                                          : () async {
                                              final ImagePicker picker = ImagePicker();
                                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                              if (image != null) {
                                                await adminfunctions.uploadLogoAndUpdateQuiz(
                                                  image,
                                                  context: context,
                                                );
                                              }
                                            },
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                                // --- Fin del widget para cambiar el logo ---
                                TextInputPrincipal(
                                  hintText: 'Escribe la descripcion del juego o las reglas',
                                  inputType: TextInputType.multiline,
                                  controller: TextEditingController(
                                    text: adminController.quizEditable!.description.toString(),
                                  ),
                                  maxLines: 4,
                                  onChange: (value) {
                                    adminfunctions.updateDescription(value);
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextInputPrincipal(
                                  hintText: 'Tiempo de duración entre preguntas',
                                  inputType: TextInputType.number,
                                  controller: TextEditingController(
                                    text: adminController.quizEditable!.duration.toString(),
                                  ),
                                  onChange: (duration) {
                                    adminfunctions.updateDuration(duration);
                                  },
                                ),
                                const SizedBox(height: 20),
                                ...adminController.quizEditable!.questionAndAnswer.map(
                                  (question) {
                                    return Column(
                                      children: [
                                        TextInputPrincipal(
                                          hintText: 'Escribe tu pregunta',
                                          inputType: TextInputType.name,
                                          controller: TextEditingController(
                                            text: question.question,
                                          ),
                                          onChange: (value) {
                                            adminfunctions.updateQuestions(
                                              question,
                                              value,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        ...question.answers.map(
                                          (answer) {
                                            return Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                GestureDetector(
                                                  onLongPress: () {
                                                    adminfunctions.removeAnswer(
                                                      question,
                                                      answer,
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Checkbox(
                                                        value: answer.id == question.index,
                                                        activeColor: AqColors.bg_active_success,
                                                        onChanged: (state) {
                                                          adminfunctions.updateIndexAnswer(
                                                            question,
                                                            answer,
                                                          );
                                                        },
                                                      ),
                                                      Flexible(
                                                        child: TextInputPrincipal(
                                                          hintText: 'Escribe tu respuesta',
                                                          inputType: TextInputType.name,
                                                          controller: TextEditingController(
                                                            text: answer.value,
                                                          ),
                                                          onChange: (p0) {
                                                            adminfunctions.updateAnswers(
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
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: ButtonSecundary(
                                                title: 'Eliminar pregunta',
                                                onPressed: () {
                                                  adminfunctions.removeQuestion(question);
                                                },
                                                load: false,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: ButtonSecundary(
                                                title: 'Agregar respuesta',
                                                onPressed: () {
                                                  adminfunctions.addAnswer(question);
                                                },
                                                load: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Divider(
                                          height: 4,
                                          thickness: 3,
                                          color: AqColors.text_withe_title1,
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            ButtonPrimary(
                              title: 'Agregar pregunta',
                              onPressed: () {
                                adminfunctions.addQuestion();
                              },
                              load: false,
                            ),
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 10),
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
