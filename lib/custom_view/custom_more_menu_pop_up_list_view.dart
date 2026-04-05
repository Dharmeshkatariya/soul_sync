import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/utils/app_text_styles.dart';
import '../core/utils/color_file.dart';
import '../models/more_menu_item_model.dart';
import 'custom_text_view.dart';

class CustomMoreMenuPopUpListView extends StatelessWidget {
  final List<MoreMenuItemModel> items;
  final double width;
  final double borderRadius;

  const CustomMoreMenuPopUpListView({
    required this.items,
    this.width = 200,
    this.borderRadius = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hoverIndex = ValueNotifier<int?>(null);
    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        return _buildMenuItem(item, index, hoverIndex);
      }),
    );
  }

  Widget _buildMenuItem(
    MoreMenuItemModel item,
    int index,
    ValueNotifier<int?> hoverIndex,
  ) {
    return MouseRegion(
      onEnter: (_) => hoverIndex.value = index,
      onExit: (_) => hoverIndex.value = null,
      child: ValueListenableBuilder<int?>(
        valueListenable: hoverIndex,
        builder: (context, value, child) {
          final isHovered = value == index;
          return GestureDetector(
            onTap: () {
              item.onTap();
            },
            child: Container(
              color: isHovered
                  ? ColorFile.webThemeColorOpaque10
                  : Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    item.iconPath,
                    width: 24.w,
                    height: 24.h,
                    colorFilter: ColorFilter.mode(
                      isHovered
                          ? ColorFile.webDarkThemeColor
                          : ColorFile.blackColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: CustomTextView(
                        item.title,
                        style: AppTextStyles.regularBlack14.copyWith(
                          color: isHovered
                              ? ColorFile.webDarkThemeColor
                              : ColorFile.blackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
