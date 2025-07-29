import 'package:easy_localization/easy_localization.dart';
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
        labelText: 'confirm-password'.tr(),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
