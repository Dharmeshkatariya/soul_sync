import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import 'package:soul_sync/custom_view/custom_text.dart';
import '../core/utils/color_file.dart';

class TextSwitch extends StatelessWidget {
  TextSwitch({
    super.key,
    required this.isSwitched,
    required this.onChange,
    required this.positiveText,
    required this.negativeText,
    this.title = '',
    this.toggleActiveColor,
    this.backgroundColor,
  });

  var isSwitched = false.obs;
  Function(bool) onChange;
  String positiveText;
  String negativeText;
  String title;
  Color? toggleActiveColor;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            CustomTextView(title, style: AppTextStyles.mediumBlack14),
          if (title.isNotEmpty) SizedBox(height: 4.h),
          Container(
            width: Get.width,
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              border: Border.all(color: ColorFile.grayDDColor),
              borderRadius: BorderRadius.circular(6.r),
              color: backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextView(
                  (isSwitched.value) ? positiveText : negativeText,
                  style: AppTextStyles.mediumBlack14,
                ),
                SizedBox(
                  height: 30.h,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch.adaptive(
                      activeTrackColor:
                          toggleActiveColor ?? ColorFile.greenColor,
                      inactiveThumbColor: ColorFile.whiteColor,
                      value: isSwitched.value,
                      onChanged: (value) {
                        isSwitched.value = value;
                        onChange(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
