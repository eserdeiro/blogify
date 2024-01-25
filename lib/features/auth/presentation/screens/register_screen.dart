import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static String name = Strings.registerScreenName;
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          return (constraints.maxWidth > 600)
              ? const RegisterLandscape()
              : const RegisterPortrait();
        },
      ),
    );
  }
}
