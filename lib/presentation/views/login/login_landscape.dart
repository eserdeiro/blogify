import 'package:blogify/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginLandscape extends StatefulWidget {
  const LoginLandscape({super.key});

  @override
  State<LoginLandscape> createState() => _LoginLandscapeState();
}

class _LoginLandscapeState extends State<LoginLandscape> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        ClipPath(
          clipper: OvalRightBorderClipper(),
          child: Container(
            width: size.width * 0.4,
            height: size.height,
            color: Colors.white,
            child: const Center(
              child: AppTitle(),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: const LoginContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
