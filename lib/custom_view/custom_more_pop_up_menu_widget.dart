import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/custom_view/web_custom_action_button.dart';
import '../core/utils/assets_icons.dart';
import '../core/utils/common.dart';
import '../core/utils/responsive_util.dart';
import '../core/utils/string_file.dart';
import 'custom_menu.dart';

class CustomMorePopUpMenuWidget extends StatelessWidget {
  const CustomMorePopUpMenuWidget({
    required this.filterView,
    super.key,
    this.isAdvanceIconShow = false,
    this.filterViewPadding,
  });

  final Widget filterView;
  final bool isAdvanceIconShow;
  final EdgeInsets? filterViewPadding;

  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey();
    return Container(
      key: globalKey,
      child: WebCustomActionButton(
        message: StringFile.more,
        icon: AssetsIcons.icMore,
        iconHeight: ResponsiveUtil.isWeb ? 18.w : 20.w,
        iconWidth: ResponsiveUtil.isWeb ? 18.w : 20.w,
        onTaped: () => CustomMenu.showCustomMenu(
          globalKey: globalKey,
          context: context,
          child: filterView,
          width: 200.w,

          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
