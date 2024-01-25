import 'package:blogify/config/index.dart';
import 'package:blogify/features/auth/domain/index.dart';
import 'package:blogify/features/auth/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  void authUserId(String userUid) {
    ref.read(userProvider.notifier).getUserById(userUid).listen(
      (result) {
        if (result is Success<UserEntity>) {
          if (mounted) {
            setState(() {
              userUsername = result.data.username;
            });
          }
        }
      },
      onError: (error) {
        // error TODO
        print('Error: $error');
      },
    );
  }

  String userUsername = '';
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              ref.watch(authProvider.notifier).logout().then((_) {
                context.pushReplacement(Strings.loginUrl);
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hello! Home screen $userUsername'),
      ),
    );
  }
}
