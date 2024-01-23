import 'package:flutter/material.dart';

//Not used
class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: 
      Text('Hello! Home screen'),),
    );
  }
}
