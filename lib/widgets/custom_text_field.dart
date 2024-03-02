import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final String? label;
  final bool isObscureText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? errorMessage;
  final Function()? onTap;
  final String? initialValue;
  final TextEditingController? controller;
  final bool readOnly;
  final bool enabled;

  const CustomTextField(
      {super.key,
      this.hint,
      this.label,
      this.isObscureText = false,
      this.onChanged,
      this.onFieldSubmitted,
      this.errorMessage,
      this.onTap,
      this.initialValue, this.controller, this.readOnly = false,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onChanged: onChanged,
      obscureText: isObscureText,
      onFieldSubmitted: onFieldSubmitted,
      initialValue: initialValue,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      style: const TextStyle(color: Color(0xff303030)),
      cursorColor: const Color(0xff5A4361),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Color(0xff303030)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff5A4361))),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffcccccc))),
        hintText: hint,
        label: label != null ? Text(label!) : null,
        errorText: errorMessage,
        
      ),
    );
  }
}
