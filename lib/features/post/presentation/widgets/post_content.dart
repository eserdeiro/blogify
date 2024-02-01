import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final String profileImage;
  final String profileUsername;
  final String createdAt;
  final String description;
  final String image;
  final String title;
  final bool   isOwner;
  const PostContent({
    required this.profileUsername,
    required this.createdAt,
    required this.description,
    required this.profileImage,
    required this.image,
    required this.title,
    super.key, 
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            const SizedBox(width: 8),
            Text(
              profileUsername,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(createdAt),
            if(isOwner)
             IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                
              },),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        if (image.isNotEmpty)
          ImagePost(
            image: image,
          ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 0.5),
        ),
      ],
    );
  }
}
