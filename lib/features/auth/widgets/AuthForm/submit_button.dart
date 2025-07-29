import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onPressed;

  const SubmitButton({
    required this.isLogin,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (Platform.isIOS) {
      return CupertinoButton.filled(
        borderRadius: BorderRadius.circular(10),
        onPressed: onPressed,
        child: Text(isLogin ? 'login'.tr() : 'register'.tr()),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.primary,
        foregroundColor: color.onPrimary,
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(isLogin ? 'login'.tr() : 'register'.tr()),
    );
  }
}
