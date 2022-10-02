import 'package:flutter/material.dart';
import 'package:topaz/screens/auth/sign_in_screen.dart';
import 'package:topaz/screens/auth/sign_up_screen.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateStateScreen();
}

class _AuthenticateStateScreen extends State<AuthenticateScreen> {
  bool _showSignInScreen = true;

  void toogleView() {
    setState(() {
      _showSignInScreen = !_showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showSignInScreen
          ? SignInScreen(toggleView: toogleView)
          : SignUpScreen(toggleView: toogleView),
    );
  }
}
