import 'package:blogify/features/auth/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:blogify/presentation/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: Material(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return (constraints.maxWidth > 600)
                  ? const RegisterLandscape()
                  : const RegisterPortrait();
            },
          ),
        ),
      ),
    );
  }
}
