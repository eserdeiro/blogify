import 'dart:io';
import 'package:blogify/presentation/index.dart';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: ImageViewer(
          child: urlFileImage.isEmpty
              ? Image.asset(
                  urlAssetImage,
                  fit: BoxFit.cover,
                )
              //Url cache image
              : Image.file(
                  File(urlFileImage),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
