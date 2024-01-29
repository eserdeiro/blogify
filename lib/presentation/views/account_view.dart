import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  AccountViewState createState() => AccountViewState();
}

String username = 'unkwnown';
String name = 'unkwnown';
String lastname = 'unkwnown';
String email = 'unkwnown';
String image = '';
late TextEditingController nameController;
late TextEditingController lastnameController;
late TextEditingController usernameController;
late TextEditingController emailController;
late TextEditingController imageController;

class AccountViewState extends ConsumerState<AccountView> {
  void authUserId(String userUid) {
    ref.read(userProvider.notifier).getUserById(userUid).listen(
      (result) {
        if (result is Success<UserEntity>) {
          if (mounted) {
            setState(() {
              final resultData = result.data;
              username = resultData.username;
              name = resultData.name;
              lastname = resultData.lastname;
              email = resultData.email;
              image = resultData.image;

              nameController.text = name;
              lastnameController.text = lastname;
              usernameController.text = username;
              emailController.text = email;
              imageController.text = image;
            });
          }
        } else if (result is Error<dynamic>) {
          showSnackBar(context, (result as Error).getErrorMessage());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    lastnameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    imageController = TextEditingController();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        try {
          //UserCredential, first login
          final firstAuthUserUid =
              (ref.watch(authProvider).user! as Success).data.user.uid;
          authUserId(firstAuthUserUid);
        } catch (_) {
          //User after login
          try {
            final authUserUid =
                (ref.watch(authProvider).user! as Success).data.uid;
            authUserId(authUserUid);
          } catch (_) {
            return;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('image en view $image');
    return Scaffold(
      appBar: AppBar(
        actions: [
          Tooltip(
            message: 'Log out',
            child: IconButton(
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                ref.watch(authProvider.notifier).logout().then((_) {
                  context.go(Strings.loginUrl);
                });
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name $lastname',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '$username ( $email )',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //edit this widget
                  ProfileImage(
                    height: 70,
                    width: 70,
                    borderRadius: 70,
                    urlFileImage: image,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: CustomElevatedButton(
                          text: 'Edit profile',
                          onPressed: () => context.push(Strings.accountEditUrl),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: CustomElevatedButton(text: 'Share profile'),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
