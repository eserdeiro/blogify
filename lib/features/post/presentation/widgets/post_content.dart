import 'package:blogify/features/post/presentation/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

class PostContent extends StatefulWidget {
  final String profileImage;
  final String profileUsername;
  final String createdAt;
  final String description;
  final String image;
  final String title;
  final bool isOwner;
  final Function()? onPressedDelete;
  const PostContent({
    required this.profileUsername,
    required this.createdAt,
    required this.description,
    required this.profileImage,
    required this.image,
    required this.title,
    super.key,
    this.isOwner = false,
    this.onPressedDelete,
  });

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
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
                urlFileImage: widget.profileImage,
                borderRadius: 30,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.profileUsername,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(widget.createdAt),
            if (widget.isOwner)
              IconButton(
                tooltip: 'Delete post',
                icon: const Icon(Icons.delete_outline_rounded),
                onPressed: widget.onPressedDelete,
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          widget.description,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        if (widget.image.isNotEmpty)
          ImagePost(
            image: widget.image,
          ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 0.5),
        ),
      ],
    );
  }
}
