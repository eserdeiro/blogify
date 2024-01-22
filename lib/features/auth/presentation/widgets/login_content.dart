import 'package:blogify/features/auth/presentation/providers/login_form_provider.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginContent extends ConsumerWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
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
              // onChanged:(value) => ref.read(loginFormProvider.notifier).onEmailChange(value),
              onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
              errorText:
                  loginForm.isFormPosted ? loginForm.email.errorMessage : null,
              prefixIcon: const Icon(Icons.mail_outlined),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              obscureText: true,
              onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
              errorText: loginForm.isFormPosted
                  ? loginForm.password.errorMessage
                  : null,
              label: 'Password',
              prefixIcon: const Icon(Icons.lock),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomElevatedButton(
                text: "Les't go",
                onPressed: () {
                  ref.read(loginFormProvider.notifier).onSubmit();
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
