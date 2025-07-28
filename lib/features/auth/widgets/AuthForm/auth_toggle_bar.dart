import 'package:flutter/cupertino.dart';

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
}
