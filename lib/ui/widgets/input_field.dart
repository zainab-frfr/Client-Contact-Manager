import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;

  const MyInputField(
      {super.key,
      required this.labelText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        // Check if the field is empty
        if (value == null || value.isEmpty) {
          return 'This field is mandatory';
        }
        return null;
      },
      decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      controller: controller,
      obscureText: obscureText,
      //cursorColor: Colors.grey,
    );
  }
}
