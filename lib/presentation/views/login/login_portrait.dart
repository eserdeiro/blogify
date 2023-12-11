import 'package:blogify/presentation/screens.dart';
import 'package:blogify/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class LoginPortrait extends StatelessWidget {
  const LoginPortrait({super.key});

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Column(
            children: [
              ClipPath(
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
              const LoginTextFormField(),
            ],
          );
  }
}