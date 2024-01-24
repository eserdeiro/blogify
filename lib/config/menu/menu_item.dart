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
    url: '/home/0',
    icon: Icons.home_max,
  ),
  const MenuItem(
    title: 'My posts',
    url: '/home/1',
    icon: Icons.list,
  ),
    const MenuItem(
    title: 'Profile',
    url: '/home/2',
    icon: Icons.person,
  ),
];
