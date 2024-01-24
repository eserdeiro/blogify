import 'package:blogify/config/constants/strings.dart';
import 'package:blogify/config/utils/resource.dart';
import 'package:blogify/features/auth/domain/entities/user_entity.dart';
import 'package:blogify/features/auth/presentation/providers/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  String userUsername = '';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (mounted) {
        final currentUserUid =
            (ref.read(authProvider).user! as Success).data.uid;
        ref.read(userProvider.notifier).getUserById(currentUserUid).listen(
          (result) {
            if (result is Success<UserEntity>) {
              if (mounted) {
                setState(() {
                  userUsername = result.data.username;
                });
              }
            }
          },
        );
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
