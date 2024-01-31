import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  const CustomElevatedButton({
    required this.text,
    super.key,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
