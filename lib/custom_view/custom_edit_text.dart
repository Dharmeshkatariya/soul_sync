import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';

import '../core/constants/constants_file.dart';
import '../core/utils/color_file.dart';
import 'mandatory_indicator_widget.dart';

class CustomEditText extends StatelessWidget {
  CustomEditText(
    this.hintText,
    this.tEController,
    this.textInputType, {
    super.key,
    this.isMandatory = false,
    this.isEnabled = true,
    this.obscureText = false,
    this.isBorderLess = false,
    this.title = '',
    this.height = 40,
    this.labelText,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.suffixIcon,
    this.preIcon,
    this.onTap,
    this.onChange,
    this.onSubmitted,
    this.errorText,
    this.isReadOnly,
    this.contentPadding,
    this.labelStyle,
    this.prefixIcon,
    this.prefixText,
    this.onTapOutside,
    this.prefix,
    this.inputFormatter,
  });

  String hintText;
  double height;
  TextEditingController tEController;
  TextInputType textInputType;
  bool isMandatory;
  bool isEnabled;
  String title;
  bool obscureText;
  bool isBorderLess;
  String? labelText;
  int? minLines;
  int? maxLines;
  int? maxLength;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Widget? prefix;
  Widget? preIcon;
  Function()? onTap;
  Function()? onTapOutside;
  Function(String)? onChange;
  Function(String)? onSubmitted;
  List<TextInputFormatter>? inputFormatter;
  RxString? errorText;
  RxBool? isReadOnly;
  EdgeInsetsGeometry? contentPadding;
  TextStyle? labelStyle;
  String? prefixText;

