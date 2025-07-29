import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UsernameInput extends StatelessWidget {
  final TextEditingController controller;

  const UsernameInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'enter-username'.tr(),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
