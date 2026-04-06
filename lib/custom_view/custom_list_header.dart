import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';

class CustomListHeader extends StatelessWidget {
  final List<int> flexValues;
  final List<String> headerTexts;
  final TextStyle textStyle;
  final Color backgroundColor;
  final BorderRadius? borderRadius;

  const CustomListHeader({
    super.key,
    required this.flexValues,
    required this.headerTexts,
    this.textStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    ),
    this.backgroundColor = Colors.white,
    this.borderRadius,
  }) : assert(
          flexValues.length == headerTexts.length,
          'Flex values and header texts must have the same length',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(headerTexts.length, (index) {
          return Expanded(
            flex: flexValues[index],
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
              child: CustomTextView(
                headerTexts[index],
                style: textStyle,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }),
      ),
    );
  }
}
