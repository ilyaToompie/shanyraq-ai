import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void toggleMode() => setState(() => isLogin = !isLogin);

  void handleSubmit() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) return;

    if (isLogin) {
      // FirebaseAuth.instance.signInWithEmailAndPassword(email: ..., password: ...)
    } else {
      // FirebaseAuth.instance.createUserWithEmailAndPassword(...)
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Register')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AuthToggleBar(isLogin: isLogin, onToggle: toggleMode),
            const SizedBox(height: 24),
            AuthForm(
              isLogin: isLogin,
              emailController: emailController,
              passwordController: passwordController,
              onSubmit: handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

class AuthToggleBar extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onToggle;

  const AuthToggleBar({
    required this.isLogin,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSlidingSegmentedControl<bool>(
        groupValue: isLogin,
        onValueChanged: (v) => onToggle(),
        children: const {
          true: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text('Login'),
          ),
          false: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text('Register'),
          ),
        },
      );
    }

    return SegmentedButton<bool>(
      segments: const [
        ButtonSegment(value: true, label: Text('Login')),
        ButtonSegment(value: false, label: Text('Register')),
      ],
      selected: {isLogin},
      onSelectionChanged: (_) => onToggle(),
    );
  }
}

class AuthForm extends StatelessWidget {
  final bool isLogin;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const AuthForm({
    required this.isLogin,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailInput(controller: emailController),
        const SizedBox(height: 16),
        PasswordInput(controller: passwordController),
        const SizedBox(height: 24),
        SubmitButton(isLogin: isLogin, onPressed: onSubmit),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  final TextEditingController controller;

  const EmailInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        placeholder: 'Email',
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        fillColor: color.surfaceVariant,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInput({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    if (Platform.isIOS) {
      return CupertinoTextField(
        controller: controller,
        obscureText: true,
        placeholder: 'Password',
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: color.surfaceVariant,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

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
        child: Text(isLogin ? 'Login' : 'Register'),
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
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }
}
