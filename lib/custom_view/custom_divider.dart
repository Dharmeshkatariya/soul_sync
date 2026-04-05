import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/color_file.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return _divider();
  }

  Widget _divider() {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(color: ColorFile.grayDDColor, height: 2.h),
    );
  }
}
