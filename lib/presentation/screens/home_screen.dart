import 'package:blogify/presentation/views/home_view.dart';
import 'package:blogify/presentation/views/profile_view.dart';
import 'package:blogify/presentation/widgets/shared/custom_bottom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home_screen';
  final int page;

  const HomeScreen({required this.page, super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final viewRoutes = const [
    HomeView(), //Posts
    ProfileView(), // My posts
    ProfileView(), // Profile
  ];
  @override
  Widget build(BuildContext context) {

       return Scaffold(
        body: IndexedStack(
          index: widget.page,
          children: viewRoutes,
        ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: widget.page),

      );
  }
}
