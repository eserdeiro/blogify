import 'package:blogify/presentation/views.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return (constraints.maxWidth > 600)
                ? const RegisterLandscape()
                : const RegisterPortrait();
          },
        ),
      ),
    );
  }
}
