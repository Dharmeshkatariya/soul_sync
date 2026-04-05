import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';

import '../core/utils/color_file.dart';
import 'custom_gesture_detector.dart';
import 'custom_horizontal_pager.dart';

class CustomHorizontalTabBarWidget extends StatelessWidget {
  const CustomHorizontalTabBarWidget({
    required this.mList,
    this.selectedItem,
    required this.onTap,
    this.isShowCount = false,
    this.gapWidth = 6,
    super.key,
  });

  final List<PagerModel> mList;
  final PagerModel? selectedItem;
  final Function(PagerModel) onTap;
  final bool isShowCount;
  final double gapWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ListView.builder(
        itemCount: mList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return _item(context: context, index: index);
        },
      ),
    );
  }

  Widget _item({required BuildContext context, required int index}) {
    var item = mList[index];
    return CustomGestureDetector(
      onTap: () {
        onTap(item);
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: index < mList.length - 1 ? gapWidth.w : 0,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: (item == selectedItem)
                  ? ColorFile.whiteColor
                  : ColorFile.greyColorOpaque20,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: ColorFile.dividerColor, width: 1.0.w),
            ),
            child: CustomTextView(
              item.displayText ?? '',
              style: (item == selectedItem)
                  ? AppTextStyles.semiBoldBlack14.copyWith(
                      color: ColorFile.webThemeColor,
                    )
                  : AppTextStyles.regularBlack14.copyWith(
                      color: ColorFile.lightBlack1Color,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
