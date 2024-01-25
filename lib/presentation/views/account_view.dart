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
            });
          }
        }
      },
      onError: (error) {
        print('Error: $error');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        try {
          //UserCredential, first login
          final firstAuthUserUid =
              (ref.watch(authProvider).user! as Success).data.user.uid;
          authUserId(firstAuthUserUid);
        } catch (_) {
          //User after login
          final authUserUid =
              (ref.watch(authProvider).user! as Success).data.uid;
          authUserId(authUserUid);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final orientationHelper = OrientationHelper(context);
    // final landscape = orientationHelper.isLandscape;
    // final size = MediaQuery.of(context).size;
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
        // height: landscape ? size.height * 0.4 : size.height * 0.2,
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
                          '$name$lastname',
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(34),
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),
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
