import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';

class CommonDialogWrapper extends StatelessWidget {
  final double height, width;
  final Widget child;
  final VoidCallback? onCloseCick;
  final bool showClose;

  const CommonDialogWrapper({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    this.showClose = true,
    this.onCloseCick,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.transparent,
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showClose)
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: onCloseCick ?? () => Get.back(),
                        icon: Icon(
                          Icons.close,
                          size: 24.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  SizedBox(height: 5.w),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
