import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Color? fieldcolor;
  final Color hintcolor;
  final bool isPassword;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.hintcolor = Colors.black,
    this.prefixIcon,
    this.suffixIcon,
    this.fieldcolor,
    this.isPassword = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        obscureText: widget.isPassword ? _obscureText : false,
        controller: widget.controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: widget.hintcolor),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          fillColor: widget.fieldcolor,
        ),
      ),
    );
  }
}
