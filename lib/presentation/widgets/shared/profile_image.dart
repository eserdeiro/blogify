import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final String urlFileImage;
  final String urlAssetImage;
  final double borderRadius;
  final String controllerText;
  const ProfileImage({
    required this.height,
    required this.width,
    required this.urlFileImage,
    required this.urlAssetImage,
    required this.borderRadius,
    required this.controllerText,
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
        backgroundImage: urlFileImage.isEmpty
            ?
            //Image local no http
            AssetImage(
                urlAssetImage,
              ) as ImageProvider
            :
            //Image cache
            FileImage(File(urlFileImage)),
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
