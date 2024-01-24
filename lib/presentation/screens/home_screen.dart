import 'package:blogify/presentation/views/home_view.dart';
import 'package:blogify/presentation/views/profile_view.dart';
import 'package:blogify/presentation/widgets/shared/custom_bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int page;

  const HomeScreen({required this.page, super.key});
  static const String name = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    Widget build(BuildContext context) {
         const viewRoutes = [
      HomeView(), //Posts
      ProfileView(), // My posts
      ProfileView(), // Profile
    ];
      return Scaffold(
        body: IndexedStack(
          index: widget.page,
          children: viewRoutes,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(currentIndex: widget.page),
      );
    }
}
