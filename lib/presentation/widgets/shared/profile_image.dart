import 'dart:io';

import 'package:blogify/presentation/views/account_view.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final String urlFileImage;
  final String urlAssetImage;
  final double borderRadius;
  const ProfileImage({
    required this.height,
    required this.width,
    required this.urlFileImage,
    required this.urlAssetImage,
    required this.borderRadius,
    super.key,
  });
//
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height,
      child: CircleAvatar(
        radius: borderRadius,
        backgroundColor: Colors.red,
        backgroundImage: imageController.text.isEmpty
            ? AssetImage(
                urlAssetImage,
              ) as ImageProvider
            : FileImage(File(urlFileImage)),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
