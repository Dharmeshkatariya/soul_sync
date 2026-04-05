import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import 'custom_gesture_detector.dart';
import 'custom_horizontal_pager.dart';

class CustomVerticalPager extends StatelessWidget {
  final List<PagerModel> mList;
  final PagerModel selectedItem;
  final Function(int) onTap;
  final double? width;
  final bool isHorizontal;

  const CustomVerticalPager(
    this.mList,
    this.selectedItem,
    this.onTap, {
    this.width,
    this.isHorizontal = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isHorizontal ? _buildHorizontalList() : _buildVerticalList();
  }

  Widget _buildVerticalList() {
    return Container(
      width: width ?? 200.w,
      padding: EdgeInsets.symmetric(vertical: 14.w),
      decoration: BoxDecoration(
        color: ColorFile.whiteColor,
        border: Border.all(color: ColorFile.webBorderGrayColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListView.separated(
        itemCount: mList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final mItem = mList[index];
          return CustomGestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 14.w),
              padding: EdgeInsets.only(
                right: 5.w,
                top: 7.h,
                bottom: 7.h,
                left: 10.sp,
              ),
              decoration: BoxDecoration(
                color: mItem == selectedItem
                    ? ColorFile.titleBGColor
                    : ColorFile.transparentColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextView(
                      mItem.displayText ?? "",
                      style: mItem == selectedItem
                          ? AppTextStyles.semiBoldBlack14.copyWith(
                              color: ColorFile.webThemeColor,
                            )
                          : AppTextStyles.mediumBlack14.copyWith(
                              color: ColorFile.blackColor,
                            ),
                    ),
                  ),
                  mItem == selectedItem
                      ? const Icon(Icons.navigate_next)
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 6.w);
        },
      ),
    );
  }

  Widget _buildHorizontalList() {
    return Container(
      height: 70,
      width: MediaQuery.of(Get.context!).size.width,
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: ColorFile.whiteColor,
        border: Border.all(color: ColorFile.webBorderGrayColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListView.builder(
        itemCount: mList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final mItem = mList[index];
          return CustomGestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Container(
              margin: EdgeInsets.only(right: 14.w),
              padding: EdgeInsets.only(
                right: 5.w,
                top: 7.h,
                bottom: 7.h,
                left: 10.sp,
              ),
              decoration: BoxDecoration(
                color: mItem == selectedItem
                    ? ColorFile.titleBGColor
                    : ColorFile.transparentColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              child: Row(
                children: [
                  CustomTextView(
                    mItem.displayText ?? "",
                    style: mItem == selectedItem
                        ? AppTextStyles.semiBoldBlack14.copyWith(
                            color: ColorFile.webThemeColor,
                          )
                        : AppTextStyles.mediumBlack14.copyWith(
                            color: ColorFile.blackColor,
                          ),
                  ),

                  mItem == selectedItem
                      ? const Icon(Icons.navigate_next)
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
