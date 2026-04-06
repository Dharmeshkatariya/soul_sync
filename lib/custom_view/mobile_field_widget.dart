import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/constants/constants_file.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import 'package:soul_sync/core/utils/color_file.dart';
import 'package:soul_sync/core/utils/globals.dart';
import 'custom_edit_text.dart';
import 'mandatory_indicator_widget.dart';

class MobileFieldWidget extends StatelessWidget {
  MobileFieldWidget({
    super.key,
    this.isMandatory = false,
    this.isEnabled = true,
    required this.textEditingController,
    required this.items,
    required this.selectedItem,
    required this.title,
    this.errorText,
    this.inputFormatters,
  });

  final String title;
  final TextEditingController textEditingController;
  final bool isMandatory;
  final bool showSearchBox = false;
  final List<String> items;
  final RxString selectedItem;
  RxString? errorText;
  final bool isEnabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    errorText ??= ''.obs;

    return Column(
      children: [
        if (title.isNotEmpty)
          Row(
            children: [
              CustomTextView(title, style: AppTextStyles.mediumBlack14),
              if (isMandatory) const MandatoryIndicator(),
            ],
          ),
        if (title.isNotEmpty) SizedBox(height: 4.h),
        SizedBox(
          width: Get.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 72.w, child: _dropDown()),
              SizedBox(width: 12.w),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    // if (title.isNotEmpty) SizedBox(height: 4.h),
                    CustomEditText(
                      StringFile.phoneHint,
                      textEditingController,
                      TextInputType.phone,
                      isMandatory: isMandatory,
                      errorText: errorText,
                      isEnabled: isEnabled,
                      inputFormatter: inputFormatters,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dropDown() {
    if (selectedItem.value.isEmpty) {
      selectedItem.value = appLocale.getPhoneCountryCodeMask();
    }
    return Obx(
      () => Container(
        height: 42.w,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 12.w, right: 4.w),
        decoration: BoxDecoration(
          border: Border.all(color: ColorFile.webBorderGrayColor),
          color: ColorFile.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            onTap: () {
              FocusScope.of(Get.context!).unfocus();
            },
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: ColorFile.blackColor,
              size: 20.h,
            ),
            dropdownColor: ColorFile.whiteColor,
            style: TextStyle(
              color: ColorFile.blackColor,
              fontSize: 14.sp,
              fontFamily: ConstantsFile.mediumFont,
            ),
            hint: CustomTextView(
              '+1',
              style: AppTextStyles.regularBlack14.copyWith(
                color: ColorFile.blackColorOpaque60,
              ),
            ),
            items: items.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: CustomTextView(
                  dropDownStringItem,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorFile.blackColor,
                    fontFamily: ConstantsFile.mediumFont,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValueSelected) {
              selectedItem.value = newValueSelected!;
            },
            value: selectedItem.value.isEmpty ? null : selectedItem.value,
          ),
        ),
      ),
    );
  }
}
