import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
