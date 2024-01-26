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
    //provider from update data
    ref.listen(userProvider, (previous, next) {
      switch (next.user) {
        case Success _:
          showSnackBar(context, 'Updated data');
          return;
        case Error _:
          showSnackBar(context, (next.user! as Error).getErrorMessage());
        case Loading _:
        //TODO ADD LOADING
      }
    });

    final userEditForm = ref.watch(userEditFormProvider);
    final userEditNotifier = ref.read(userEditFormProvider.notifier);
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
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 24),
                child: Center(
                  child: ProfileImage(
                    width: 120,
                    height: 120,
                    borderRadius: 60,
                    url:
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: Strings.name,
                      controller: nameController,
                      onChanged: userEditNotifier.onNameChange,
                      errorText: userEditForm.isFormPosted
                          ? userEditForm.name.errorMessage
                          : null,
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextFormField(
                      label: Strings.lastname,
                      controller: lastnameController,
                      onChanged: userEditNotifier.onLastnameChange,
                      errorText: userEditForm.isFormPosted
                          ? userEditForm.lastname.errorMessage
                          : null,
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: Strings.username,
                controller: usernameController,
                onChanged: userEditNotifier.onUsernameChange,
                errorText: userEditForm.isFormPosted
                    ? userEditForm.username.errorMessage
                    : null,
                prefixIcon: const Icon(Icons.account_circle),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: Strings.email,
                controller: emailController,
                onChanged: userEditNotifier.onEmailChange,
                errorText: userEditForm.isFormPosted
                    ? userEditForm.email.errorMessage
                    : null,
                prefixIcon: const Icon(Icons.mail_outlined),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomElevatedButton(
                  text: 'Save changes',
                  onPressed: () {
                    userEditNotifier.onSubmit();
                  },
                ),
              ),
              CustomElevatedButton(
                text: 'Delete account',
                backgroundColor: colors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
