import 'package:blogify/presentation/screens.dart';
import 'package:blogify/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginLandscape extends StatelessWidget {
  const LoginLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
            children: [
              ClipPath(
                clipper: OvalRightBorderClipper(),
                child: Container(
                  width: size.width * 0.4,
                  color: Colors.white,
                  child: const Center(
                    child: AppTitle(),
                  ),
                ),
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginTextFormField(),
                  ],
                ),
              ),
            ],
          );
  }
}