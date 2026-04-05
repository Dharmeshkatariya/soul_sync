import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';

import '../core/utils/assets_icons.dart';
import '../core/utils/color_file.dart';
import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';
import 'custom_gesture_detector.dart';
import 'custom_text.dart';

class CustomAlertView extends StatelessWidget {
  const CustomAlertView({
    super.key,
    required this.backgroundColor,
    required this.assetIcon,
    required this.title,
    required this.message,
    required this.positiveText,
    required this.negativeText,
    required this.onPositivePressed,
    required this.onNegativePressed,
    this.isSingleButton = false,
    this.secondaryButtonBGColor, this.assetColor,
  });

  final Color backgroundColor;
  final String assetIcon;
  final String title;
  final String message;
  final String positiveText;
  final String negativeText;
  final Function() onPositivePressed;
  final Function() onNegativePressed;
  final Color? secondaryButtonBGColor;
  final bool isSingleButton;
  final  Color? assetColor ;

  @override
  Widget build(BuildContext context) {
    double? width;
    ResponsiveUtil.init(context);
    width =
         ResponsiveUtil.isWeb ? ResponsiveUtil.unitWidth * 36.75 : ResponsiveUtil.unitWidth * 80;
    Common().printLog('Width', width.toString());
    return Center(
      child: SizedBox(
        width: width > 480 ? 480.w : width,
        child: Material(
          color: ColorFile.transparentColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorFile.whiteColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.w,
                    horizontal: 15.w,
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            SvgPicture.asset(
                              assetIcon,
                              height: 60.h,
                              colorFilter: ColorFilter.mode(
                                assetColor ??  ColorFile.blueColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            CustomTextView(
                              title,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.boldBlack20,
                            ),

                            if (message.isNotEmpty) ...[
                              SizedBox(height: 10.h),
                              CustomTextView(
                                message,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.regularBlack14,
                              ),
                            ],
                            SizedBox(height: 20.h),
                            (isSingleButton)
                                ? CustomGestureDetector(
                                  onTap: onPositivePressed,
                                  child: Container(
                                    height: 40.h,
                                    width: 200.w,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 2.w,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorFile.blackColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7.r),
                                      ),
                                    ),
                                    child: CustomTextView(
                                      positiveText,
                                      style:
                                          ResponsiveUtil.isMediumWebOrLarger
                                              ? AppTextStyles.regularBlack14
                                                  .copyWith(
                                                    color: ColorFile.whiteColor,
                                                  )
                                              : AppTextStyles.regularBlack13
                                                  .copyWith(
                                                    color: ColorFile.whiteColor,
                                                  ),
                                    ),
                                  ),
                                )
                                : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorFile.blackColor,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      height: 40.h,
                                      width: 100.w,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        elevation: 0,
                                        textColor: ColorFile.blackColor,
                                        color:
                                            secondaryButtonBGColor ??
                                            ColorFile.warningColor,
                                        onPressed: onNegativePressed,
                                        child: CustomTextView(
                                          negativeText,
                                          style: AppTextStyles.boldBlack14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    CustomGestureDetector(
                                      onTap: onPositivePressed,
                                      child: Container(
                                        height: 40.h,
                                        width: 100.w,
                                        padding: EdgeInsets.only(
                                          left: 16.w,
                                          right: 16.w,
                                        ),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorFile.blackColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7.r),
                                          ),
                                        ),
                                        child: CustomTextView(
                                          positiveText,
                                          style:
                                              ResponsiveUtil.isMediumWebOrLarger
                                                  ? AppTextStyles.regularBlack14
                                                      .copyWith(
                                                        color:
                                                            ColorFile
                                                                .whiteColor,
                                                      )
                                                  : AppTextStyles.regularBlack13
                                                      .copyWith(
                                                        color:
                                                            ColorFile
                                                                .whiteColor,
                                                      ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0.0,
                        top: 0.0,
                        child: CustomGestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            AssetsIcons.icCancel,
                            height: 25.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
