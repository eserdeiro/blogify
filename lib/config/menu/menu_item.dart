import 'package:blogify/config/index.dart';
import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/features/user/presentation/index.dart';
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
  MenuItem(
    title: 'Home',
    url: Strings.homeViewUrl,
    icon: Icons.home_outlined,
    view: const HomeView(),
  ),
    const MenuItem(
    title: 'Create',
    url: '/home/1',
    icon: Icons.post_add_outlined,
    view: CreatePostScreen(),
  ),
  const MenuItem(
    title: 'Account',
    url: '/home/2',
    icon: Icons.person,
    view: AccountView(),
  ),
];
