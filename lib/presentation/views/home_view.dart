import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
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
                    description:
                        'Laboris exercitation ea fugiat labore id amet consequat esse. Irure aliqua culpa exercitation do. Magna deserunt proident nisi ad occaecat. Eu excepteur exercitation irure labore est quis voluptate consectetur. Elit culpa proident enim cillum laboris deserunt consequat velit veniam ut. Tempor do Lorem cillum proident nulla ullamco magna cillum sit ex aliqua.',
                    image:
                       'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FyZAYIe?alt=media&token=48ca306c-d9f9-43a9-93ca-b934ed5b6516',
                  ),
                  PostContent(
                    profileImage:
                        'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FofaCrM?alt=media&token=881fe538-e0a8-48f1-80b4-62270c23360d',
                    profileUsername: 'eserdeiro',
                    createdAt: timeago.format(DateTime.now()),
                    description:
                        'Sunt veniam mollit elit fugiat eu dolore ex.',
                    image:
                        'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FeSygxo?alt=media&token=eff5d6b9-2f2b-4c58-bb8b-8d4cc3d9267c',
                  ),
                   PostContent(
                    profileImage:
                        'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FofaCrM?alt=media&token=881fe538-e0a8-48f1-80b4-62270c23360d',
                    profileUsername: 'eserdeiro',
                    createdAt: timeago.format(DateTime.now()),
                    description:
                        'Consectetur voluptate eiusmod sunt duis.',
                    image:
                        'https://firebasestorage.googleapis.com/v0/b/blogify-66154.appspot.com/o/Users%2FOiDRsF?alt=media&token=0d701545-4c40-4662-b38b-907624132e24',
                  ),
                  
                ],
              );
            },
          ),
        ));
  }
}

class PostContent extends StatelessWidget {
  final String profileImage;
  final String profileUsername;
  final String createdAt;
  final String description;
  final String? image;
  const PostContent({
    required this.profileUsername,
    required this.createdAt,
    required this.description,
    required this.profileImage,
    this.image = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   //final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                child: ProfileImage(
                  height: 40,
                  width: 40,
                  urlFileImage: profileImage,
                  borderRadius: 30,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                profileUsername,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(createdAt),
              const SizedBox(width: 12),
              const Icon(Icons.more_horiz),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          ImagePost(
            image: image!,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Divider(height: 0.5),
          ),
        ],
      ),
    );
  }
}
