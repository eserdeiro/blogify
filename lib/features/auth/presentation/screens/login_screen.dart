import 'package:blogify/presentation/views.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return (constraints.maxWidth > 600)
                ? const LoginLandscape()
                : const LoginPortrait();
          },
        ),
      ),
    );
  }
}
