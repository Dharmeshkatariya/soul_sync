import 'package:flutter/material.dart';

class CustomTextView extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;

  const CustomTextView(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textAlign,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow:
          textOverflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
    );
  }
}
