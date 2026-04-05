import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soul_sync/core/utils/common_widget.dart';

import '../core/utils/app_text_styles.dart';
import '../core/utils/assets_icons.dart';
import '../core/utils/color_file.dart';
import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';
import '../core/utils/string_file.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomEmptyDataView extends StatelessWidget {
  const CustomEmptyDataView({
    super.key,
    required this.moduleNameTitle,
    this.buttonText,
    this.onTapButton,
    this.title = "",
    this.subTitle = "",
    this.isSearchEmptyData = false,
  });

  final String moduleNameTitle;
  final String title;
  final String subTitle;
  final String? buttonText;
  final VoidCallback? onTapButton;
  final bool isSearchEmptyData;

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);
    String moduleName = moduleNameTitle.isNotEmpty
        ? moduleNameTitle
        : StringFile.data;
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: 550.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsIcons.icNoPrescriptionFound,
              width: 120.w,
              height: 120.w,
              colorFilter: ColorFilter.mode(
                ColorFile.grayIconColor,
                BlendMode.srcIn,
              ),
            ),
            15.verticalSpace,
            CustomTextView(
              isSearchEmptyData
                  ? "${StringFile.no} $moduleName ${StringFile.found}."
                  : "${StringFile.no} $moduleName ${StringFile.addedYet}.",
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBoldBlack16,
            ),
            15.verticalSpace,
            if (title.isNotEmpty) ...[
              CustomTextView(title, style: AppTextStyles.semiBoldBlack18),
              15.verticalSpace,
            ],
            if (subTitle.isNotEmpty) ...[
              CustomTextView(subTitle, style: AppTextStyles.regularBlack14),
            ] else if (isSearchEmptyData) ...[
              _noSearchDescription(moduleName),
            ] else if (buttonText != null) ...[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    CommonWidget.customWidgetSpanWidget(
                      text:
                          '${StringFile.startByAddingYourFirst} $moduleName ${StringFile.toManageAndMonitorEverythingFromOnePlace} ',
                      style: AppTextStyles.regularBlack14,
                    ),
                    CommonWidget.customWidgetSpanWidget(
                      text: StringFile.click,
                      style: AppTextStyles.regularBlack14,
                    ),
                    WidgetSpan(child: SizedBox(width: 4.w)),
                    CommonWidget.customWidgetSpanWidget(
                      text: '"$buttonText"',
                      style: AppTextStyles.boldBlack14,
                    ),
                    WidgetSpan(child: SizedBox(width: 4.w)),
                    CommonWidget.customWidgetSpanWidget(
                      text: "${StringFile.belowToGetStarted}.",
                      style: AppTextStyles.regularBlack14,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              _buttonWidget(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buttonWidget() {
    return CustomButton(
      width: 180.w,
      height: 50,
      buttonText ?? '',
      hasBorder: true,
      textColor: ColorFile.whiteColor,
      bgColor: ColorFile.webThemeColor,
      asset: AssetsIcons.icAddWithoutBg,
      assetColorFilter: const ColorFilter.mode(
        ColorFile.whiteColor,
        BlendMode.srcIn,
      ),
      onTap: onTapButton != null ? onTapButton! : () {},
    );
  }

  Widget _noSearchDescription(String moduleNameTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: RichText(
        textAlign: TextAlign.center,
        softWrap: true,
        text: TextSpan(
          children: [
            CommonWidget.customWidgetSpanWidget(
              text: StringFile.accordingToYourSpecifiedSearchCriteriaNoSuitable,
              style: AppTextStyles.regularBlack14,
            ),

            WidgetSpan(child: SizedBox(width: 5.w)),
            CommonWidget.customWidgetSpanWidget(
              text: moduleNameTitle.toLowerCase(),
              style: AppTextStyles.boldBlack14,
            ),

            WidgetSpan(child: SizedBox(width: 5.w)),
            CommonWidget.customWidgetSpanWidget(
              text:
                  StringFile.pleaseConsiderRefiningYourFiltersSearchParameters,
              style: AppTextStyles.regularBlack14,
            ),
          ],
        ),
      ),
    );
  }
}
