import 'dart:async';

import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/features/user/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart'; 
import 'package:go_router/go_router.dart';

Future<void> showDialogDeleteAccount(
  BuildContext context,
  UserNotifier providerNotifier,
) async {
  final passwordController = TextEditingController();

  final currentContext =
      context;
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomElevatedButton(
                  text: 'Cancel',
                  onPressed: () {
                    passwordController.dispose();
                    context.pop();
                  },
                ),
              ),
              CustomElevatedButton(

                backgroundColor: colors.error,
                text: 'Confirm',
                onPressed: () async {
                  currentContext.pop();
                  final result =
                      await providerNotifier.delete(passwordController.text);
                      
                if (result.status == ResourceStatus.success &&
                      result.data is String &&
                      result.data == 'account-deleted') {
                    Future.delayed(Duration.zero, () {
                      showSnackBar(
                        currentContext,
                        Resource.getMessage(result.message),
                      );
                      currentContext.push(Strings.loginUrl);
                    });
                  }
                  passwordController.dispose();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
