import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showDialogDeleteAccount(
  BuildContext context,
  Future<void> Function(String password) function,
) async {
  final TextEditingController passwordController = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final colors = Theme.of(context).colorScheme;
      final size = MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: colors.background,
        insetPadding: EdgeInsets.zero,
        title: const Text('Confirm your password'),
        content: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.20,
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
                controller: passwordController,
                onChanged: (p0) {
                  // Puedes realizar alguna lógica aquí si es necesario
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomElevatedButton(
                  text: 'Cancel',
                  onPressed: () => context.pop(),
                ),
              ),
              CustomElevatedButton(
                backgroundColor: colors.error,
                text: 'Confirm',
                onPressed: () async {
                  context.pop();
                  await function(passwordController.text);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
