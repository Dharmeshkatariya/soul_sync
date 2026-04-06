import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import '../core/utils/common_widget.dart';
import '../core/utils/responsive_util.dart';

class CommonSpanHeaderWidget extends StatelessWidget {
  const CommonSpanHeaderWidget({
    super.key,
    this.widget,
    this.onTapBack,
    this.isSubTitleAndForwardVisible = true,
    required this.title,
    required this.subTitle,
    this.expandedWidget,
  });

  final String title;
  final String subTitle;
  final Widget? widget;
  final bool isSubTitleAndForwardVisible;

  final Widget? expandedWidget;
  final Function? onTapBack;

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);
    return ResponsiveUtil.isWeb ? _forwardToWidget() : _forwardMobileToWidget();
  }

  Widget _forwardToWidget() {
    if (expandedWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _richCustomTextView(),
          SizedBox(width: 8.w),
          if (expandedWidget != null) ...[expandedWidget ?? Container()],
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _richCustomTextView(),
          SizedBox(width: 8.w),
          if (widget != null) ...[widget ?? Container()],
        ],
      );
    }
  }

  Widget _forwardMobileToWidget() {
    if (expandedWidget != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _richCustomTextView(),
          SizedBox(height: 10.h),
          if (expandedWidget != null) ...[expandedWidget ?? Container()],
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _richCustomTextView(),
          SizedBox(width: 8.w),
          if (widget != null) ...[widget ?? Container()],
        ],
      );
    }
  }

  Widget _richCustomTextView() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          CommonWidget.customWidgetSpanWidget(
            text: title,
            style: ResponsiveUtil.isWeb
                ? AppTextStyles.semiBoldBlack24.copyWith(
                    // color: ColorFile.webThemeColor,
                    )
                : AppTextStyles.semiBoldBlack20.copyWith(
                    // color: ColorFile.webThemeColor,
                    ),
            onTaped: () {
              if (onTapBack != null) {
                onTapBack!();
              } else {
                Get.back();
              }
            },
          ),
          if (isSubTitleAndForwardVisible) ...[
            CommonWidget.customWidgetSpanWidget(
              text: ' > ',
              style: ResponsiveUtil.isWeb
                  ? AppTextStyles.semiBoldBlack24.copyWith(
                      color: ColorFile.lightBlack1Color,
                    )
                  : AppTextStyles.semiBoldBlack20.copyWith(
                      color: ColorFile.lightBlack1Color,
                    ),
            ),
            CommonWidget.customWidgetSpanWidget(
              text: " $subTitle",
              style: ResponsiveUtil.isWeb
                  ? AppTextStyles.mediumBlack20.copyWith(
                      color: ColorFile.lightBlack1Color,
                    )
                  : AppTextStyles.mediumBlack16.copyWith(
                      color: ColorFile.lightBlack1Color,
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
