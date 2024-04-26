import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isPassword;
  final Color fieldcolor;
  const CustomTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.isPassword = false,
      this.fieldcolor = Colors.white10});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: Colors.white)),
    );
  }
}
