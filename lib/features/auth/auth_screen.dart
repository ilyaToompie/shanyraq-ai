// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shyraq_ai/features/auth/widgets/AuthForm/auth_toggle_bar.dart';
import 'package:shyraq_ai/features/auth/widgets/AuthForm/city_picker.dart';
import 'package:shyraq_ai/features/auth/widgets/AuthForm/email_input.dart';
import 'package:shyraq_ai/features/auth/widgets/AuthForm/name_input.dart';
import 'package:shyraq_ai/features/auth/widgets/AuthForm/password_confirmation_field.dart';
import 'package:shyraq_ai/features/auth/widgets/AuthForm/password_input.dart';
import 'package:shyraq_ai/features/auth/widgets/AuthForm/submit_button.dart';
import 'package:shyraq_ai/features/main_view/main_view.dart';
import 'package:shyraq_ai/features/users/data/kazakhCities.dart';
import 'package:shyraq_ai/features/users/data/user_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  String selectedCity = "almaty";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final usernameController = TextEditingController();

  String? _errorMessage;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  void toggleMode() => setState(() => isLogin = !isLogin);

  @override
  void initState() {
    super.initState();
    selectedCity = kazakhstan_cities.keys.first;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut),
    );
  }

  Future<void> handleSubmit() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final passwordConfirmation = passwordConfirmationController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError("empty-email-password".tr());
      return;
    }

    if (!EmailValidator.validate(email)) {
      _showError("invalid-email".tr());
      return;
    }

    if (!isLogin && password != passwordConfirmation) {
      _showError("passwords-dont-match".tr());
      return;
    }

    if (password.length < 6) {
      _showError("password-too-short".tr());
      return;
    }

    try {
      if (isLogin) {
        await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      final firebaseUser = auth.FirebaseAuth.instance.currentUser;
      final uid = firebaseUser?.uid;
      if (uid == null) {
        _showError("Authentication failed: no user ID");
        return;
      }

      final userRepository = UserRepository();
      if (!isLogin) {
        await userRepository.createUserDocument(
          uid,
          email,
          usernameController.text.trim(),
          selectedCity,
        );
      }

      await Future.delayed(const Duration(milliseconds: 300));
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainView()));
    } on auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          _showError("auth-invalid-email".tr());
          break;
        case 'user-disabled':
          _showError("auth-user-disabled".tr());
          break;
        case 'user-not-found':
          _showError("auth-user-not-found".tr());
          break;
        case 'wrong-password':
          _showError("auth-wrong-password".tr());
          break;
        case 'email-already-in-use':
          _showError("auth-email-already-in-use".tr());
          break;
        case 'weak-password':
          _showError("auth-weak-password".tr());
          break;
        case 'operation-not-allowed':
          _showError("auth-operation-not-allowed".tr());
          break;
        default:
          _showError(e.message ?? "auth-error".tr());
      }
    }
  }

  void _showError(String message) {
    setState(() {
      _errorMessage = message;
    });

    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      _animationController.reverse().then((_) {
        setState(() {
          _errorMessage = null;
        });
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'login'.tr() : 'register'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Column(
              children: [
                AuthToggleBar(isLogin: isLogin, onToggle: toggleMode),
                const SizedBox(height: 24),
                EmailInput(controller: emailController),
                const SizedBox(height: 16),
                PasswordInput(controller: passwordController),

                if (!isLogin)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: PasswordConfirmationField(
                          controller: passwordConfirmationController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: UsernameInput(controller: usernameController),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CityPicker(
                          locale: context.locale.languageCode,
                          onSelected: (String cityCode) {
                            setState(() {
                              selectedCity = cityCode;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                SubmitButton(isLogin: isLogin, onPressed: handleSubmit),
                const SizedBox(height: 24),
              ],
            ),
            if (_errorMessage != null)
              Positioned(
                left: 16,
                right: 16,
                bottom: 32, // some bottom margin
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _animationController.reverse().then((_) {
                              setState(() {
                                _errorMessage = null;
                              });
                            });
                          },
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
