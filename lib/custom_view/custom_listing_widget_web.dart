import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import 'package:soul_sync/custom_view/custom_gesture_detector.dart';
import 'package:soul_sync/models/column_drill_down.dart';
import '../core/enum/listing_theme_type.dart';
import '../core/utils/color_file.dart';
import '../core/utils/responsive_util.dart';
import 'circular_progressIndicator_widget.dart';
import 'custom_empty_data_view.dart';

class CustomListingWidgetWeb extends StatelessWidget {
  CustomListingWidgetWeb({
    required this.mList,
    required this.listingItem,
    required this.columnTitles,
    required this.flexColumnWidths,
    this.isLoading = false,
    this.margin,
    this.pagination,
    this.isShowBorder = true,
    this.isScrollable = true,
    this.listTheme = ListingTheme.primary,
    this.bottomTitles = const [],
    this.isExpand = true,
    this.isSearchEmptyData = false,
    this.moduleName = '',
    super.key,
  });

  List<dynamic> mList;
  List<String> columnTitles;

  List<String>? bottomTitles;
  List<int> flexColumnWidths;
  CustomListingItem Function(dynamic, int) listingItem;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;
  final Widget? pagination;
  final bool? isShowBorder;
  final bool? isScrollable;

  final ListingTheme listTheme;
  final bool? isExpand;
  final bool isSearchEmptyData;
  final String moduleName;

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);
    if (columnTitles.length != flexColumnWidths.length) {
      throw ArgumentError(
        'columnTitles.length must be equals to flexColumnWidths.length',
      );
    }

    List<Widget> titles = [];
    List<Widget> bottomTitlesVal = [];
    for (int i = 0; i < columnTitles.length; i++) {
      var text = columnTitles[i];
      var flex = flexColumnWidths[i];
      titles.add(
        Expanded(
          flex: flex,
          child: CustomTextView(
            text,
            style: AppTextStyles.semiBoldBlack12.copyWith(
              color: ColorFile.lightBlack1Color,
            ),
          ),
        ),
      );
    }

    if (listTheme.name == ListingTheme.secondary.name &&
        bottomTitles != null &&
        bottomTitles!.isNotEmpty) {
      for (int i = 0; i < bottomTitles!.length; i++) {
        var text1 = bottomTitles![i];
        var flex = flexColumnWidths[i];
        bottomTitlesVal.add(
          Expanded(
            flex: flex,
            child: CustomTextView(
              text1,
              style: AppTextStyles.semiBoldBlack12.copyWith(
                color: ColorFile.lightBlack1Color,
              ),
            ),
          ),
        );
      }
    } else {
      Container();
    }

    return isLoading
        ? const Center(child: CircularProgressIndicatorWidget())
        : mList.isNotEmpty
        ? Column(
            children: [
              titles.isNotEmpty
                  ? Container(
                      margin: isShowBorder! ? margin : EdgeInsets.zero,
                      constraints: BoxConstraints(minHeight: 36.h),
                      alignment: Alignment.center,
                      padding: isShowBorder!
                          ? EdgeInsets.symmetric(
                              horizontal: ResponsiveUtil.unitWidth * 1.5,
                              vertical: 6.w,
                            )
                          : EdgeInsets.zero,
                      decoration: listTheme == ListingTheme.primary
                          ? BoxDecoration(
                              borderRadius: isShowBorder!
                                  ? BorderRadius.circular(8.r)
                                  : BorderRadius.zero,

                              border: isShowBorder!
                                  ? Border.all(color: ColorFile.grayDDColor)
                                  : Border(
                                      bottom: BorderSide(
                                        color: ColorFile.grayDDColor,
                                      ),
                                    ),
                              color: ColorFile.whiteColor,
                            )
                          : BoxDecoration(
                              border: isShowBorder!
                                  ? Border.all(color: ColorFile.grayDDColor)
                                  : Border(
                                      bottom: BorderSide(
                                        color: ColorFile.grayDDColor,
                                      ),
                                    ),
                              color: ColorFile.whiteColor,
                            ),
                      child: Padding(
                        padding: isShowBorder!
                            ? EdgeInsets.zero
                            : EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 8.w,
                              ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: titles.map((e) => e).toList(),
                        ),
                      ),
                    )
                  : Container(),

              if (titles.isNotEmpty &&
                  listTheme.name == ListingTheme.primary.name)
                SizedBox(height: 14.h)
              else
                SizedBox(height: 0.h),
              (isExpand!)
                  ? Expanded(
                      child: SingleChildScrollView(
                        physics: isScrollable!
                            ? const AlwaysScrollableScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        child: listingAndPaginationView(bottomTitlesVal),
                      ),
                    )
                  : listingAndPaginationView(bottomTitlesVal),
            ],
          )
        : CustomEmptyDataView(
            moduleNameTitle: moduleName,
            isSearchEmptyData: isSearchEmptyData,
          );
  }

  Widget listingAndPaginationView(List<Widget> bottomTitlesVal) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: isScrollable!
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var mData = mList[index];
            return listingItem(mData, index);
          },
          separatorBuilder: (context, index) {
            return (isShowBorder!)
                ? SizedBox(
                    height: listTheme == ListingTheme.secondary ? 0.h : 10.h,
                  )
                : Container(
                    width: Get.width,
                    height: 1,
                    decoration: BoxDecoration(
                      color: ColorFile.webBorderGrayColor,
                    ),
                  );
          },
          itemCount: mList.length,
        ),
        if (listTheme.name == ListingTheme.secondary.name &&
            bottomTitles != null &&
            bottomTitlesVal.isNotEmpty)
          Container(
            margin: isShowBorder! ? margin : EdgeInsets.zero,
            constraints: BoxConstraints(minHeight: 36.h),
            alignment: Alignment.center,
            padding: isShowBorder!
                ? EdgeInsets.symmetric(
                    horizontal: ResponsiveUtil.unitWidth * 1.5,
                    vertical: 6.w,
                  )
                : EdgeInsets.zero,
            decoration: listTheme.name == ListingTheme.primary.name
                ? BoxDecoration(
                    borderRadius: isShowBorder!
                        ? BorderRadius.circular(8.r)
                        : BorderRadius.zero,

                    border: isShowBorder!
                        ? Border.all(color: ColorFile.grayDDColor)
                        : Border(
                            bottom: BorderSide(color: ColorFile.grayDDColor),
                          ),
                    color: ColorFile.whiteColor,
                  )
                : BoxDecoration(
                    border: isShowBorder!
                        ? Border.all(color: ColorFile.grayDDColor)
                        : Border(
                            bottom: BorderSide(color: ColorFile.grayDDColor),
                          ),
                    color: ColorFile.whiteColor,
                  ),
            child: Padding(
              padding: isShowBorder!
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bottomTitlesVal.map((e) => e).toList(),
              ),
            ),
          ),
        if (pagination != null) SizedBox(height: 10.h),
        if (pagination != null) pagination ?? Container(),
      ],
    );
  }
}

