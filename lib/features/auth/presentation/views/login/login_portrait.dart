 
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginPortrait extends StatefulWidget {
  const LoginPortrait({super.key});

  @override
  State<LoginPortrait> createState() => _LoginPortraitState();
}

class _LoginPortraitState extends State<LoginPortrait> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: size.height * 0.4,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.15),
                    child: const AppTitle(),
                  ),
                ),
              ),
            ),
          ),
          const LoginContent(),
        ],
      ),
    );
  }
}
