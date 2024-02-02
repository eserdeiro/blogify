import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/features/user/presentation/index.dart';
import 'package:blogify/infrastructure/index.dart';
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
  void initState() {
    super.initState();
    _formKey.currentState?.reset();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userEditForm = ref.watch(userEditFormProvider);
    final userEditNotifier = ref.read(userEditFormProvider.notifier);
    final colors = Theme.of(context).colorScheme;

    Future<void> handleImageSelection(
      BuildContext context,
      Future<String?> Function() selectImageFunction,
    ) async {
      try {
        final photo = await selectImageFunction();
        if (photo == null) return;
        userEditNotifier.onImageChange(photo);
      } catch (_) {
        ref.read(userProvider.notifier).setError('photo-could-not-be-selected');
      }
    }

    ref.listen(userProvider, (previous, next) {
      switch (next.user?.status) {
        case ResourceStatus.success:
          showSnackBar(context, next.user.data);
        case ResourceStatus.error:
          showSnackBar(
            context,
            Resource.getErrorMessage(next.user!.status, next.user!.error),
          );
        case ResourceStatus.loading:
          
          break;
        default:
          
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onLongPress: () async {
                        await showDialogSelectImage(context, () async {
                          await handleImageSelection(context, () async {
                            return CameraGalleryServicesImpl().selectPhoto();
                          });
                        }, () async {
                          await handleImageSelection(context, () async {
                            return CameraGalleryServicesImpl().takePhoto();
                          });
                        });
                      },
                      child: ProfileImage(
                        height: 120,
                        width: 120,
                        borderRadius: 70,
                        urlFileImage: userEditForm.image.isNotEmpty
                            ? userEditForm.image
                            : imageController.text,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: Strings.name,
                      initialValue: nameController.text,
                      onChanged: userEditNotifier.onNameChange,
                      errorText: userEditForm.name.errorMessage,
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextFormField(
                      label: Strings.lastname,
                      initialValue: lastnameController.text,
                      onChanged: userEditNotifier.onLastnameChange,
                      errorText: userEditForm.lastname.errorMessage,
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: Strings.username,
                initialValue: usernameController.text,
                onChanged: userEditNotifier.onUsernameChange,
                errorText: userEditForm.username.errorMessage,
                prefixIcon: const Icon(Icons.account_circle),
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                label: Strings.email,
                initialValue: emailController.text,
                onChanged: userEditNotifier.onEmailChange,
                errorText: userEditForm.email.errorMessage,
                prefixIcon: const Icon(Icons.mail_outlined),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomElevatedButton(
                  text: 'Save changes',
                  onPressed: () {
                    userEditNotifier.onSubmit(
                      nameController.text,
                      lastnameController.text,
                      usernameController.text,
                      emailController.text,
                    );
                  },
                ),
              ),
              CustomElevatedButton(
                text: 'Delete account',
                onPressed: () async {
                  final providerNotifier = ref.watch(userProvider.notifier);
                  await showDialogDeleteAccount(context, providerNotifier);
                },
                backgroundColor: colors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
