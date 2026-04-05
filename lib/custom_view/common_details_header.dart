import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/utils/common_widget.dart';
import '../core/utils/color_file.dart';
import 'common_span_header_widget.dart';

class CommonDetailsHeader extends StatelessWidget {
  const CommonDetailsHeader({
    super.key,
    required this.title,
    required this.subTitle,
    this.horizontalPadding,
    this.verticalHeight,
    this.expandedWidget,
    this.headerColor,
    this.isSubTitleAndForwardVisible = true,
    this.onTapBack,
  });

  final String title;
  final String subTitle;
  final double? horizontalPadding;
  final double? verticalHeight;
  final Widget? expandedWidget;
  final bool isSubTitleAndForwardVisible;
  final Color? headerColor;
  final Function? onTapBack;

  @override
  Widget build(BuildContext context) {
    return _webHeader();
  }

  Widget _webHeader() {
    return Container(
      decoration: BoxDecoration(
        color: headerColor ?? ColorFile.whiteColor,
        border: Border(
          bottom: BorderSide(
            color: headerColor ?? ColorFile.grayD0D0D0Color,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalHeight ?? 20.h),
        child: Column(
          children: [Padding(padding: _commonPadding(), child: _spanHeader())],
        ),
      ),
    );
  }

  EdgeInsets _commonPadding() {
    return CommonWidget.commonPadding(horizontalPadding: horizontalPadding);
  }

  Widget _spanHeader() {
    return CommonSpanHeaderWidget(
      title: title,
      isSubTitleAndForwardVisible: isSubTitleAndForwardVisible,
      subTitle: subTitle,
      expandedWidget: expandedWidget,
      onTapBack: onTapBack,
    );
  }
}
