import 'package:soul_sync/core/utils/string_file.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../constants/constants_file.dart';
import '../enum/misc_enums.dart';
import '../routes/routes.dart';
import 'app_locale.dart';
import 'color_file.dart';
import 'globals.dart';

class Common {
  String buildVersion = "v1.1(030222)"; // for Apk Build Version
  OverlayEntry? overlayEntry;
  static String tempToken = ''; //temp token for create password for new user

  // static void showSnackBar(
  //   String msg, {
  //   SnackBarType snackBarType = SnackBarType.error,
  //   int duration = 3,
  // }) {
  //   var assetName = '';
  //   var backgroundColor = ColorFile.errorColor;
  //   var primaryColor = ColorFile.whiteColor;
  //   switch (snackBarType) {
  //     case SnackBarType.error:
  //       assetName = AssetsIcons.icError;
  //       backgroundColor = ColorFile.errorColor;
  //       primaryColor = ColorFile.whiteColor;
  //       break;
  //     case SnackBarType.warning:
  //       assetName = AssetsIcons.icWarning;
  //       backgroundColor = ColorFile.warningColor;
  //       primaryColor = ColorFile.whiteColor;
  //       break;
  //     case SnackBarType.info:
  //       assetName = AssetsIcons.icInfo;
  //       backgroundColor = ColorFile.infoColor;
  //       primaryColor = ColorFile.whiteColor;
  //       break;
  //     case SnackBarType.success:
  //       assetName = AssetsIcons.icSuccess;
  //       backgroundColor = ColorFile.successColor;
  //       primaryColor = ColorFile.whiteColor;
  //       break;
  //   }
  //   if (!Get.isSnackbarOpen && msg.isNotEmpty) {
  //     Get.snackbar(
  //       StringFile.appName,
  //       msg,
  //       titleText: Container(),
  //       messageText: CustomTextView(
  //         msg,
  //         style: AppTextStyles.mediumBlack14.copyWith(color: primaryColor),
  //       ),
  //       backgroundColor: backgroundColor,
  //       colorText: primaryColor,
  //       borderWidth: 1.0,
  //       borderRadius: 8.r,
  //       borderColor: primaryColor,
  //       mainButton: TextButton(
  //         onPressed: null,
  //         child: IconButton(
  //           onPressed: () {
  //             if (Get.isSnackbarOpen) {
  //               Get.back();
  //             }
  //           },
  //           icon: const Icon(Icons.close, color: ColorFile.whiteColor),
  //         ),
  //       ),
  //       duration: Duration(seconds: duration),
  //       icon: SvgPicture.asset(
  //         assetName,
  //         width: 24.w,
  //         height: 24.h,
  //         colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
  //       ),
  //       margin: EdgeInsets.only(top: 6.w, left: 6.w, right: 6.w),
  //     );
  //   }
  // }

  static void dismissDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static authLogOut() {
    // Get.delete<APIServices>();
    // Get.delete<LoginController>();
    Get.clearRouteTree();
    Get.offAllNamed(Routes().login);
  }

  static void showProgressDialog({bool dismissible = true}) {
    Get.dialog(
      Center(child: CircularProgressIndicator(color: ColorFile.webThemeColor)),
      barrierDismissible: dismissible,
    );
  }

