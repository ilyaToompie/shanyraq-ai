import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shyraq_ai/config/app_theme.dart';
import 'package:shyraq_ai/features/main_view/main_view.dart';
import 'package:shyraq_ai/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ru'), Locale('kk'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<void> _authFuture;

  final String demoEmail = 'biba@gmail.com';
  final String demoPassword = '123123';

  @override
  void initState() {
    super.initState();
    _authFuture = _signInDemoUser();
  }

  Future<void> _signInDemoUser() async {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;

    if (currentUser == null) {
      try {
        await auth.signInWithEmailAndPassword(
          email: demoEmail,
          password: demoPassword,
        );
      } catch (e) {
        if (e is FirebaseAuthException && e.code == 'user-not-found') {
          await auth.createUserWithEmailAndPassword(
            email: demoEmail,
            password: demoPassword,
          );
        } else {
          debugPrint('Firebase login error: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          builder: (context, child) {
            return Center(child: Container(width: 500, child: child));
          },
          home: const MainView(),
        );
      },
    );
  }
}
