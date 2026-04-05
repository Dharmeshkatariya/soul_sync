import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soul_sync/custom_view/custom_text_view.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import 'package:soul_sync/core/utils/color_file.dart';

class ValidationMessageWidget extends StatelessWidget {
  const ValidationMessageWidget({
    super.key,
    required this.formValidationMessage,
  });

  final RxString formValidationMessage;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      excludeSemantics: true,
      child: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: (formValidationMessage.value.isNotEmpty)
              ? Container(
                  width: Get.width,
                  padding: EdgeInsets.only(left: 25.w),
                  key: ValueKey<String>(formValidationMessage.value),
                  color: ColorFile.errorColor,
                  child: CustomTextView(
                    formValidationMessage.value,
                    style: AppTextStyles.mediumBlack14.copyWith(
                      color: ColorFile.whiteColor,
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}

class SuccessMessageWidget extends StatelessWidget {
  const SuccessMessageWidget({super.key, required this.successMessage});

  final RxString successMessage;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: (successMessage.value.isNotEmpty)
            ? Container(
                width: Get.width,
                padding: EdgeInsets.only(left: 25.w),
                key: ValueKey<String>(successMessage.value),
                color: ColorFile.greenColor,
                child: CustomTextView(
                  successMessage.value,
                  style: AppTextStyles.mediumBlack14.copyWith(
                    color: ColorFile.whiteColor,
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({super.key, required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return (errorText.isNotEmpty)
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
            width: Get.width,
            decoration: BoxDecoration(
              color: ColorFile.errorColor,
              border: Border(top: BorderSide(color: ColorFile.errorColor)),
              borderRadius: BorderRadius.only(
                topLeft: (errorText.isEmpty)
                    ? Radius.circular(6.r)
                    : Radius.zero,
                topRight: (errorText.isEmpty)
                    ? Radius.circular(6.r)
                    : Radius.zero,
                bottomLeft: Radius.circular(6.r),
                bottomRight: Radius.circular(6.r),
              ),
            ),
            child: CustomTextView(
              errorText,
              style: AppTextStyles.regularBlack12.copyWith(
                color: ColorFile.whiteColor,
              ),
            ),
          )
        : Container();
  }
}