  Future<dynamic> openRightSideSheet(
    Widget child, {
    bool barrierDismissible = true,
  }) {
    return Get.generalDialog(
      barrierLabel: StringFile.label,
      barrierDismissible: barrierDismissible,
      barrierColor: ColorFile.blackColor.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return Align(alignment: Alignment.topRight, child: child);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  static bottomSheet({required BuildContext context, required Widget child}) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(child: Container(child: child));
      },
    );
  }

  void openLeftSideSheet(Widget child) {
    Get.generalDialog(
      barrierLabel: StringFile.label,
      barrierDismissible: true,
      barrierColor: ColorFile.blackColor.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, anim1, anim2) {
        return Align(alignment: Alignment.topLeft, child: child);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 0),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Future openDialogFromTop(Widget child, {bool dismissible = true}) {
    return Get.generalDialog(
      barrierLabel: StringFile.label,
      barrierDismissible: dismissible,
      barrierColor: ColorFile.blackColorOpaque80,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Align(alignment: AlignmentDirectional.topCenter, child: child);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, -.50),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  void showSideSnackBar(RxString view, String message, {int seconds = 5}) {
    view.value = message;
    Future.delayed(Duration(seconds: seconds), () => view.value = '');
  }

  printLog(String title, String log) {
    print("--------$title-------------$log");
  }

  static String getInitials(String? name) {
    try {
      if (name == null || name.isEmpty) {
        return '';
      }
      List<String> listOfString = name.split(' ');
      if (listOfString.length > 1) {
        return '${listOfString[0].substring(0, 1)}${listOfString[1].substring(0, 1)}';
      } else {
        return listOfString[0].substring(0, 1);
      }
    } catch (e) {
      return '';
    }
  }

  String getCurrentYear() {
    DateTime currentDate = DateTime.now();
    String year = DateFormat('yyyy').format(currentDate);
    return year;
  }

  static String formatDuration(DateTime expiryTime, DateTime currentTime) {
    Duration duration = expiryTime.difference(currentTime);
    int seconds = duration.inSeconds;
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  static String displayLocalDate({
    required String inputDate,
    required DisplayDateType displayDateType,
    String? customFormat,
  }) {
    String outputDate = "";
    try {
      DateTime parsedUtcTime = DateTime.parse(inputDate);
      DateTime localTime = parsedUtcTime.toLocal();
      if (customFormat != null && customFormat.isNotEmpty) {
        outputDate = AppLocale().dateFormatter(customFormat).format(localTime);
      } else if (displayDateType == DisplayDateType.date) {
        outputDate = AppLocale().yMdFormatter.format(localTime);
      } else if (displayDateType == DisplayDateType.time) {
        outputDate =
            AppLocale().dateFormatter(ConstantsFile.hhMMA).format(localTime);
      } else if (displayDateType == DisplayDateType.dateAndTime) {
        outputDate = AppLocale()
            .yMdFormatter
            .addPattern(ConstantsFile.hhMMA, ',')
            .format(localTime);
      } else {
        outputDate = AppLocale().yMdFormatter.format(localTime);
      }
    } catch (e) {
      outputDate = "";
    }
    return outputDate;
  }

  static List<String> countyCodeList = [
    '+1',
    '+7',
    '+20',
    '+27',
    '+30',
    '+31',
    '+32',
    '+33',
    '+34',
    '+36',
    '+39',
    '+40',
    '+41',
    '+43',
    '+44',
    '+45',
    '+46',
    '+47',
    '+48',
    '+49',
    '+51',
    '+52',
    '+53',
    '+54',
    '+55',
    '+56',
    '+57',
    '+58',
    '+60',
    '+61',
    '+62',
    '+63',
    '+64',
    '+65',
    '+66',
    '+81',
    '+82',
    '+84',
    '+86',
    '+90',
    '+91',
    '+92',
    '+93',
    '+94',
    '+95',
    '+98',
    '+211',
    '+212',
    '+213',
    '+216',
    '+218',
    '+220',
    '+221',
    '+222',
    '+223',
    '+224',
    '+225',
    '+226',
    '+227',
    '+228',
    '+229',
    '+230',
    '+231',
    '+232',
    '+233',
    '+234',
    '+235',
    '+236',
    '+237',
    '+238',
    '+239',
    '+240',
    '+241',
    '+242',
    '+243',
    '+244',
    '+245',
    '+246',
    '+248',
    '+249',
    '+250',
    '+251',
    '+252',
    '+253',
    '+254',
    '+255',
    '+256',
    '+257',
    '+258',
    '+260',
    '+261',
    '+262',
    '+263',
    '+264',
    '+265',
    '+266',
    '+267',
    '+268',
    '+269',
    '+290',
    '+291',
    '+297',
    '+298',
    '+299',
    '+350',
    '+351',
    '+352',
    '+353',
    '+354',
    '+355',
    '+356',
    '+357',
    '+358',
    '+359',
    '+370',
    '+371',
    '+372',
    '+373',
    '+374',
    '+375',
    '+376',
    '+377',
    '+378',
    '+379',
    '+380',
    '+381',
    '+382',
    '+383',
    '+385',
    '+386',
    '+387',
    '+389',
    '+420',
    '+421',
    '+423',
    '+500',
    '+501',
    '+502',
    '+503',
    '+504',
    '+505',
    '+506',
    '+507',
    '+508',
    '+509',
    '+590',
    '+591',
    '+592',
    '+593',
    '+594',
    '+595',
    '+596',
    '+597',
    '+598',
    '+599',
    '+670',
    '+672',
    '+673',
    '+674',
    '+675',
    '+676',
    '+677',
    '+678',
    '+679',
    '+680',
    '+681',
    '+682',
    '+683',
    '+685',
    '+686',
    '+687',
    '+688',
    '+689',
    '+690',
    '+691',
    '+692',
    '+850',
    '+852',
    '+853',
    '+855',
    '+856',
    '+880',
    '+886',
    '+960',
    '+961',
    '+962',
    '+963',
    '+964',
    '+965',
    '+966',
    '+967',
    '+968',
    '+970',
    '+971',
    '+972',
    '+973',
    '+974',
    '+975',
    '+976',
    '+977',
    '+992',
    '+993',
    '+994',
    '+995',
    '+996',
    '+998',
  ];

  static String extractNumber(String formattedNumber) {
    String digits = formattedNumber.replaceAll(RegExp(r'\D'), '');
    return digits;
  }

  static List<TextInputFormatter>? mGetInputFormat(
    TextInputType textInputType,
  ) {
    List<TextInputFormatter>? inputFormatter = [];
    if (textInputType == TextInputType.text) {
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z,' ]")),
      ];
    } else if (textInputType == TextInputType.name) {
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z,' ]")),
      ];
    } else if (textInputType == TextInputType.emailAddress) {
      inputFormatter = [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@_.-]")),
      ];
    } else if (textInputType == TextInputType.number) {
      inputFormatter = [FilteringTextInputFormatter.allow(RegExp("[0-9]"))];
    } else if (textInputType == TextInputType.phone) {
      return [
        MaskTextInputFormatter(
          mask: appLocale.getPhoneMask(),
          filter: {"#": RegExp(r'\d')},
          type: MaskAutoCompletionType.lazy,
        ),
      ];
    } else if (textInputType == TextInputType.streetAddress) {
      return appLocale.getZipInputFormatters();
    } else if (textInputType == TextInputType.datetime) {
      var maskFormatter = MaskTextInputFormatter(
        mask: '##/##/####',
        filter: {"#": RegExp(r'\d')},
        type: MaskAutoCompletionType.lazy,
      );
      inputFormatter = [maskFormatter];
    }
    return inputFormatter;
  }

  static Future<String> loadRootStringBundle({
    required String loadAssetPath,
  }) async {
    final String content = await rootBundle.loadString(loadAssetPath);
    return content;
  }

  static T getUrlParameterAsType<T>({
    required String key,
    required T Function(String?) fromType,
    required T defaultValue,
  }) {
    String? value = Get.parameters[key];
    return value != null ? fromType(value) : defaultValue;
  }

  static String getUrlParameters({required String requestAndResponseParams}) {
    String id = "";
    Map<String, String?> urlParameters = Get.parameters;
    if (urlParameters.isNotEmpty) {
      id = urlParameters[requestAndResponseParams] ?? "";
      return id;
    }
    return id;
  }

  static dateConvert(
    String value,
    String inputDateFormat,
    String outputDateFormat,
  ) {
    var inputFormat = DateFormat(inputDateFormat);
    var inputDate = inputFormat.tryParse(value);
    var outputFormat = DateFormat(outputDateFormat);
    if (inputDate != null) {
      return outputFormat.format(inputDate);
    } else {
      return '';
    }
  }

  datePickerTheme(context, child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: ColorFile.webThemeColor,
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: ColorFile.webThemeColor, // button text color
          ),
        ),
        useMaterial3: false,
        dialogTheme: DialogTheme(
          backgroundColor: ColorFile.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
        ),
      ),
      child: child!,
    );
  }

  static String dateConvertApiFormat({required String text}) {
    String date = text.trim().isNotEmpty
        ? Common.dateConvert(
            text.trim(),
            appLocale.yMdFormatter.pattern ?? '',
            ConstantsFile.yyyyMMDD,
          )
        : '';
    return date;
  }

  static num displayParseNum({
    required dynamic input,
    num defaultValue = 0,
    bool tryParsingString = true,
    bool truncateDoubles = false,
  }) {
    if (input == null) return defaultValue;

    if (input is num) {
      return truncateDoubles && input is double ? input.toInt() : input;
    }

    if (input is String) {
      if (input.isEmpty) return defaultValue;
      try {
        final parsed = num.parse(input);
        return truncateDoubles && parsed is double ? parsed.toInt() : parsed;
      } catch (e) {
        if (!tryParsingString) return defaultValue;

        final numericString = input.replaceAll(RegExp(r'[^0-9\.\-]'), '');
        if (numericString.isNotEmpty) {
          try {
            final parsed = num.parse(numericString);
            return truncateDoubles && parsed is double
                ? parsed.toInt()
                : parsed;
          } catch (_) {
            return defaultValue;
          }
        }
        return defaultValue;
      }
    }

    if (input is bool) {
      return input ? 1 : 0;
    }
    try {
      return displayParseNum(
        input: input.toString(),
        defaultValue: defaultValue,
        tryParsingString: tryParsingString,
        truncateDoubles: truncateDoubles,
      );
    } catch (e) {
      return defaultValue;
    }
  }
}
