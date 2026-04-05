import 'package:soul_sync/custom_view/custom_text_view.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:soul_sync/core/constants/constants_file.dart';
import 'package:soul_sync/core/utils/common.dart';

extension StringExtension on String {
  String toTitleCase() {
    return split('_')
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '')
        .join(' ');
  }

  String capitalizeEachWord() {
    return toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }

  String capitalizeFirstOnly() {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String formatAsPhoneNumber() {
    final formatter = MaskTextInputFormatter(
      mask: '(###)-###-####',
      filter: {"#": RegExp(r'\d')},
    );
    return formatter.maskCustomTextView(this);
  }

  String get formatted => isNotEmpty
      ? split('_')
              .map((word) => word.isNotEmpty
                  ? word[0].toUpperCase() + word.substring(1)
                  : '')
              .join(' ')
              .capitalize ??
          ''
      : '';

  double toDouble() {
    try {
      if (isEmpty) {
        return 0.0;
      } else {
        return double.parse(this);
      }
    } catch (e) {
      Common().printLog('', e.toString());
    }
    return 0.0;
  }

  int toInt() {
    try {
      if (isEmpty) {
        return 0;
      } else {
        return int.parse(this);
      }
    } catch (e) {
      Common().printLog('', e.toString());
    }
    return 0;
  }

}

extension DateFormatExt on DateTime {
  String get tommDDyyyy => DateFormat(ConstantsFile.mmDDYyyy).format(this);

  String get tommmDDYyyyHHMMA =>
      DateFormat(ConstantsFile.mmmDDYyyyHHMMA).format(this);

  String get tommmDDYyyy => DateFormat(ConstantsFile.mmDDYyyy).format(this);

  DateTime get currentMonday =>  subtract(Duration(days: weekday - DateTime.monday));
  DateTime get currentSunday =>  add(Duration(days: DateTime.sunday - weekday));
}
