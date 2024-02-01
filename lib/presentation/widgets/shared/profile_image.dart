import 'dart:io';
import 'package:blogify/config/index.dart';
import 'package:blogify/presentation/index.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final String urlFileImage;
  final double borderRadius;
  const ProfileImage({
    required this.height,
    required this.width,
    required this.urlFileImage,
    required this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const borderWidth = 1.0;
    final totalSize = height + borderWidth * 2;
    return SizedBox(
      height: totalSize,
      width: totalSize,
      child: Container(
        width: totalSize,
        height: totalSize,
        padding: const EdgeInsets.all(borderWidth), // Ajusta el espacio aquí
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: ClipOval(
          child: ImageViewer(
            child: urlFileImage.isEmpty
                //Local image
                ? Image.asset(
                    Strings.assetProfileUrl,
                    fit: BoxFit.cover,
                  )
                //Network image
                : urlFileImage.startsWith('https')
                    ? Image.network(
                        urlFileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Image.asset(
                            Strings.assetProfileUrl,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    //Cache image
                    : Image.file(
                        File(urlFileImage),
                        fit: BoxFit.cover,
                      ),
          ),
        ),
      ),
    );
  }
}
