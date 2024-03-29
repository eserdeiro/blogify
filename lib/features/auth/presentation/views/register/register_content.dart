import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterContent extends ConsumerWidget {
  const RegisterContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authProvider.notifier).checkAuthStatus();
    ref.listen(authProvider, (previous, next) {
      switch (next.user?.status) {
        case ResourceStatus.success:
          context.go(Strings.homeViewUrl);
        case ResourceStatus.error:
          showSnackBar(
            context,
            Resource.getMessage(next.user!.message),
          );
        case ResourceStatus.loading:
          break;
        default:
          break;
      }
    });

    final titleStyle = Theme.of(context).textTheme;
    final registerForm = ref.watch(registerFormProvider);
    final registerFormNotifier = ref.read(registerFormProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                Strings.register,
                style: titleStyle.headlineMedium,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: Strings.name,
                    onChanged: registerFormNotifier.onNameChange,
                    errorText: registerForm.isFormPosted
                        ? registerForm.name.errorMessage
                        : null,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextFormField(
                    label: Strings.lastname,
                    onChanged: registerFormNotifier.onLastnameChange,
                    errorText: registerForm.isFormPosted
                        ? registerForm.lastname.errorMessage
                        : null,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              label: Strings.username,
              onChanged: registerFormNotifier.onUsernameChange,
              errorText: registerForm.isFormPosted
                  ? registerForm.username.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.account_circle),
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              label: Strings.email,
              onChanged: registerFormNotifier.onEmailChange,
              errorText: registerForm.isFormPosted
                  ? registerForm.email.errorMessage
                  : null,
              prefixIcon: const Icon(Icons.mail_outlined),
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              obscureText: true,
              onChanged: registerFormNotifier.onPasswordChange,
              errorText: registerForm.isFormPosted
                  ? registerForm.password.errorMessage
                  : null,
              label: Strings.password,
              prefixIcon: const Icon(Icons.lock),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CustomElevatedButton(
                text: 'Check in',
                onPressed: () {
                  registerFormNotifier.onSubmit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
