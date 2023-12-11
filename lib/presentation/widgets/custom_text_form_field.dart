import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
      final String? label;
      final String? hint;
      final String? errorText;
      final Widget? prefixIcon;
      final bool obscureText;
      final Function(String)? onChanged;
      final String? Function(String?)? validator;

  const CustomTextFormField({super.key, 
  this.label, 
  this.hint, 
  this.errorText, 
  this.onChanged, 
  this.validator, 
  this.prefixIcon, 
  this.obscureText = false});

  @override
  Widget build(BuildContext context) {

      final colors = Theme.of(context).colorScheme;
      final inputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: colors.primary),
        borderRadius: BorderRadius.circular(10)
      );


    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: inputBorder,
        errorBorder  : inputBorder,
        focusedErrorBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(borderSide: BorderSide(color: colors.secondary)),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        focusColor: colors.primary,
        prefixIcon: prefixIcon,
        errorText: errorText
      )
    );
  }
}