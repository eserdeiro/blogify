import 'package:blogify/config/constants/strings.dart';
import 'package:blogify/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//Not used
class HomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
           ref.watch(authProvider.notifier).logout();
           context.pushReplacement(Strings.loginUrl);
          },
          child: const Text('Hello! Home screen, click para logout'),
        ),
      ),
    );
  }
}
