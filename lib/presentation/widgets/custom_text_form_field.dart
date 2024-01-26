import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool obscureText;
  final Function(String)? onChanged;
  final String? errorText;
  final String? Function(String?)? validator;
  final String? hint;
  final String? initialValue;
  final String? label;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Function(String?)? onSaved;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.errorText,
    this.hint,
    this.initialValue,
    this.label,
    this.obscureText = false,
    this.onChanged,
    this.prefixIcon,
    this.validator, this.onSaved,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(8),
    );

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      obscureText: !_showPassword && widget.obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        enabledBorder: inputBorder,
        errorBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: colors.secondary),
        ),
        isDense: true,
        label: widget.label != null ? Text(widget.label!) : null,
        hintText: widget.hint,
        focusColor: colors.primary,
        prefixIcon: widget.prefixIcon,
        errorText: widget.errorText,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: colors.primary,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              )
            : null,
      ),
    );
  }
}
