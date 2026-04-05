import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import 'package:soul_sync/core/utils/color_file.dart';
import 'package:soul_sync/core/utils/common.dart';

class InitialsCircularImage extends StatelessWidget {
  const InitialsCircularImage(
    this.text, {
    super.key,
    this.width = 40,
    this.height = 40,
    this.textSize = 14,
  });
  final String text;
  final double textSize;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.w,
      decoration: BoxDecoration(
        color: ColorFile.webThemeColorOpaque10,
        borderRadius: BorderRadius.all(Radius.circular(60.r)),
      ),
      child: Center(
        child: CustomTextView(
          Common.getInitials(text),
          style: AppTextStyles.semiBoldBlack14.copyWith(fontSize: textSize),
        ),
      ),
    );
  }
}
