import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import '../core/utils/constant_status.dart';
import 'border_container.dart';
import 'custom_gesture_detector.dart';
import 'custom_horizontal_pager.dart';
import 'custom_text_view.dart';

class CustomHorizontalTitlePager extends StatelessWidget {
  const CustomHorizontalTitlePager({
    required this.mList,
    required this.onTap,
    required this.child,
    this.margin,
    this.selectedItem,
    this.padding,
    this.alignment,
    this.isShowCount = false,
    this.isExpandedPager = false,
    this.itemWidth,
    this.headerPadding,
    this.title,
    super.key,
    this.constraints,
    this.titlePadding,
    this.width,
  });

  final List<PagerModel> mList;
  final PagerModel? selectedItem;
  final Function(PagerModel) onTap;
  final bool isShowCount;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? headerPadding;
  final AlignmentGeometry? alignment;
  final bool isExpandedPager;
  final double? itemWidth;
  final Widget child;
  final BoxConstraints? constraints;
  final String? title;
  final EdgeInsetsGeometry? titlePadding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      padding: EdgeInsets.zero,
      constraints: constraints,
      width: width ?? double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty)
            Container(
              width: double.infinity,
              padding: titlePadding ?? EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: ColorFile.grayColorF9F9F9,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
              ),
              child:
                  CustomTextView(title!, style: AppTextStyles.semiBoldBlack16),
            ),
          isExpandedPager
              ? _expandedPager()
              : Container(
                  margin: margin,
                  padding: headerPadding ?? EdgeInsets.zero,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorFile.grayColorF9F9F9,
                    border: const Border(
                      bottom: BorderSide(color: ColorFile.webBorderGrayColor),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                    ),
                  ),
                  child: Align(
                    alignment: alignment ?? Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                          top: 15.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            mList.length,
                            (index) {
                              var item = mList[index];
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _pagerItem(item),
                                  if (index < mList.length - 1)
                                    SizedBox(width: itemWidth ?? 40.w),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          Container(
            padding: padding ?? EdgeInsets.only(top: 15.w, bottom: 15.w),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _expandedPager() {
    return Container(
      margin: margin,
      padding: headerPadding ?? EdgeInsets.only(top: 24.h),
      width: double.infinity,
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: Row(
          children: List.generate(mList.length, (index) {
            var item = mList[index];
            return Expanded(
              child: _pagerItem(item),
            );
          }),
        ),
      ),
    );
  }

  Widget _pagerItem(PagerModel item) {
    return CustomGestureDetector(
      onTap: () => onTap(item),
      child: Container(
        padding: EdgeInsets.only(bottom: 15.h),
        alignment: isExpandedPager ? Alignment.center : Alignment.centerLeft,
        decoration: (item == selectedItem)
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorFile.webThemeColor,
                    width: 3.h,
                  ),
                ),
              )
            : null,
        child: Row(
          mainAxisSize: isExpandedPager ? MainAxisSize.min : MainAxisSize.max,
          children: [
            CustomTextView(
              item.displayText ?? "",
              style: (item == selectedItem)
                  ? AppTextStyles.semiBoldBlack14
                      .copyWith(color: ColorFile.webThemeColor)
                  : AppTextStyles.regularBlack14.copyWith(
                      color: ColorFile.lightBlack1Color,
                    ),
            ),
            if (isShowCount)
              Obx(() {
                return CustomTextView(
                  item.text == ConstantStatus.myWallet
                      ? '(\$${item.count!.value.toStringAsFixed(2)})'
                      : '(${item.count!.value})',
                  style: (item == selectedItem)
                      ? AppTextStyles.semiBoldBlack14
                          .copyWith(color: ColorFile.webThemeColor)
                      : AppTextStyles.regularBlack14.copyWith(
                          color: ColorFile.lightBlack1Color,
                        ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
