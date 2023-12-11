import 'package:blogify/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:blogify/presentation/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Material(
        child: LayoutBuilder(
          builder: (context, constraints) {
         return (constraints.maxWidth > 600 )
            ?  const LoginLandscape()
            :  const LoginPortrait(); 
          },
        ),
      ),
      )
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('Blogify',
        style: TextStyle(
          color: Colors.black,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ));
  }
}
