import 'package:soul_sync/core/utils/string_file.dart';

import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';
import 'package:soul_sync/core/utils/responsive_util.dart';
import 'package:soul_sync/core/utils/typing_timer_util.dart';
import 'package:soul_sync/custom_view/border_container.dart';
import 'package:soul_sync/custom_view/custom_divider.dart';
import '../../custom_view/custom_button.dart';
import '../../custom_view/custom_edit_text.dart';
import '../../custom_view/custom_gesture_detector.dart';
import 'assets_icons.dart';
import 'color_file.dart';
import 'common.dart';

class CommonWidget {
  static Widget listValue({required String title}) {
    return CustomTextView(title, style: AppTextStyles.regularBlack13);
  }

  static Widget listMediumValue({required String title}) {
    return CustomTextView(title, style: AppTextStyles.mediumBlack14);
  }

  static Widget listRegularValue({required String title}) {
    return CustomTextView(title, style: AppTextStyles.regularBlack14);
  }

  static Widget listSemiBoldValue({required String title}) {
    return CustomTextView(title, style: AppTextStyles.semiBoldBlack14);
  }

  static Widget cardTitleWidget({
    required String title,
    Function()? onTapEdit,
    Widget? verticalSubWidget,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _cardTitle(
          title: title,
          onTapEdit: onTapEdit,
          verticalSubWidget: verticalSubWidget,
        ),
        const CustomDivider(),
      ],
    );
  }

  static EdgeInsets _commonPadding() {
    return EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h);
  }

  static BorderRadius _commonTitleBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(10.r),
      topRight: Radius.circular(10.r),
    );
  }

  static Widget _cardTitle({
    required String title,
    Function()? onTapEdit,
    Widget? verticalSubWidget,
  }) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: _commonPadding(),
      decoration: BoxDecoration(
        borderRadius: _commonTitleBorderRadius(),
        color: ColorFile.grayColorF9F9F9,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextView(
                  title,
                  style: AppTextStyles.semiBoldBlack18,
                ),
              ),
              if (onTapEdit != null)
                CustomGestureDetector(
                  onTap: onTapEdit,
                  child: SvgPicture.asset(
                    AssetsIcons.icEdit,
                    width: 16.w,
                    height: 16.w,
                    colorFilter: ColorFilter.mode(
                      ColorFile.webThemeColorOpaque50,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          ),
          if (verticalSubWidget != null) ...[
            SizedBox(height: 15.h),
            verticalSubWidget,
          ],
        ],
      ),
    );
  }

  static commonDialogView({
    required Widget child,
    required double width,
    bool isHeightAddedIcon = true,
    double? verticalIconMargin,
    required double height,
    Function()? onCloseIcon,
  }) {
    Common().openDialogFromTop(
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: width,
          height: height,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    close(
                      onCloseIcon: onCloseIcon,
                      verticalIconMargin: verticalIconMargin,
                    ),
                    if (isHeightAddedIcon) ...[commonHeight()],
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      dismissible: false,
    );
  }

  static Widget commonHeight() {
    return SizedBox(height: 5.h);
  }

  static Widget divider() {
    return Divider(color: ColorFile.grayD0D0D0Color, height: 2.h);
  }

  static Widget close({Function()? onCloseIcon, double? verticalIconMargin}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0.w,
        vertical: verticalIconMargin ?? 15.h,
      ),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Get.back();
          if (onCloseIcon != null) {
            onCloseIcon();
          }
        },
        child: Icon(Icons.close, size: 24.w, color: Colors.white),
      ),
    );
  }

  static Widget mainDialogTitleView({
    required String dialogTitle,
    required Widget subWidget,
    bool isLoading = false,
    EdgeInsetsGeometry? subWidgetPadding,
  }) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: ColorFile.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: _dialogCommonPadding(),
                child: CustomTextView(
                  dialogTitle,
                  style: AppTextStyles.boldBlack16.copyWith(
                    color: ColorFile.webThemeColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              divider(),
              SizedBox(height: 20.h),
              Container(
                padding: subWidgetPadding ?? _dialogCommonPadding(),
                child: subWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget mainDialogView({
    required String dialogTitle,
    required String onSaveButtonTitle,
    required Function() onCancelTap,
    required Function() onSaveTap,
    required Widget subWidget,
    bool isLoading = false,
    EdgeInsetsGeometry? subWidgetPadding,
  }) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: ColorFile.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: _dialogCommonPadding(),
                child: CustomTextView(
                  dialogTitle,
                  style: AppTextStyles.boldBlack16.copyWith(
                    color: ColorFile.webThemeColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              divider(),
              SizedBox(height: 20.h),
              Container(
                padding: subWidgetPadding ?? _dialogCommonPadding(),
                child: subWidget,
              ),
              SizedBox(height: 20.h),
              divider(),
              SizedBox(height: 20.h),
              Container(
                padding: _dialogCommonPadding(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonWidget.cancelButton(
                      title: StringFile.cancel,
                      onTap: () {
                        onCancelTap();
                      },
                    ),
                    SizedBox(width: 25.w),
                    CustomButton(
                      onSaveButtonTitle,
                      onTap: () async {
                        onSaveTap();
                      },
                      height: 40,
                      bgColor: ColorFile.webThemeColor,
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static EdgeInsets chooseMobileMargin() {
    return EdgeInsets.symmetric(vertical: 14.h);
  }

  static EdgeInsets choseMobilePadding() {
    return EdgeInsets.symmetric(vertical: 15.w);
  }

  static BoxDecoration mobileChoseDecoration() {
    return BoxDecoration(
      color: ColorFile.transparentColor,
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      border: Border.all(color: ColorFile.webBorderGrayColor),
    );
  }

  static Widget chooseTitle({required String title}) {
    return CustomTextView(title, style: AppTextStyles.regularBlack14);
  }

  static Widget optionMobile({required Widget child}) {
    return Container(
      width: Get.width,
      margin: CommonWidget.chooseMobileMargin(),
      padding: CommonWidget.choseMobilePadding(),
      decoration: CommonWidget.mobileChoseDecoration(),
      child: child,
    );
  }

  static BorderRadius commonBorderRadius() {
    return BorderRadius.only(
      bottomLeft: Radius.circular(10.r),
      bottomRight: Radius.circular(10.r),
    );
  }

  static Border commonBorder() {
    return Border.all(color: ColorFile.whiteColor);
  }

  static BorderRadius formRadius() {
    return BorderRadius.zero;
  }

  static EdgeInsets _dialogCommonPadding() {
    return EdgeInsets.symmetric(horizontal: 20.w);
  }

  static EdgeInsets commonPadding({double? horizontalPadding}) {
    return EdgeInsets.symmetric(horizontal: horizontalPadding ?? 120.w);
  }

  static Widget cancelButton({String? title, Function()? onTap, int? height}) {
    return CustomButton(
      title ?? StringFile.cancel,
      onTap: () {
        onTap?.call() ?? Get.back();
      },
      width: ResponsiveUtil.isWeb ? null : 200.w,
      height: height ?? (ResponsiveUtil.isWeb ? 40 : 45),
      bgColor: ColorFile.transparentColor,
      hasBorder: true,
      textColor: ColorFile.webThemeColor,
    );
  }

  static Widget borderButton({
    required String title,
    String? asset,
    required Function() onTap,
  }) {
    return CustomButton(
      title,
      mainAxisSize: MainAxisSize.min,
      height: 40,
      onTap: () async {
        onTap();
      },
      asset: asset ?? AssetsIcons.icAdd,
      hasBorder: true,
      bgColor: ColorFile.whiteColor,
      textColor: ColorFile.webThemeColor,
    );
  }

  static Widget customAddButton({
    required String title,
    int? height,
    String? asset,
    required Function() onTap,
  }) {
    return CustomButton(
      title,
      mainAxisSize: MainAxisSize.min,
      height: height ?? 40,
      onTap: () {
        onTap();
      },
      asset: asset ?? AssetsIcons.icAdd,
      hasBorder: true,
      assetColorFilter:
          const ColorFilter.mode(ColorFile.whiteColor, BlendMode.srcIn),
      bgColor: ColorFile.webThemeColor,
      textColor: ColorFile.whiteColor,
    );
  }

  static Widget webThemeButton({
    bool isLoading = false,
    required String title,
    required Function() onTap,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    int? height,
  }) {
    return CustomButton(
      isLoading: isLoading,
      height: height ?? 45,
      title,
      hasBorder: true,
      textColor: ColorFile.whiteColor,
      bgColor: ColorFile.webThemeColor,
      onTap: onTap,
      mainAxisSize: mainAxisSize,
    );
  }

  static Widget customListSearchWidget({
    required TextEditingController controller,
    required String hint,
    required Function(String) onChange,
    Key? key,
    bool showAdvanceSearchIcon = true,
    bool isAdvanceIconShow = true,
    GlobalKey? globalKey,
    Widget? filterView,
  }) {
    final TimerUtils typingTimerUtils = TimerUtils();
    return BorderContainer(
      key: key,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  AssetsIcons.icSearch,
                  width: 18.w,
                  height: 18.w,
                  colorFilter: ColorFilter.mode(
                    ColorFile.blackColorOpaque50,
                    BlendMode.srcIn,
                  ),
                ),
                Expanded(
                  child: CustomEditText(
                    hint,
                    controller,
                    TextInputType.name,
                    isBorderLess: true,
                    onChange: (value) {
                      typingTimerUtils.startTypingTimer((p0) async {
                        if (value.isEmpty || value.length > 2) {
                          onChange(value);
                        }
                      }, value);
                    },
                  ),
                ),
              ],
            ),
          ),
          if (showAdvanceSearchIcon && globalKey != null && filterView != null)
            ...[],
        ],
      ),
    );
  }

  static WidgetSpan customWidgetSpanWidget({
    required String text,
    Color? textColor,
    VoidCallback? onTaped,
    TextDecoration? textDecoration,
    TextDecorationStyle? decorationStyle,
    TextAlign? textAlign,
    TextOverflow? overflow,
    String? semanticsLabel,
    TextStyle? style,
  }) {
    return WidgetSpan(
      child: (onTaped != null)
          ? CustomGestureDetector(
              semanticsLabel: semanticsLabel,
              onTap: () => onTaped(),
              child: CustomTextView(
                text,
                textAlign: textAlign ?? TextAlign.center,
                style: style ??
                    AppTextStyles.boldBlack12.copyWith(
                      overflow: overflow,
                      decoration: textDecoration ?? TextDecoration.none,
                      decorationStyle: decorationStyle,
                    ),
              ),
            )
          : CustomTextView(
              text,
              textAlign: textAlign ?? TextAlign.center,
              style: style ??
                  AppTextStyles.boldBlack12.copyWith(
                    overflow: overflow,
                    decoration: textDecoration ?? TextDecoration.none,
                    decorationStyle: decorationStyle,
                  ),
            ),
    );
  }

  static TextSpan customTextSpanWidget({
    required String text,
    TextStyle? style,
  }) {
    return TextSpan(text: text, style: style ?? AppTextStyles.mediumBlack14);
  }

  String getPhoneNumberRemoveDash(String enterStr) {
    if (enterStr.isNotEmpty) {
      enterStr =
          enterStr.replaceAll("(", "").replaceAll(")", "").replaceAll("-", "");
    }

    return enterStr;
  }
}
