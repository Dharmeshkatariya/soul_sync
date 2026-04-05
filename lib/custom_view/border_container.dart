import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/color_file.dart';

class BorderContainer extends StatelessWidget {
  const BorderContainer(
      {required this.child,
        this.borderRadius,
        this.padding,
        this.margin,
        this.width,
        super.key,
        this.border,
        this.height,
        this.color,
        this.constraints, this.alignment});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final Color? color;
  final Alignment? alignment;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      margin: margin,
      alignment: alignment,
      constraints: constraints,
      decoration: BoxDecoration(
        color: color ?? ColorFile.whiteColor,
        border: border ?? Border.all(color: ColorFile.webBorderGrayColor),
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      ),
      width: width ?? 600.w,
      height: height,
      child: child,
    );
  }
}