  @override
  Widget build(BuildContext context) {
    // if(isMandatory){
    //   errorText ??= StringFile.mandatoryField.obs;
    // }else{
    //   errorText ??= ''.obs;
    // }
    errorText ??= ''.obs;
    isReadOnly ??= false.obs;

    var isFocused = false.obs;
    // List<TextInputFormatter>? inputFormatter = ;

    final formatters = inputFormatter ??
        () {
          if (textInputType == TextInputType.name) {
            return [
              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z,' ]")),
            ];
          } else if (textInputType == TextInputType.emailAddress) {
            return [
              FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@_.-]")),
            ];
          } else if (textInputType == TextInputType.number) {
            return [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))];
          } else if (textInputType == TextInputType.phone) {
            return [
              MaskTextInputFormatter(
                mask: '(###)-###-####',
                filter: {"#": RegExp(r'\d')},
                type: MaskAutoCompletionType.lazy,
              ),
            ];
          } else if (textInputType == TextInputType.streetAddress) {
            return [FilteringTextInputFormatter.allow(RegExp("[0-9 -]"))];
          } else if (textInputType == TextInputType.datetime) {
            return [
              MaskTextInputFormatter(
                mask: '##/##/####',
                filter: {"#": RegExp(r'\d')},
                type: MaskAutoCompletionType.lazy,
              ),
            ];
          } else {
            return null;
          }
        }();

    return Semantics(
      label: hintText,
      tooltip: hintText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitleWithMandatoryIndicator(
            title: title,
            isMandatory: isMandatory,
          ),
          Obx(
            () => Focus(
              autofocus: false,
              canRequestFocus: true,
              descendantsAreFocusable: true,
              onFocusChange: (b) {
                isFocused.value = b;
                if (isMandatory && tEController.text.isEmpty) {
                  if (errorText!.value.isEmpty) {
                    errorText!.value = StringFile.mandatoryField;
                  } else {
                    // errorText!.value = errorText!.value;
                  }
                } else if (isMandatory && tEController.text.isNotEmpty) {
                  errorText!.value = '';
                } else if (!isMandatory && tEController.text.isEmpty) {
                  errorText!.value = '';
                } else if (textInputType == TextInputType.emailAddress &&
                    !tEController.text.isEmail) {
                  errorText!.value = StringFile.invalidEmailAddress;
                } else if (textInputType == TextInputType.emailAddress &&
                    tEController.text.isEmail) {
                  errorText!.value = '';
                } else if (textInputType == TextInputType.phone &&
                    !tEController.text.isPhoneNumber) {
                  //!tEController.text.isEmail
                  errorText!.value = StringFile.invalidMobileNumber;
                } else if (textInputType == TextInputType.emailAddress &&
                    tEController.text.isEmail) {
                  errorText!.value = '';
                } else if (textInputType == TextInputType.url &&
                    !tEController.text.isURL) {
                  errorText!.value = StringFile.invalidUrl;
                } else if (textInputType == TextInputType.url &&
                    tEController.text.isURL) {
                  errorText!.value = '';
                } else {
                  errorText!.value = '';
                }
              },
              child: Container(
                decoration: (!isBorderLess)
                    ? BoxDecoration(
                        color: ColorFile.whiteColor,
                        border: (errorText!.value.isEmpty)
                            ? Border(
                                top: BorderSide(
                                  color: (!isFocused.value)
                                      ? ColorFile.grayDDColor
                                      : ColorFile.webThemeColor,
                                ),
                                right: BorderSide(
                                  color: (!isFocused.value)
                                      ? ColorFile.grayDDColor
                                      : ColorFile.webThemeColor,
                                ),
                                left: BorderSide(
                                  color: (!isFocused.value)
                                      ? ColorFile.grayDDColor
                                      : ColorFile.webThemeColor,
                                ),
                                bottom: BorderSide(
                                  color: (!isFocused.value)
                                      ? ColorFile.grayDDColor
                                      : ColorFile.webThemeColor,
                                ),
                              )
                            : Border(
                                top: BorderSide(color: ColorFile.errorColor),
                                right: BorderSide(color: ColorFile.errorColor),
                                left: BorderSide(color: ColorFile.errorColor),
                                bottom: BorderSide(color: ColorFile.errorColor),
                              ),
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      )
                    : const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height.h - 2.h,
                      child: Builder(
                        builder: (context) {
                          return TextField(
                            autofocus: false,
                            enableInteractiveSelection: true,
                            onChanged: (value) {
                              if (onChange == null) {
                                onChange = (_) {};
                              } else {
                                onChange!(value);
                              }
                              if (value.isNotEmpty) {
                                if (textInputType ==
                                        TextInputType.emailAddress &&
                                    !value.isEmail) {
                                  errorText!.value =
                                      StringFile.invalidEmailAddress;
                                } else if (textInputType == TextInputType.url &&
                                    !value.isURL) {
                                  errorText!.value = StringFile.invalidUrl;
                                } else if (textInputType ==
                                        TextInputType.phone &&
                                    !value.isPhoneNumber) {
                                  errorText!.value =
                                      StringFile.invalidMobileNumber;
                                } else {
                                  errorText!.value = '';
                                }
                              } else if (isMandatory) {
                                errorText!.value = StringFile.mandatoryField;
                              } else {
                                errorText!.value = '';
                              }
                              if (textInputType == TextInputType.name) {
                                if (value.contains("'") ||
                                    value.contains(",")) {
                                  var t = value.split('');
                                  var countApstrophe = t
                                      .where((element) => element == "'")
                                      .length;
                                  var countComma = t
                                      .where((element) => element == ",")
                                      .length;

                                  if (countApstrophe > 1 || countComma > 1) {
                                    tEController.text = value.substring(
                                      0,
                                      value.length - 1,
                                    );
                                  }
                                }
                              }
                            },
                            controller: tEController,
                            keyboardType: textInputType,
                            enabled: isEnabled,
                            obscureText: obscureText,
                            inputFormatters: formatters,
                            minLines: minLines,
                            maxLines: maxLines,
                            onTap: onTap,
                            readOnly: isReadOnly!.value,
                            onSubmitted: onSubmitted,
                            autocorrect: false,
                            onTapOutside: (event) {
                              onTapOutside?.call();
                            },
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: (isEnabled)
                                  ? ColorFile.blackColor
                                  : ColorFile.blackColor,
                              // color: (isEnabled) ? ColorFile.blackColor : ColorFile.webBorderGrayColor,
                              fontFamily: ConstantsFile.regularFont,
                            ),
                            decoration: InputDecoration(
                              prefixText: prefixText,
                              fillColor: (isEnabled)
                                  ? ColorFile.whiteColor
                                  : ColorFile.grayColorF9F9F9,
                              filled: !isEnabled,
                              border: InputBorder.none,
                              icon: preIcon,
                              suffixIcon: suffixIcon,
                              prefixIcon: prefixIcon,
                              prefix: prefix,
                              labelText: labelText,
                              labelStyle: labelStyle ??
                                  AppTextStyles.semiBoldBlack14.copyWith(
                                    color: ColorFile.blackColor,
                                  ),
                              floatingLabelStyle: AppTextStyles.semiBoldBlack14
                                  .copyWith(color: ColorFile.blackColor),
                              counterText: '',
                              hintText: hintText,
                              hintStyle: AppTextStyles.regularBlack14.copyWith(
                                color: ColorFile.blackColorOpaque50,
                              ),
                              contentPadding: contentPadding ??
                                  EdgeInsets.only(
                                    top: 12.w,
                                    bottom: 12.w,
                                    left: 12.w,
                                    right: 12.w,
                                  ),
                              isDense: true,
                            ),
                            maxLength: maxLength ??
                                ((textInputType == TextInputType.streetAddress)
                                    ? 10
                                    : null),
                          );
                        },
                      ),
                    ),
                    (errorText!.value.isNotEmpty)
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 12.w,
                            ),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ColorFile.errorColor,
                              border: Border(
                                top: BorderSide(color: ColorFile.errorColor),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: (errorText!.value.isEmpty)
                                    ? Radius.circular(6.r)
                                    : Radius.zero,
                                topRight: (errorText!.value.isEmpty)
                                    ? Radius.circular(6.r)
                                    : Radius.zero,
                                bottomLeft: Radius.circular(6.r),
                                bottomRight: Radius.circular(6.r),
                              ),
                            ),
                            child: CustomTextView(
                              errorText!.value,
                              style: AppTextStyles.regularBlack12.copyWith(
                                color: ColorFile.whiteColor,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomEditTextCurrencyPrefix extends StatelessWidget {
  const CustomEditTextCurrencyPrefix({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 44.w,
      margin: EdgeInsets.only(right: 10.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorFile.grayColorF9F9F9,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(8.r)),
        border: const Border(right: BorderSide(color: ColorFile.grayDDColor)),
      ),
      child: CustomTextView("\$", style: AppTextStyles.mediumBlack14),
    );
  }
}

class CustomEditTextPercentSuffix extends StatelessWidget {
  const CustomEditTextPercentSuffix({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 40.w,
      margin: EdgeInsets.only(left: 10.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorFile.grayColorF9F9F9,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(8.r)),
        border: const Border(left: BorderSide(color: ColorFile.grayDDColor)),
      ),
      child: CustomTextView(
        ConstantsFile.percentSymbol,
        style: AppTextStyles.mediumBlack14,
      ),
    );
  }
}
