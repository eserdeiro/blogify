import 'package:flutter/material.dart';

class PostTextFormField extends StatefulWidget {
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
  State<PostTextFormField> createState() => _PostTextFormFieldState();
}

class _PostTextFormFieldState extends State<PostTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      maxLines: null,
      maxLength: widget.maxLenght,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: widget.hintText,
      ),
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
    );
  }
}
