import 'package:flutter/material.dart';

class PasswordConfirmationField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordConfirmationField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm password',
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
