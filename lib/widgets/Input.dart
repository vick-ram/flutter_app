import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      required this.controller,
      this.hint,
      this.isPassword = false});

  final TextEditingController controller;
  final String? hint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
        ),
      ),
    );
  }
}
