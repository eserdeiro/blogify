import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String url;
  final IconData icon;
  final Widget view;

  const MenuItem({
    required this.title,
    required this.url,
    required this.icon,
    required this.view,
  });
}

List<MenuItem> appMenuItems = <MenuItem>[
  const MenuItem(
    title: 'Home',
    url: '/home/0',
    icon: Icons.home_max,
    view: HomeView(),
  ),
  const MenuItem(
    title: 'My posts',
    url: '/home/1',
    icon: Icons.list,
    view: ProfileView(),
  ),
  const MenuItem(
    title: 'Profile',
    url: '/home/2',
    icon: Icons.person,
    view: ProfileView(),
  ),
];
