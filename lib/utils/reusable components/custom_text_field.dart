import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final FocusNode? focusNode;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.focusNode,
    this.border,
    this.fillColor,
    this.filled = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscurePassword : false,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: widget.border ?? const UnderlineInputBorder(),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : widget.suffixIcon,
        fillColor: widget.fillColor,
        filled: widget.filled,
      ),
    );
  }
}
