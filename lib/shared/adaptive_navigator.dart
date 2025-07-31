import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<T?> adaptiveNavigatorPush<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  final route =
      kIsWeb
          ? MaterialPageRoute<T>(builder: builder)
          : Platform.isIOS
          ? CupertinoPageRoute<T>(builder: builder)
          : MaterialPageRoute<T>(builder: builder);
  return Navigator.of(context).push<T>(route);
}
