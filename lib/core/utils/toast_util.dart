import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import '../../custom_view/custom_text_view.dart';
import '../enum/toast_duration.dart';
import 'app_text_styles.dart';
import 'assets_icons.dart';
import 'color_file.dart';

class ToastUtil {
  static Map<String, ToastificationItem> items = {};

  static show({
    required String? message,
    ToastificationType type = ToastificationType.error,
    ToastDuration autoCloseDuration = ToastDuration.sticky,
  }) {
    if (message == null || message.isEmpty) return;
    if (items.isNotEmpty && items.entries.last.value.isRunning) {
      if (items.entries.last.key == message) {
        toastification.dismiss(items.entries.last.value);
        items.remove(items.entries.last.key);
      }
    }
    Color textColor = ColorFile.errorColor;
    String asset = AssetsIcons.icError;
    switch (type) {
      case ToastificationType.error:
        textColor = ColorFile.errorColor;
        asset = AssetsIcons.icError;
        break;
      case ToastificationType.warning:
        // backgroundColor = AppColors.warning;
        asset = AssetsIcons.icWarning;
        break;
      case ToastificationType.info:
        // backgroundColor = AppColors.info;
        // asset = AssetsIcons.icInfo2;
        break;
      case ToastificationType.success:
        textColor = ColorFile.successColor;
        asset = AssetsIcons.icSuccess;
        break;
    }

    var item = toastification.show(
      autoCloseDuration: Duration(seconds: autoCloseDuration.seconds),
      animationDuration: const Duration(milliseconds: 300),
      description: CustomTextView(
        message,
        style: AppTextStyles.mediumBlack14.copyWith(color: textColor),
      ),
      type: type,
      showProgressBar: false,
      backgroundColor: ColorFile.whiteColor,
      borderSide: BorderSide(color: textColor, width: 2.0),
      icon: SvgPicture.asset(asset),
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: (value) {
          var key = items.entries
              .firstWhere((element) => element.value == value)
              .key;
          items.remove(key);
        },
        onCloseButtonTap: (value) {
          toastification.dismiss(value);
          var key = items.entries
              .firstWhere((element) => element.value == value)
              .key;
          items.remove(key);
        },
      ),
    );
    items.putIfAbsent(message, () => item);
  }

  static dismissAll() {
    toastification.dismissAll();
  }
}
