import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import 'custom_gesture_detector.dart';
import 'custom_text_view.dart';

enum GroupAlignment { horizontal, vertical }

class CustomRadioGroup<T> extends StatelessWidget {
  CustomRadioGroup({
    required this.values,
    required this.selectedValue,
    required this.onTap,
    required this.displayName,
    this.title,
    required this.alignment,
    super.key,
  });

  final List<T> values;
  final T selectedValue;
  final Function(T) onTap;
  final String Function(T) displayName;
  final GroupAlignment alignment;
  String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          CustomTextView(title ?? '', style: AppTextStyles.mediumBlack14),
        if (title != null) SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: ColorFile.grayDDColor),
          ),
          child:
              alignment == GroupAlignment.vertical
                  ? Column(
                    children:
                        values.map((e) {
                          return _CustomRadioButton<T>(
                            value: e,
                            isSelected: e == selectedValue,
                            onTap: onTap,
                            displayName: displayName,
                          );
                        }).toList(),
                  )
                  : Row(
                    children:
                        values
                            .map(
                              (e) => Expanded(
                                child: _CustomRadioButton<T>(
                                  value: e,
                                  isSelected: e == selectedValue,
                                  onTap: onTap,
                                  displayName: displayName,
                                ),
                              ),
                            )
                            .toList(),
                  ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _CustomRadioButton<T> extends StatelessWidget {
  _CustomRadioButton({
    required this.value,
    required this.isSelected,
    required this.onTap,
    required this.displayName,
  });

  final T value;
  final bool isSelected;
  final Function(T) onTap;
  final String Function(T) displayName;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 15.w),
        decoration: BoxDecoration(
          color:
              (isSelected)
                  ? ColorFile.webThemeColorOpaque5
                  : ColorFile.transparentColor,
          border: const Border(
            left: BorderSide(color: ColorFile.grayDDColor, width: 0.5),
            right: BorderSide(color: ColorFile.grayDDColor, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border:
                    (isSelected)
                        ? Border.all(color: ColorFile.webThemeColor, width: 2.w)
                        : Border.all(color: ColorFile.grayDDColor, width: 1.w),
              ),
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color:
                      (isSelected)
                          ? ColorFile.webThemeColor
                          : ColorFile.transparentColor,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: CustomTextView(
                displayName(value),
                style: AppTextStyles.regularBlack14.copyWith(
                  color:
                      (isSelected)
                          ? ColorFile.webThemeColor
                          : ColorFile.blackColorOpaque70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
