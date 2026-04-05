import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/app_text_styles.dart';
import '../core/utils/string_file.dart';
import 'custom_text_view.dart';

class CustomNoDataFoundWidget extends StatelessWidget {
  const CustomNoDataFoundWidget({super.key, this.noDataFoundTitle});

  final String? noDataFoundTitle;

  @override
  Widget build(BuildContext context) {
    return _noDataFound(noDataFoundTitle ?? StringFile.noDataFound);
  }

  Widget _noDataFound(String title) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 50.h, bottom: 50.h),
      child: CustomTextView(title, style: AppTextStyles.boldBlack14),
    );
  }
}
