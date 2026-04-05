import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/constants/constants_file.dart';
import 'package:soul_sync/core/utils/color_file.dart';

class CustomTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final Color? backgroundColor;

  const CustomTooltip({
    super.key,
    required this.message,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      textStyle: TextStyle(
        fontFamily: ConstantsFile.regularFont,
        fontSize: 13.sp,
        color: ColorFile.whiteColor,
      ),
      textAlign: TextAlign.center,
      preferBelow: true,
      verticalOffset: 12,
      margin: EdgeInsets.only(left: 48.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorFile.lightBlack1Color,
        borderRadius: BorderRadius.circular(8.r),
        // shape: const TooltipShapeBorder(arrowArc: 0.5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
      child: child,
    );
  }
}

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  const TooltipShapeBorder({
    this.radius = 4.0,
    this.arrowWidth = 12.0,
    this.arrowHeight = 10.0,
    this.arrowArc = 1.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
      rect.topLeft,
      rect.bottomRight - Offset(0, arrowHeight),
    );
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx + x / 2, rect.bottomCenter.dy)
      ..relativeLineTo(-x / 2 * r, y * r)
      ..relativeQuadraticBezierTo(
        -x / 2 * (1 - r),
        y * (1 - r),
        -x * (1 - r),
        0,
      )
      ..relativeLineTo(-x / 2 * r, -y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
