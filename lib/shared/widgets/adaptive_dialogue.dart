import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<T?> adaptiveDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'OK',
  String? cancelText,
}) {
  if (kIsWeb) {
    return showDialog<T>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelText != null)
                TextButton(
                  child: Text(cancelText),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                ),
              TextButton(
                child: Text(confirmText),
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ],
          ),
    );
  }
  if (Platform.isIOS) {
    return showCupertinoDialog<T>(
      context: context,
      builder:
          (dialogContext) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelText != null)
                CupertinoDialogAction(
                  child: Text(cancelText),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                ),
              CupertinoDialogAction(
                child: Text(confirmText),
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ],
          ),
    );
  } else {
    return showDialog<T>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelText != null)
                TextButton(
                  child: Text(cancelText),
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                ),
              TextButton(
                child: Text(confirmText),
                onPressed: () => Navigator.of(dialogContext).pop(true),
              ),
            ],
          ),
    );
  }
}
