import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/tooltip/custom_tooltip_with_arrow.dart';
import '../core/utils/color_file.dart';
import 'custom_gesture_detector.dart';

class WebCustomActionButton extends StatelessWidget {
  final String message;
  final String icon;
  final VoidCallback onTaped;
  final double? iconWidth;
  final double? iconHeight;
  final ColorFilter? colorFilter;

  const WebCustomActionButton({
    required this.message,
    required this.icon,
    required this.onTaped,
    this.iconWidth,
    this.iconHeight,
    this.colorFilter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTooltipWithArrow(
      message: message,
      key: key,
      child: CustomGestureDetector(
        onTap: () {
          onTaped();
        },
        child: Container(
          width: 38.w,
          height: 38.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorFile.transparentColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: ColorFile.grayDDColor),
          ),
          child: SvgPicture.asset(
            icon,
            width: iconHeight ?? 17.w,
            height: iconHeight ?? 17.w,
            colorFilter:
                colorFilter ??
                ColorFilter.mode(ColorFile.blackColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomActionWidget extends StatelessWidget {
  final String message;
  Function()? onTap;
  Widget child;
  double? width;
  double? height;
  Color color;

  CustomActionWidget({
    required this.message,
    required this.onTap,
    required this.child,
    this.color = ColorFile.webThemeColorOpaque10Copy,
    this.width = 56,
    this.height = 56,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTooltipWithArrow(
      message: message,
      child: CustomGestureDetector(
        onTap: onTap,
        cursor: (onTap == null)
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: child,
        ),
      ),
    );
  }
}
