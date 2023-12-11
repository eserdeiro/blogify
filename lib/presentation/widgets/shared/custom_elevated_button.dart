import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  const CustomElevatedButton({
    super.key, 
    this.onPressed, 
    required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                )
              ),
               child: Text(text))
             );
  }
}