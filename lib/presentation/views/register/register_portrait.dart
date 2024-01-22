import 'package:blogify/presentation/widgets.dart';
import 'package:blogify/presentation/widgets/shared/register_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class RegisterPortrait extends StatefulWidget {
  const RegisterPortrait({super.key});

  @override
  State<RegisterPortrait> createState() => _RegisterPortraitState();
}

class _RegisterPortraitState extends State<RegisterPortrait> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
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
          const RegisterContent(),
        ],
      ),
    );
  }
}
