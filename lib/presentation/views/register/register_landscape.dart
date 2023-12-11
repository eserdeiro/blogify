import 'package:blogify/presentation/widgets.dart';
import 'package:blogify/presentation/widgets/shared/register_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class RegisterLandscape extends StatefulWidget {
  const RegisterLandscape({super.key});

  @override
  State<RegisterLandscape> createState() => RegisterLandscapeState();
}

class RegisterLandscapeState extends State<RegisterLandscape> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Row(
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
                    SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width * 0.6,
                            child: const RegisterContent()),
                        ],
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}