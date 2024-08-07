import 'package:flutter/material.dart';

class TextInputPrincipal extends StatelessWidget {
  final String? hintText;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String)? onSubmmited;
  final int? maxLines;

  const TextInputPrincipal({
    super.key,
    @required this.hintText,
    @required this.inputType,
    @required this.controller,
    this.onChange,
    this.inputAction,
    this.onSubmmited,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 11),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        textInputAction: inputAction,
        maxLines: maxLines,
        onFieldSubmitted: onSubmmited,
        style: const TextStyle(
          fontSize: 15.0,
          fontFamily: "Poppins",
          color: Color.fromARGB(255, 41, 41, 41),
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFe5e5e5),
          border: InputBorder.none,
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
            borderRadius: BorderRadius.all(Radius.circular(9.0)),
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}
