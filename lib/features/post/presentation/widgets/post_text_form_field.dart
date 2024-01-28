import 'package:flutter/material.dart';

class PostTextFormField extends StatelessWidget {
  final Function(String)? onChanged;
  final int? maxLenght;
  final String? hintText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? initialValue;
  final TextEditingController? controller;
  const PostTextFormField({
    this.maxLenght,
    this.hintText,
    this.fontWeight,
    this.fontSize,
    super.key,
    this.onChanged, 
    this.initialValue, 
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
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
