import 'dart:io';

import 'package:blogify/config/index.dart';
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
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 500,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: ImageViewer(
                child: (image.startsWith('blob') || image.startsWith('https'))
                //Network image
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Image.asset(
                            Strings.assetDefaultImageeUrl,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                      //Local image
                    : Image.file(
                        File(image),
                        fit: BoxFit.cover,
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
