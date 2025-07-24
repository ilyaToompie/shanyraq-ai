import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> adaptiveDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'OK',
  String? cancelText,
}) {
  if (Platform.isIOS) {
    return showCupertinoDialog<T>(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelText != null)
                CupertinoDialogAction(
                  child: Text(cancelText),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              CupertinoDialogAction(
                child: Text(confirmText),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
    );
  } else {
    return showDialog<T>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              if (cancelText != null)
                TextButton(
                  child: Text(cancelText),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              TextButton(
                child: Text(confirmText),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
    );
  }
}
