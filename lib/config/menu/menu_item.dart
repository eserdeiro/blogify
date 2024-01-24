import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String url;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.url,
    required this.icon,
  });
}

List<MenuItem> appMenuItems = <MenuItem>[
  const MenuItem(
    title: 'Home',
    url: '/home',
    icon: Icons.home_max,
  ),
  const MenuItem(
    title: 'My posts',
    url: '/',
    icon: Icons.list,
  ),
    const MenuItem(
    title: 'Profile',
    url: '/profile',
    icon: Icons.person,
  ),
];
