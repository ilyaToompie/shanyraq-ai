import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController controller;

  const EmailInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'email'.tr(),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
