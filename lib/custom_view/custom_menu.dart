import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/utils/color_file.dart';
import '../core/utils/responsive_util.dart';

class CustomMenu {
  static Future showCustomMenu({
    required GlobalKey globalKey,
    required BuildContext context,
    required Widget child,
    double? width,
    double? height,
    EdgeInsets? padding,
    bool beginFromTop = false,
  }) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox popupButton =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    width ??= globalKey.currentContext!.size!.width;
    height ??= Get.height;
    final Offset offset = popupButton.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );

    return showMenu(
      context: context,
      color: ColorFile.whiteColor,
      surfaceTintColor: ColorFile.whiteColor,
      position: RelativeRect.fromLTRB(
        offset.dx,
        (beginFromTop)
            ? offset.dy - height
            : offset.dy + popupButton.size.height,
        offset.dx + 0,
        offset.dy + popupButton.size.height,
      ),
      constraints: BoxConstraints(
        minWidth: width,
        maxWidth: width,
        maxHeight: height,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      items: [PopupMenuItem(enabled: false, padding: padding, child: child)],
    );
  }

  static void showCustomPopupMenu({
    required GlobalKey globalKey,
    required BuildContext context,
    required Widget child,
    double elevation = 4.0,
    double? width,
    double height = 200,
    bool alignTop = false,
    bool barrierDismissible = true,
  }) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox popupButton =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    width ??= globalKey.currentContext!.size!.width;
    final Offset offset = popupButton.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );

    double leftPosition = offset.dx;
    if (leftPosition + width > MediaQuery.of(context).size.width) {
      leftPosition = MediaQuery.of(context).size.width - width - 16;
    }

    final double screenHeight = MediaQuery.of(context).size.height;
    final double popupHeight = popupButton.size.height + height;
    double topPosition = offset.dy + popupButton.size.height;

    // Check if the dialog would go off the bottom of the screen
    if (topPosition + popupHeight > screenHeight) {
      topPosition =
          screenHeight - popupHeight - 16; // Adjust to fit within the screen
    }

    // Ensure dialog is visible above the widget when alignTop is true
    if (alignTop) {
      topPosition = offset.dy - popupHeight;
      if (topPosition < 0) {
        topPosition = 16; // Adjust to avoid going off the top of the screen
      }
    }

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: leftPosition,
              top: topPosition,
              width: width,
              child: Material(
                color: Colors.transparent,
                elevation: elevation,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorFile.whiteColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // use this
  static void fromTop(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      // Background color
      transitionDuration: const Duration(milliseconds: 500),
      // Animation duration
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(color: Colors.transparent, child: child),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  static fromBottom(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return Get.generalDialog(
      barrierLabel: "Label",
      barrierDismissible: barrierDismissible,
      barrierColor: ColorFile.transparentColor,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(right: 240.w),
            child: child,
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Future customCenterDialog({
    Widget? child,
    Offset? endOffset,
    double? width,
  }) async {
    return Get.generalDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: ColorFile.blackColorOpaque80,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: AlignmentDirectional.topCenter,
          child: Material(
            color: ColorFile.transparentColor,
            child: Container(
              width: width ?? (ResponsiveUtil.isWeb ? 550.w : Get.width),
              constraints: BoxConstraints(
                maxHeight: ResponsiveUtil.isWeb ? 550.h : 550.w,
              ),
              margin: ResponsiveUtil.isWeb
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close, color: ColorFile.whiteColor),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: ColorFile.whiteColor,
                    ),
                    width: width ?? (ResponsiveUtil.isWeb ? 550.w : Get.width),
                    constraints: BoxConstraints(
                      maxHeight: ResponsiveUtil.isWeb ? 500.h : 500.w,
                    ),
                    child: SingleChildScrollView(child: child),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0),
            end: endOffset ?? Offset(0, ResponsiveUtil.isWeb ? 0.25 : 0.12),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Future getDialog({required Widget? child}) async {
    return Get.dialog(child!);
  }
}
