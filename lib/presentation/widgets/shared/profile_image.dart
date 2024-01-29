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
    print('url file image $urlFileImage');
    return SizedBox(
      height: height,
      width: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ImageViewer(
  child: urlFileImage.isEmpty
      ? Image.asset(
          Strings.assetProfileUrl,
          fit: BoxFit.cover,
        )
      : urlFileImage.startsWith('https')
          ? Image.network(
              urlFileImage,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(urlFileImage),
              fit: BoxFit.cover,
            ),
),
      ),
    );
  }
}
