import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

class ImagePost extends StatelessWidget {
  final ColorScheme colors;
  final Function()? onTapClear;
  final String image;

  const ImagePost({
    required this.colors,
    required this.image,
    super.key,
    this.onTapClear,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SizedBox.fromSize(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: ImageViewer(
              child: Image.network(image),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: ClipOval(
            child: Material(
              color: colors.background,
              child: InkWell(
                onTap: onTapClear,
                child: const SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(Icons.clear_outlined),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
