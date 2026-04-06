import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/utils/assets_icons.dart';
import '../core/utils/color_file.dart';
import '../core/utils/responsive_util.dart';
import '../core/utils/typing_timer_util.dart';
import 'border_container.dart';
import 'custom_edit_text.dart';

class CustomSearchWidget extends StatelessWidget {
  final GlobalKey advanceSearchKey;
  final TextEditingController textController;
  final String hintText;
  final ValueChanged<String> onSearchChanged;
  final Widget? advanceSearchWidget;
  final Widget? addWidget;
  final EdgeInsetsGeometry? padding;

  const CustomSearchWidget({
    super.key,
    required this.advanceSearchKey,
    required this.textController,
    required this.hintText,
    this.addWidget,
    required this.onSearchChanged,
    this.advanceSearchWidget,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    var util = TimerUtils();

    return BorderContainer(
      width: double.infinity,
      padding: padding ??
          ((ResponsiveUtil.isWeb)
              ? EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w)
              : EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h)),
      key: advanceSearchKey,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  AssetsIcons.icSearch,
                  width: 18.w,
                  height: 18.h,
                  colorFilter: const ColorFilter.mode(
                    ColorFile.blackColor,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: ResponsiveUtil.isWeb ? 15.w : 10.w),
                Expanded(
                  child: CustomEditText(
                    hintText,
                    textController,
                    TextInputType.text,
                    isBorderLess: true,
                    onChange: (value) {
                      if (value.length > 2 || value.isEmpty) {
                        util.startTypingTimer((p0) async {
                          onSearchChanged(value);
                        }, value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          if (advanceSearchWidget != null) ...[
            SizedBox(width: 8.w),
            advanceSearchWidget ?? Container(),
          ],
          if (addWidget != null) ...[
            SizedBox(width: 8.w),
            addWidget ?? Container(),
          ],
        ],
      ),
    );
  }
}
