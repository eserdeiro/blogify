import 'package:blogify/config/index.dart';
import 'package:blogify/presentation/index.dart'; 
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int page;

  const HomeScreen({required this.page, super.key});
  static String name = Strings.homeScreenName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final viewRoutes = appMenuItems.map((menuItem) => menuItem.view).toList();

class _HomeScreenState extends State<HomeScreen> {
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
