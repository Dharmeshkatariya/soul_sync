import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/constants/constants_file.dart';
import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';
import 'custom_horizontal_pager.dart';
import 'custom_text_view.dart';

class CustomHeaderView extends StatelessWidget {
  final String title;
  final List<PagerModel>? pagerList;
  final Rx<PagerModel>? selectedPager;
  final Function(PagerModel pagerModel)? onPagerTap;
  final bool? isShowCount;
  final double? padding;
  const CustomHeaderView({
    required this.title,
    this.pagerList,
    this.selectedPager,
    this.onPagerTap,
    this.isShowCount = true,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          SizedBox(height: 24.w),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  padding ??
                  ResponsiveUtil.unitWidth *
                      ConstantsFile.horizontalPaddingRatio,
            ),
            child: CustomTextView(title, style: AppTextStyles.semiBoldBlack24),
          ),
        ],
        (pagerList != null && pagerList!.isNotEmpty)
            ? Obx(
                () => Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: ColorFile.webBorderGrayColor),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          padding ??
                          ResponsiveUtil.unitWidth *
                              ConstantsFile.horizontalPaddingRatio,
                    ),
                    child: CustomHorizontalPager(
                      mList: pagerList!,
                      selectedItem: selectedPager!.value,
                      onTap: (pagerModel) {
                        onPagerTap!(pagerModel);
                      },
                      isShowCount: isShowCount ?? true,
                    ),
                  ),
                ),
              )
            : (ResponsiveUtil.isWeb)
            ? SizedBox(height: 20.w)
            : SizedBox(height: 12.w),
      ],
    );
  }
}
