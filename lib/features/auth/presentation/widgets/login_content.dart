import 'package:blogify/features/auth/blocs/login_cubit/login_cubit.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({
    super.key,
  });

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();
    final password = loginCubit.state.password;
    final email = loginCubit.state.email;

    final titleStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Login',
                style: titleStyle.headlineMedium,
              ),
            ),
            CustomTextFormField(
              label: 'Email',
              onChanged: loginCubit.emailChanged,
              errorText: email.errorMessage,
              prefixIcon: const Icon(Icons.mail_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              obscureText: true,
              onChanged: loginCubit.passwordChanged,
              errorText: password.errorMessage,
              label: 'Password',
              prefixIcon: const Icon(Icons.lock),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomElevatedButton(
                text: "Les't go",
                onPressed: () {
                  loginCubit.onSubmit();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  context.push('/register');
                },
                child: const Center(child: Text('Dont have account? Sign up')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
