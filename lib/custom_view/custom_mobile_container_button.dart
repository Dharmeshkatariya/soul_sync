import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/color_file.dart';

class CustomMobileContainerButton extends StatelessWidget {
  const CustomMobileContainerButton({
    super.key,
    required this.child,
    this.padding,
    this.isCreatePermission = true,
    required this.horizontalPadding,
  });

  final Widget child;
  final double horizontalPadding;
  final bool isCreatePermission;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isCreatePermission,
      child: Container(
        color: ColorFile.whiteColor,
        padding: padding ??
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.h),
        child: child,
      ),
    );
  }
}
