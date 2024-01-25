import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountEditScreen extends ConsumerStatefulWidget {
  const AccountEditScreen({super.key});
  static String accountEditScreenName = Strings.accountEditScreenName;
  @override
  AccountEditScreenState createState() => AccountEditScreenState();
}

class AccountEditScreenState extends ConsumerState<AccountEditScreen> {
  @override
  Widget build(BuildContext context) {
    final registerForm = ref.watch(registerFormProvider);
    final registerFormNotifier = ref.read(registerFormProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: Strings.name,
                      initialValue: name,
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
                      initialValue: lastname,
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
                initialValue: username,
                onChanged: registerFormNotifier.onUsernameChange,
                errorText: registerForm.isFormPosted
                    ? registerForm.username.errorMessage
                    : null,
                prefixIcon: const Icon(Icons.mail_outlined),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: Strings.email,
                initialValue: email,
                onChanged: registerFormNotifier.onEmailChange,
                errorText: registerForm.isFormPosted
                    ? registerForm.email.errorMessage
                    : null,
                prefixIcon: const Icon(Icons.mail_outlined),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CustomElevatedButton(
                  text: 'Save changes',
                ),
              ),
              CustomElevatedButton(
                text: 'Delete account',
                backgroundColor: colors.error,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
