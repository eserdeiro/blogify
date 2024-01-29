import 'package:blogify/features/post/presentation/index.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                PostContent(
                  profileImage:
                      'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FyZAYIe?alt=media&token=48ca306c-d9f9-43a9-93ca-b934ed5b6516',
                  profileUsername: 'eserdeiro',
                  createdAt: timeago.format(DateTime.now()),
                  title: 'ejej',
                  description:
                      'Laboris exercitation ea fugiat labore id amet consequat esse. Irure aliqua culpa exercitation do. Magna deserunt proident nisi ad occaecat. Eu excepteur exercitation irure labore est quis voluptate consectetur. Elit culpa proident enim cillum laboris deserunt consequat velit veniam ut. Tempor do Lorem cillum proident nulla ullamco magna cillum sit ex aliqua.',
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FyZAYIe?alt=media&token=48ca306c-d9f9-43a9-93ca-b934ed5b6516',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
