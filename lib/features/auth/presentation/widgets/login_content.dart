import 'package:blogify/config/constants/strings.dart';
import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/presentation/providers/auth_provider.dart';
import 'package:blogify/features/auth/presentation/providers/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginContent extends ConsumerWidget {
  const LoginContent({super.key});

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    ref.listen(authProvider, (previous, next) {
      switch (next.user) {
        case Success _:
          return;
        case Error _:
          showSnackBar(context, next.errorMessage);
        case Loading _:
          print('TODO EJECUTAR LOADING');
      }
    });
    final loginFormNotifier = ref.read(loginFormProvider.notifier);
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
                Strings.login,
                style: titleStyle.headlineMedium,
              ),
            ),
            CustomTextFormField(
              label: Strings.email,
              // onChanged:(value) => ref.read(loginFormProvider.notifier).onEmailChange(value),
              onChanged: loginFormNotifier.onEmailChange,
              errorText:
                  loginForm.isFormPosted ? loginForm.email.errorMessage : null,
              prefixIcon: const Icon(Icons.mail_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              obscureText: true,
              onChanged: loginFormNotifier.onPasswordChange,
              errorText: loginForm.isFormPosted
                  ? loginForm.password.errorMessage
                  : null,
              label: Strings.password,
              prefixIcon: const Icon(Icons.lock),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomElevatedButton(
                text: "Les't go",
                onPressed: () {
                  loginFormNotifier.onSubmit();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  context.push(Strings.registerUrl);
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
