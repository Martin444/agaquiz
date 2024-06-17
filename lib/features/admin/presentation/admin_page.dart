import 'package:agaquiz/core/colors/colors.dart';
import 'package:agaquiz/core/utils/styles/font_style.dart';
import 'package:agaquiz/core/utils/widgets/stars_background.dart';
import 'package:agaquiz/features/admin/controllers/admin_controller.dart';
import 'package:agaquiz/widgets/inputs/text_input_principal.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late AdminController adminController;

  @override
  void initState() {
    adminController = AdminController();
    adminController.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Text(
                      '¡Hola Administrador!',
                      style: AqTextStyle.primaryTextStyle,
                    ),
                    TextInputPrincipal(
                      hintText: 'Escribe la descripcion del juego o las reglas',
                      inputType: TextInputType.multiline,
                      controller: TextEditingController(),
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputPrincipal(
                      hintText: 'Tiempo de duración entre preguntas',
                      inputType: TextInputType.number,
                      controller: TextEditingController(),
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
