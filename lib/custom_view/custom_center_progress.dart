import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/color_file.dart';


class CustomCenterProgress extends StatelessWidget {
  const CustomCenterProgress({
    this.height,
    this.width,
    super.key
  });

  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??Get.height,
      width: width,
      child: Center(
          child: CircularProgressIndicator(
        color: ColorFile.webThemeColor,
      )),
    );
  }
}
