import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/custom_view/custom_divider.dart';
import 'custom_no_data_found_widget.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    required this.itemCount,
    required this.isLoading,
    required this.itemBuilder,
    this.shrinkWrap = false,
    this.isDivider = false,
    this.isSeparator = false,
    this.axis = Axis.vertical,
    this.controller,
    this.noDataFoundMsg,
    this.emptyView,
    super.key,
    this.padding,
    this.physics,
    this.separatorHeight,
  });

  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool isLoading;
  final bool shrinkWrap;
  final bool isSeparator;
  final bool isDivider;
  final EdgeInsetsGeometry? padding;
  final Axis axis;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final String? noDataFoundMsg;
  final double? separatorHeight;
  final Widget? emptyView;

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const Center(child: CircularProgressIndicator())
        : (itemCount == 0)
        ? emptyView ?? CustomNoDataFoundWidget(noDataFoundTitle: noDataFoundMsg)
        : ListView.separated(
          controller: controller,
          scrollDirection: axis,
          shrinkWrap: shrinkWrap,
          physics: physics,
          itemCount: itemCount,
          padding: padding,
          itemBuilder: itemBuilder,
          separatorBuilder:
              (context, index) =>
                  isSeparator
                      ? SizedBox(height: separatorHeight ?? 10.h)
                      : isDivider
                      ? _divider()
                      : Container(),
        );
  }

  Widget _divider() {
    return CustomDivider();
  }
}
