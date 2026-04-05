import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';

import '../core/utils/color_file.dart';

class MandatoryIndicator extends StatelessWidget {
  const MandatoryIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextView(
      ' *',
      style: AppTextStyles.mediumBlack14.copyWith(color: ColorFile.errorColor),
    );
  }
}

class CustomTitleWithMandatoryIndicator extends StatelessWidget {
  const CustomTitleWithMandatoryIndicator({
    super.key,
    required this.title,
    this.labelStyle,
    required this.isMandatory,
  });

  final String title;
  final TextStyle? labelStyle;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextView(
                title,
                style: labelStyle ?? AppTextStyles.mediumBlack14,
              ),
              if (isMandatory) const MandatoryIndicator(),
            ],
          ),
        if (title.isNotEmpty) SizedBox(height: 4.h),
      ],
    );
  }
}
