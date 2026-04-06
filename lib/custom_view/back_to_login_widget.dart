import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import 'package:soul_sync/core/utils/color_file.dart';
import 'custom_gesture_detector.dart';

class BackToLoginWidget extends StatelessWidget {
  final VoidCallback? onClick;

  const BackToLoginWidget({super.key, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomTextView("Back to login"),
        SizedBox(width: 10.w),
        CustomGestureDetector(
          onTap: onClick ??
              () {
                Get.back();
              },
          child: CustomTextView(
            "Click Here",
            style: AppTextStyles.regularTheme14.copyWith(
              color: ColorFile.webThemeColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
