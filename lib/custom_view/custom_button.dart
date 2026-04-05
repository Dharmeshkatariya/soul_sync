import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/constants_file.dart';
import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import 'custom_gesture_detector.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final int height;
  double? width;
  double? assetSize;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  Color? bgColor;
  final Color textColor;
  final int textSize;
  bool hasBorder;
  ColorFilter? assetColorFilter;
  String? asset;
  String fontFamily;
  MainAxisSize mainAxisSize;
  bool isLoading;
  double radius;
  FlexFit fit;
  TextStyle? textStyle;
  bool minimal;
  bool isTextbutton;
  final bool? isSuffixIcon;

  CustomButton(
    this.text, {
    required this.onTap,
    this.assetColorFilter,
    this.asset,
    this.assetSize,
    this.height = 44,
    this.width,
    this.textStyle,
    this.hasBorder = false,
    this.bgColor = ColorFile.webThemeColor,
    this.textColor = ColorFile.whiteColor,
    this.textSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 26),
    this.fontFamily = ConstantsFile.mediumFont,
    this.mainAxisSize = MainAxisSize.min,
    this.isLoading = false,
    this.radius = 8.0,
    this.fit = FlexFit.loose,
    this.minimal = false,
    this.isTextbutton = false,
    this.isSuffixIcon = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if ((minimal) && (asset == null)) throw Exception('asset must not null');

    if (!isTextbutton) {
      return Semantics(
        excludeSemantics: true,
        child: (minimal)
            ? CustomGestureDetector(
                onTap: (isLoading) ? null : onTap,
                child: Container(
                  height: height.h,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: bgColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SvgPicture.asset(
                      asset!,
                      colorFilter: assetColorFilter,
                    ),
                  ),
                ),
              )
            : MaterialButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: (hasBorder) ? textColor : ColorFile.transparentColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                ),
                padding: padding,
                onPressed: (isLoading) ? null : onTap,
                disabledColor: ColorFile.grayDDColor,
                height: height.h,
                minWidth: width,
                color: bgColor,
                elevation: 0,
                child: (isLoading)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: mainAxisSize,
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: CircularProgressIndicator(color: textColor),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: mainAxisSize,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (asset != null && !isSuffixIcon!)
                            SvgPicture.asset(
                              asset!,
                              width: assetSize ?? 24.w,
                              height: assetSize ?? 24.w,
                              colorFilter: assetColorFilter,
                            ),
                          if (asset != null && !isSuffixIcon!)
                            SizedBox(width: 10.w),
                          Flexible(
                            fit: fit,
                            child: CustomTextView(
                              text,
                              style:
                                  textStyle ??
                                  AppTextStyles.mediumBlack14.copyWith(
                                    fontSize: textSize.sp,
                                    color: textColor,
                                    fontFamily: fontFamily,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (asset != null && isSuffixIcon!)
                            SizedBox(width: 10.w),
                          if (asset != null && isSuffixIcon!)
                            SvgPicture.asset(
                              asset!,
                              width: assetSize ?? 24.w,
                              height: assetSize ?? 24.w,
                              colorFilter: assetColorFilter,
                            ),
                        ],
                      ),
              ),
      );
    } else {
      return TextButton(
        onPressed: (isLoading) ? null : onTap,
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            color: ColorFile.webThemeColor,
            decoration: TextDecoration.underline,
          ),
          padding: padding,
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextView(
              text,
              style: AppTextStyles.semiBoldBlack14.copyWith(
                color: ColorFile.webThemeColor,
                decoration: TextDecoration.underline,
              ),
            ),
            if (asset != null)
              SvgPicture.asset(
                asset!,
                width: 24.w,
                height: 24.h,
                colorFilter: ColorFilter.mode(
                  ColorFile.webThemeColor,
                  BlendMode.srcIn,
                ),
              ),
          ],
        ),
      );
    }
  }
}
