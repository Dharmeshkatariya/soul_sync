import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';
import 'custom_text_view.dart';

class PaginatorPageListView extends StatelessWidget {
  final List<int> mList;
  ValueChanged<int> itemCallback;
  int currentPage;

  PaginatorPageListView(
    this.mList,
    this.currentPage,
    this.itemCallback, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: (mList.length > 3) ? 3 : mList.length,
      itemBuilder: (BuildContext context, int index) {
        var mData = mList[index];
        return InkWell(
          onTap: () {
            currentPage = mList[index];
            itemCallback(currentPage);
          },
          child: Container(
            width: 36.w,
            height: 36.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: currentPage == mList[index]
                  ? ColorFile.webThemeColor
                  : ColorFile.whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
              border: Border.all(
                color: currentPage == mList[index]
                    ? ColorFile.webThemeColor
                    : ColorFile.grayDDColor,
              ),
            ),
            child: CustomTextView(
              mData.toString(),
              textAlign: TextAlign.center,
              style: ResponsiveUtil.isMediumWebOrLarger
                  ? AppTextStyles.semiBoldBlack14.copyWith(
                      color: currentPage == mList[index]
                          ? ColorFile.whiteColor
                          : ColorFile.webThemeColor,
                    )
                  : AppTextStyles.semiBoldBlack13.copyWith(
                      color: currentPage == mList[index]
                          ? ColorFile.whiteColor
                          : ColorFile.webThemeColor,
                    ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 10.w);
      },
    );
  }
}
