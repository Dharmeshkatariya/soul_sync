import 'package:flutter/material.dart';

class CustomTextView extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLine;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  const CustomTextView(
    this.text, {
    super.key,
    this.style,
    this.maxLine,
    this.textAlign,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow:
          textOverflow ?? (maxLine != null ? TextOverflow.ellipsis : null),
    );
  }
}
