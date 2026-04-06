import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/utils/extensions.dart';
import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import '../core/utils/constant_status.dart';

class CommonStatusWidget extends StatelessWidget {
  final String status;
  AlignmentGeometry? alignment;
  bool showBg;

  CommonStatusWidget({super.key, required this.status, this.showBg = true});

  @override
  Widget build(BuildContext context) {
    return _buildStatusWidget();
  }

  Widget _buildStatusWidget() {
    final StatusModel statusStyle = _getStatusStyle(status);
    return Container(
      constraints: BoxConstraints(minHeight: 23.h),
      decoration: BoxDecoration(
        color:
            showBg ? statusStyle.backgroundColor : ColorFile.transparentColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      alignment: alignment,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 14.w),
      child: _buildStatusCustomTextView(status, statusStyle.textColor),
    );
  }

  StatusModel _getStatusStyle(String status) {
    final String normalizedStatus = status.toLowerCase();
    if ([
      // ConstantStatus.pending,
      // ConstantStatus.underReview,
      // ConstantStatus.notVerified,
      ConstantStatus.vacant,
    ].contains(normalizedStatus)) {
      return StatusModel(
        textColor: ColorFile.pendingStatusColor,
        backgroundColor: ColorFile.pendingStatusColor.withOpacity(0.1),
      );
    } else if ([
      ConstantStatus.approved,
      ConstantStatus.verified,
      ConstantStatus.active,
      ConstantStatus.confirmed,
    ].contains(normalizedStatus)) {
      return StatusModel(
        textColor: ColorFile.greenColor,
        backgroundColor: ColorFile.greenColor.withOpacity(0.1),
      );
    } else if ([
      ConstantStatus.rejected,
      ConstantStatus.inActive,
      ConstantStatus.external,
      ConstantStatus.denied,
      ConstantStatus.rejectedByPayer,
      ConstantStatus.intakeFormAssigned,
    ].contains(normalizedStatus)) {
      return StatusModel(
        textColor: ColorFile.externalStatusColor,
        backgroundColor: ColorFile.externalStatusColor.withOpacity(0.1),
      );
    } else if ([
      ConstantStatus.inReview,
      ConstantStatus.primary,
      ConstantStatus.completed,
      ConstantStatus.complete,
      ConstantStatus.inProgress,
      ConstantStatus.partialPayment,
      ConstantStatus.appealed,
    ].contains(normalizedStatus)) {
      return StatusModel(
        textColor: ColorFile.darkBlueColor,
        backgroundColor: ColorFile.darkBlueColor.withOpacity(0.1),
      );
    } else if (normalizedStatus == ConstantStatus.draft) {
      return StatusModel(
        backgroundColor: ColorFile.grayDDColor,
        textColor: ColorFile.blackColor,
      );
    } else if ([
      ConstantStatus.submitted,
      ConstantStatus.posted,
      ConstantStatus.resubmitted,
    ].contains(normalizedStatus)) {
      return StatusModel(
        backgroundColor: ColorFile.webThemeColor.withOpacity(0.1),
        textColor: ColorFile.webThemeColor,
      );
    } else {
      return StatusModel(
        textColor: ColorFile.blackColor,
        backgroundColor: ColorFile.grayDDColor,
      );
    }
  }

  Widget _buildStatusCustomTextView(String value, Color textColor) {
    return CustomTextView(
      value.formatted,
      style: AppTextStyles.semiBoldBlack12.copyWith(
        fontSize: 11.sp,
        color: textColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class StatusModel {
  final Color textColor;
  final Color backgroundColor;

  const StatusModel({required this.textColor, required this.backgroundColor});
}
