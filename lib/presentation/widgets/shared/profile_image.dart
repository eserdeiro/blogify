import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final String url;
  final double borderRadius;
  const ProfileImage({
    required this.height,
    required this.width,
    required this.url,
    required this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        height: height,
        width: width,
        errorBuilder: (
          _,
          __,
          ___,
        ) {
          return Image.asset(
            'lib/assets/images/blank_profile.png',
            fit: BoxFit.cover,
            height: height,
            width: width,
          );
        },
      ),
    );
  }
}
