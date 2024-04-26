import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:offline_ai/const/color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontsize;
  final Color textcolor;
  const CustomText(
      {super.key,
      required this.text,
      this.fontWeight = FontWeight.normal,
      this.fontsize = 18,
      this.textcolor = secondarycolor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textcolor, fontSize: fontsize, fontWeight: fontWeight),
    );
  }
}
