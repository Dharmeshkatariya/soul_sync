import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soul_sync/core/utils/color_file.dart';

class CustomAssetImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Alignment alignment;

  const CustomAssetImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return path.endsWith('.svg')
        ? _buildSvgImage()
        : Image.asset(
            path,
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
          );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment,
    );
  }
}

class CommonAssetImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Alignment alignment;
  final BlendMode? colorBlendMode;

  final Color? color;

  const CommonAssetImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.colorBlendMode,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return path.endsWith('.svg')
        ? _buildSvgImage()
        : Image.asset(
            path,
            height: height ?? 24.h,
            width: width ?? 24.w,
            fit: fit,
            color: color ?? ColorFile.webThemeColor,
            colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
            alignment: alignment,
          );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      path,
      height: height ?? 24.h,
      width: width ?? 24.w,
      fit: fit,
      alignment: alignment,
      colorFilter: ColorFilter.mode(
        color ?? ColorFile.webThemeColor,
        colorBlendMode ?? BlendMode.srcIn,
      ),
    );
  }
}
