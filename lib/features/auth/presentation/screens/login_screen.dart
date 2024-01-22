import 'package:blogify/config/constants/strings.dart';
import 'package:blogify/presentation/views.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String name = Strings.loginScreenName;
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          return (constraints.maxWidth > 600)
              ? const LoginLandscape()
              : const LoginPortrait();
        },
      ),
    );
  }
}
