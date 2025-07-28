import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/config/app_theme.dart';
import 'package:shyraq_ai/features/main_view/main_view.dart';
import 'package:shyraq_ai/features/users/data/user_repository.dart';
import 'package:shyraq_ai/features/users/logic/user_bloc.dart';
import 'package:shyraq_ai/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (_) => UserBloc(UserRepository())),
      ],

      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const MainView(),
    );
  }
}
