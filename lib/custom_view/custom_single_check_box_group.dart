import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import 'custom_checkbox_widget.dart';
import 'custom_gesture_detector.dart';
import 'custom_radio_group.dart';
import 'custom_text_view.dart';

class CustomSingleCheckboxGroup<T> extends StatelessWidget {
  CustomSingleCheckboxGroup({
    required this.values,
    required this.selectedValue,
    required this.onChanged,
    required this.displayName,
    this.title,
    required this.alignment,
    super.key,
  });

  final List<T> values;
  final T? selectedValue;
  final Function(T) onChanged;
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
                          return _CustomSingleCheckbox<T>(
                            value: e,
                            isSelected: e == selectedValue,
                            onChanged: onChanged,
                            displayName: displayName,
                          );
                        }).toList(),
                  )
                  : Row(
                    children:
                        values
                            .map(
                              (e) => Expanded(
                                child: _CustomSingleCheckbox<T>(
                                  value: e,
                                  isSelected: e == selectedValue,
                                  onChanged: onChanged,
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

class _CustomSingleCheckbox<T> extends StatelessWidget {
  const _CustomSingleCheckbox({
    required this.value,
    required this.isSelected,
    required this.onChanged,
    required this.displayName,
  });

  final T value;
  final bool isSelected;
  final Function(T) onChanged;
  final String Function(T) displayName;

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? ColorFile.webThemeColorOpaque5
                  : ColorFile.transparentColor,
          border: const Border(
            left: BorderSide(color: ColorFile.grayDDColor, width: 0.5),
            right: BorderSide(color: ColorFile.grayDDColor, width: 0.5),
          ),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            CustomCheckboxWidget(
              checkboxValue: isSelected.obs,
              onChangedCallBack: (va) {
                onChanged(value);
              },
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: CustomTextView(
                displayName(value),
                style: AppTextStyles.regularBlack14.copyWith(
                  color:
                      isSelected
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
