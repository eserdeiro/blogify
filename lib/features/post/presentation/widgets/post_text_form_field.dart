import 'package:flutter/material.dart';

class PostTextFormField extends StatelessWidget {
  final int? maxLenght;
  final String? hintText;
  final double? fontSize;
  final FontWeight? fontWeight;
  const PostTextFormField(
      {this.maxLenght,
      this.hintText,
      this.fontWeight,
      this.fontSize,
      super.key,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      maxLength: maxLenght,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: hintText,
      ),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