class CustomListingItem extends StatelessWidget {
  CustomListingItem({
    super.key,
    required this.cells,
    required this.flexColumnWidths,
    this.margin,
    this.onTapMoreWidget,
    this.titlePadding = EdgeInsets.zero,
    this.isShowBorder = true,
    this.horizontalPadding,
    this.vertPadding = 18.0,
    this.listTheme = ListingTheme.primary,
    this.columnDrillDownList,
  });

  double? unitWidth;
  List<Widget> cells;
  List<int> flexColumnWidths;
  Widget? onTapMoreWidget;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry titlePadding;
  bool? isShowBorder;
  double? vertPadding;
  double? horizontalPadding;

  final ListingTheme listTheme;
  final List<ColumnDrillDown?>? columnDrillDownList;

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);
    if (columnDrillDownList != null && columnDrillDownList!.isNotEmpty) {
      if (cells.length != columnDrillDownList!.length) {
        throw ArgumentError(
          'cells.length must be equals to columnDrillDownList.length',
        );
      }
    }
    return webView(isShowBorder);
  }

  webView(bool? isShowBorder) {
    List<Widget> children = [];

    Widget onItemClick({required Widget child, required int index}) {
      if (columnDrillDownList != null && columnDrillDownList!.isNotEmpty) {
        return CustomGestureDetector(
          child: child,
          onTap: () {
            // Get.delete<RolesManagementController>();
            Get.toNamed(
              columnDrillDownList![index]!.routeName ?? '',
              parameters: columnDrillDownList![index]!.parameters ?? {},
            );
          },
        );
      } else {
        return child;
      }
    }

    for (int i = 0; i < cells.length; i++) {
      var widget = cells[i];
      var flex = flexColumnWidths[i];
      children.add(
        Expanded(
          flex: flex,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: onItemClick(
              child: Padding(padding: titlePadding, child: widget),
              index: i,
            ),
          ),
        ),
      );
    }

    return listTheme == ListingTheme.primary
        ? Container(
            margin: isShowBorder! ? margin : EdgeInsets.zero,
            padding: isShowBorder
                ? EdgeInsets.symmetric(
                    horizontal:
                        horizontalPadding?.w ?? ResponsiveUtil.unitWidth * 1.5,
                    vertical: vertPadding!.w,
                  )
                : EdgeInsets.zero,
            decoration: isShowBorder
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorFile.grayDDColor),
                    color: ColorFile.whiteColor,
                  )
                : const BoxDecoration(),
            child: Padding(
              padding: isShowBorder
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: (isShowBorder)
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: children,
                  ),
                  if (onTapMoreWidget != null) onTapMoreWidget!,
                ],
              ),
            ),
          )
        : Container(
            // margin: isShowBorder! ? margin : EdgeInsets.zero,
            padding: isShowBorder!
                ? EdgeInsets.symmetric(
                    horizontal: ResponsiveUtil.unitWidth * 1.5,
                    vertical: vertPadding!.w,
                  )
                : EdgeInsets.zero,
            decoration: isShowBorder
                ? BoxDecoration(
                    // borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorFile.grayDDColor),
                    color: ColorFile.whiteColor,
                  )
                : const BoxDecoration(),
            child: Padding(
              padding: isShowBorder
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: (isShowBorder)
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: children,
                  ),
                  if (onTapMoreWidget != null) onTapMoreWidget!,
                ],
              ),
            ),
          );
  }
}
