import 'dart:io';

import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

class ImagePost extends StatelessWidget {
  final Function()? onTapClear;
  final String image;
  final bool clearButton;
  final double? height;
  final double? width;

  const ImagePost({
    required this.image,
    super.key,
    this.onTapClear,
    this.clearButton = false,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: ImageViewer(
                child: image.startsWith('https')
                    ? Image.network(
                        image,
                        fit: BoxFit.contain,
                      )
                    : Image.file(
                        File(image),
                        fit: BoxFit.cover, // 
                      ),
              ),
            ),
            if (clearButton == true)
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
        ),
      ),
    );
  }
}
