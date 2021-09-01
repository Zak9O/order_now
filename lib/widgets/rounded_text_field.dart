import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/constants.dart';

class RoundedTextField extends StatelessWidget {
  RoundedTextField({
    this.labelText,
    this.hintText,
    this.errorText,
    this.controller,
    this.onTap,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.autoFocus = false,
    this.onChanged,
    this.maxLines = 1,
  });

  final String labelText;
  final String hintText;
  final String errorText;
  final Function onTap;
  final Function(String) onChanged;
  final bool obscureText;
  final bool autoFocus;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget suffix;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      focusNode: focusNode,
      onTap: onTap,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autocorrect: false,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffix: suffix,
        suffixIcon: suffixIcon,
        errorText: errorText,
        alignLabelWithHint: true,
        labelText: labelText,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 2.5,
          ),
        ),
      ),
    );
  }
}
