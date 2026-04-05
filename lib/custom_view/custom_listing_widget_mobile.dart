import 'package:soul_sync/custom_view/custom_text_view.dart';

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import '../core/constants/constants_file.dart';
import '../core/utils/assets_icons.dart';
import '../core/utils/color_file.dart';
import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';
import 'custom_gesture_detector.dart';
import 'circular_progressIndicator_widget.dart';
import 'custom_empty_data_view.dart';
import 'custom_text_view.dart';

class CustomListingWidgetMobile extends StatelessWidget {
  const CustomListingWidgetMobile({
    required this.mList,
    required this.listingItem,
    this.isDividerHide = false,
    this.isLoading = false,
    this.padding,
    this.pagination,
    this.separatorWidget,
    this.isScrollable = true,
    this.expanded = true,
    this.isSearchEmptyData = false,
    this.moduleName = "",
    super.key,
  });

  final List<dynamic> mList;
  final CustomListingItemMobile Function(dynamic, int) listingItem;
  final EdgeInsetsGeometry? padding;
  final bool isDividerHide;
  final bool isLoading;
  final bool expanded;
  final bool? isScrollable;
  final Widget? pagination;
  final Widget? separatorWidget;
  final String moduleName;
  final bool isSearchEmptyData;

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);

    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child:
          isLoading
              ? const Center(child: CircularProgressIndicatorWidget())
              : mList.isNotEmpty
              ? Column(
                children: [
                  if (expanded)
                    Expanded(child: buildListView())
                  else
                    buildListView(),
                  if (pagination != null) ...[
                    SizedBox(height: 10.h),
                    pagination ?? Container(),
                  ],
                ],
              )
              : CustomEmptyDataView(
                moduleNameTitle: moduleName,
                isSearchEmptyData: true,
              ),
    );
  }

  ListView buildListView() {
    return ListView.separated(
      shrinkWrap: true,
      physics:
          isScrollable!
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var mData = mList[index];
        return listingItem(mData, index);
      },
      separatorBuilder: (context, index) {
        return separatorWidget ?? (isDividerHide ? _separator() : _divider());
      },
      itemCount: mList.length,
    );
  }

  Widget _separator() {
    return SizedBox(height: 10.h);
  }

  Widget _divider() {
    return Divider(color: ColorFile.grayDDColor, height: 2.h);
  }
}

// ignore: must_be_immutable
class CustomListingItemMobile extends StatelessWidget {
  CustomListingItemMobile({
    super.key,
    required this.widgets,
    required this.columnTitles,
    this.headerWidget,
    this.flexColumnWidths,
    this.padding,
    this.isBorderShow = false,
    this.isExpanded = false,
  }) {
    this.isExpandedView = RxBool(isExpanded);
  }

  double? unitWidth;
  List<Widget> widgets;
  Widget? headerWidget;
  List<String> columnTitles;
  List<int>? flexColumnWidths;
  bool isExpanded;
  RxBool isExpandedView = RxBool(false);
  final bool isBorderShow;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);
    return view();
  }

  view() {
    if (columnTitles.length != widgets.length) {
      throw ArgumentError(
        'columnTitles.length must be equals to widgets.length',
      );
    }

    if (flexColumnWidths != null && flexColumnWidths!.isNotEmpty) {
      if (columnTitles.length != flexColumnWidths!.length ||
          widgets.length != flexColumnWidths!.length) {
        throw ArgumentError(
          'columnTitles.length && widgets.length must be equals to flexColumnWidths.length',
        );
      }
    }
    flexColumnWidths ??= columnTitles.map((e) => 1).toList();

    List<Widget> titles = [];
    for (int i = 0; i < columnTitles.length; i++) {
      var text = columnTitles[i];
      titles.add(
        CustomTextView(
          text,
          style: AppTextStyles.boldBlack12.copyWith(
            color: ColorFile.lightBlack1Color,
          ),
        ),
      );
    }

    List<Widget> children = [];
    for (int i = 0; i < widgets.length; i++) {
      var widget = widgets[i];
      var flex = flexColumnWidths![i];
      var title = titles[i];
      if (headerWidget != null) {
        children.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              SizedBox(height: 2.h),
              widget,
              SizedBox(height: 12.h),
            ],
          ),
        );
      } else {
        if (i == 0) {
          children.add(
            Obx(
              () => CustomGestureDetector(
                onTap: () => isExpandedView.toggle(),
                child: Container(
                  padding:
                      (isExpandedView.value)
                          ? EdgeInsets.only(bottom: 20.h)
                          : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: widget),
                      SvgPicture.asset(
                        (isExpandedView.value)
                            ? AssetsIcons.icArrowUp
                            : AssetsIcons.icArrowDown,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          children.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                SizedBox(height: 2.h),
                widget,
                SizedBox(height: 12.h),
              ],
            ),
          );
        }
      }
    }
    if (headerWidget != null) {
      children.insert(
        0,
        Obx(
          () => CustomGestureDetector(
            onTap: () => isExpandedView.toggle(),
            child: Container(
              padding:
                  (isExpandedView.value) ? EdgeInsets.only(bottom: 20.h) : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: headerWidget!),
                  SizedBox(width: 10.w),
                  SvgPicture.asset(
                    (isExpandedView.value)
                        ? AssetsIcons.icArrowUp
                        : AssetsIcons.icArrowDown,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Obx(
      () => AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: Container(
          constraints: BoxConstraints(minHeight: 60.h),
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal:
                    ResponsiveUtil.unitWidth *
                    ConstantsFile.horizontalPaddingRatioMobile,
                vertical: 14.h,
              ),
          decoration:
              isBorderShow
                  ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorFile.grayDDColor),
                    color: ColorFile.whiteColor,
                  )
                  : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: (isExpandedView.value) ? children : [children.first],
          ),
        ),
      ),
    );
  }
}
