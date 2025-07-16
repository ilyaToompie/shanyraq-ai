import 'package:flutter/material.dart';
import 'package:shyraq_ai/config/app_theme.dart';
import 'package:shyraq_ai/features/main_view/main_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}
