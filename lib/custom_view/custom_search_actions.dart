import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/constants_file.dart';
import '../core/utils/assets_icons.dart';
import '../core/utils/color_file.dart';
import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';
import '../core/utils/typing_timer_util.dart';

class CustomSearchBarAndActionControlsWidget extends StatelessWidget {
  CustomSearchBarAndActionControlsWidget({
    required this.textEditingController,
    required this.hint,
    required this.onSearch,
    this.actions,
    this.divider = false,
    super.key,
    this.padding,
    this.height,
  });

  TextEditingController textEditingController;
  String hint;
  final TimerUtils typingTimerUtils = TimerUtils();
  Function(String) onSearch;
  final List<Widget>? actions;
  final bool divider;
  final EdgeInsetsGeometry? padding;

  final double? height;

  @override
  Widget build(BuildContext context) {
    ResponsiveUtil.init(context);
    var unitWidth = ResponsiveUtil.screenWidth / 100;
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: unitWidth * 1.5),
      height: height ?? ((ResponsiveUtil.isWeb) ? 60.h : 40.h),
      decoration: BoxDecoration(
        border: Border.all(color: ColorFile.grayDDColor),
        borderRadius: BorderRadius.circular(8.r),
        color: ColorFile.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AssetsIcons.icSearch,
            width: 16.w,
            height: 16.w,
            color: ColorFile.webThemeColor,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: (value) async {
                if (value.length > 2) {
                  typingTimerUtils.startTypingTimer((p0) async {
                    onSearch(value);
                  }, value);
                } else if (value.isEmpty) {
                  onSearch(value);
                }
              },
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.next,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(14.w, 14.w, 12.w, 14.w),
                hintStyle: TextStyle(
                  color: ColorFile.hintTextColor,
                  fontSize: 13.sp,
                  fontFamily: ConstantsFile.regularFont,
                ),
              ),
              style: TextStyle(
                color: ColorFile.lightBlackColor,
                fontSize: 13.sp,
                fontFamily: ConstantsFile.regularFont,
              ),
            ),
          ),
          if (divider)
            Container(
              width: 1.w,
              color: ColorFile.grayDDColor,
              height: double.maxFinite,
            ),
          if (actions != null) ...[Row(children: actions ?? [])],
        ],
      ),
    );
  }
}
