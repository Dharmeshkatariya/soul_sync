import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import '../models/custom_base_model.dart';
import 'custom_gesture_detector.dart';
import 'custom_text_view.dart';
class CustomHorizontalPager extends StatelessWidget {
  CustomHorizontalPager(
      {required this.mList,
      required this.onTap,
      this.margin,
      this.selectedItem,
      this.padding,
      this.alignment,
      this.isShowCount = false,
      this.isExpandedPager = false,
      super.key});

  List<PagerModel> mList;
  PagerModel? selectedItem;
  Function(PagerModel) onTap;
  final bool isShowCount;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  AlignmentGeometry? alignment;
  bool isExpandedPager;

  @override
  Widget build(BuildContext context) {
    return isExpandedPager
        ? _expandedPager()
        : Container(
            margin: margin,
            padding: padding ?? EdgeInsets.only(top: 24.h),
            width: double.infinity,
            child: Align(
              alignment: alignment ?? Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                            SizedBox(
                              width: 40.w,
                            )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
  }

  Widget _expandedPager() {
    return Container(
      margin: margin,
      padding: padding ?? EdgeInsets.only(top: 24.h),
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
      onTap: () {
        onTap(item);
      },
      child: Container(
        alignment: isExpandedPager ? Alignment.center : Alignment.centerLeft,
        padding: EdgeInsets.only(bottom: 10.h),
        decoration: (item == selectedItem)
            ? BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: ColorFile.webThemeColor, width: 3.h)),
              )
            : null,
        child: Row(
          mainAxisSize: isExpandedPager ? MainAxisSize.min : MainAxisSize.max,
          children: [
            CustomTextView(item.displayText ?? "",
                style: (item == selectedItem)
                    ? AppTextStyles.semiBoldBlack14
                        .copyWith(color: ColorFile.webThemeColor)
                    : AppTextStyles.regularBlack14.copyWith(
                        color: ColorFile.lightBlack1Color,
                      )),
            Visibility(
              visible: isShowCount,
              child: Obx(() {
                return CustomTextView(
                  '(${item.count!.value})',
                  style: (item == selectedItem)
                      ? AppTextStyles.semiBoldBlack14
                          .copyWith(color: ColorFile.webThemeColor)
                      : AppTextStyles.regularBlack14.copyWith(
                          color: ColorFile.lightBlack1Color,
                        ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class PagerModel extends CustomBaseModel {
  String? displayText = '';
  Rx<bool>? isSelected = false.obs;
  RxInt? count = 0.obs;
  String? text = '';
  GlobalKey? globalKey;

  PagerModel(
      {this.displayText,
      this.text,
      this.count,
      this.isSelected,
      this.globalKey});

  @override
  bool isEmpty() {
    return displayText?.isEmpty ?? true;
  }
}
