import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:soul_sync/core/constants/constants_file.dart';
import 'package:soul_sync/core/enum/app_language_type.dart';

import 'logger_utils.dart';

class AppLocale extends GetxController {
  AppLocale.initialize();

  static AppLocale get _instance {
    try {
      return Get.find<AppLocale>();
    } catch (e) {
      return Get.put(AppLocale.initialize());
    }
  }

  factory AppLocale() => _instance;

  var locale = Locale(
    AppLanguageType.english.code!,
    SupportedCountries.usa.code,
  ).obs;

  Future<AppLocale> checkLoginType() async {
    setLocal();
    // AuthService.instance.isProvider = !(await SharedPref.isPatientLoggedIn());
    // AuthService.instance.isPatient = (await SharedPref.isPatientLoggedIn()) ||
    //     (await SharedPref.isGuestPatientLoggedIn());
    // AuthService.instance.isLoggedin =
    //     AuthService.instance.isProvider || AuthService.instance.isPatient;
    return this;
  }

  Future<void> setLocal() async {
    // String languageCode = SharedPref.getLanguage();
    // String countryCode =
    //     SharedPref.getCountryCode() ?? SupportedCountries.usa.code;
    // locale(Locale(languageCode, countryCode));
    // await AppLocalizations.delegate.load(locale.value);
    // await Get.updateLocale(locale.value);
    Intl.defaultLocale = locale.toString();
    update();
  }

  Future<void> changeLocale({
    required String lnCode,
    required String countryCode,
  }) async {
    // await SharedPref.setCountryCode(countryCode);
    // await SharedPref.setLanguage(lnCode);
    locale(Locale(lnCode, countryCode));
    setLocal();
    // WebHomeController webHomeController = Get.find();
    // await SharedPref.setAge(webHomeController.selectedAge.value);
    // await SharedPref
    //     .setSymptom(webHomeController.specialityTEController.value.text);
    // await SharedPref.setLat(webHomeController.mLatitude);
    // await SharedPref
    //     .setInsurance(webHomeController.selectedInsuranceType.value);
    // await SharedPref.setLong(webHomeController.mLongitude);
    //
    // window.location.reload();
    // await AppLocalizations.delegate.load(locale.value);
    Intl.defaultLocale = locale.toString();
    await Get.updateLocale(locale.value);
    update();
  }

  // Date formatting methods
  String formatDate(DateTime date) {
    return DateFormat.yMd(locale.toString()).format(date);
  }

  DateFormat dateFormatter(String pattern) {
    return DateFormat(pattern, locale.toString());
  }

  DateFormat get yMdFormatter {
    return DateFormat.yMd(locale.toString());
  }

  DateFormat get yMdAPI {
    return DateFormat('yyyy-MM-dd');
  }

  DateFormat get hhMMaaFormatter {
    return DateFormat.Hm(locale.toString());
  }

  // Date formatting methods
  String formatDateYyyyMmDd(DateTime date) {
    return DateFormat('yyyy-MM-dd', locale.value.toString()).format(date);
  }

  String formatTommYYY(DateTime date) {
    return DateFormat(ConstantsFile.MMYY, locale.value.toString()).format(date);
  }

  String formatTomMMddYYY(DateTime date) {
    return DateFormat(
      ConstantsFile.mMMddYYY,
      locale.value.toString(),
    ).format(date);
  }

  String formatMMMdd(DateTime date) {
    return DateFormat(ConstantsFile.MMdd, locale.value.toString()).format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat.jm(locale.value.toString()).format(time);
  }

  String formatTimeHhMmSs(DateTime time) {
    return DateFormat('HH:mm:ss', locale.value.toString()).format(time);
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMd(locale.value.toString()).add_jm().format(dateTime);
  }

  String formatTheValueCompact({
    required double? amount,
    bool isCurrency = false,
    bool isSymbolVisible = true,
    int absCompareAmount = 1000,
    bool showNegativeSign = true,
  }) {
    if (amount == null) return '';
    final absAmount = amount.abs();
    final isNegative = amount.isNegative && showNegativeSign;
    // Determine currency
    final symbol = isCurrency && isSymbolVisible
        ? NumberFormat.simpleCurrency(
            locale: locale.value.toString(),
          ).currencySymbol
        : '';
    if (absAmount >= absCompareAmount) {
      final compact = NumberFormat.compact(
        locale: locale.value.toString(),
      ).format(absAmount);
      return isNegative ? '- $symbol$compact' : '$symbol$compact';
    } else {
      if (isCurrency) {
        return NumberFormat.currency(
          locale: locale.value.toString(),
          symbol: symbol,
        ).format(amount);
      } else {
        final precise = amount.toStringAsFixed(2);
        return isNegative ? '- $precise' : precise;
      }
    }
  }

  // Currency formatting
  String formatCurrency(double? amount, {bool isSymbolVisible = true}) {
    // Get currency symbol based on locale
    final format = NumberFormat.simpleCurrency(locale: locale.value.toString());
    return NumberFormat.currency(
      locale: locale.value.toString(),
      symbol: isSymbolVisible ? format.currencySymbol : "",
    ).format(amount ?? 0.0);
  }

  String get currencySymbol {
    final format = NumberFormat.simpleCurrency(locale: locale.value.toString());
    return format.currencySymbol;
  }

  // Measurement formatting
  bool useImperialSystem() {
    List<String> imperialCountries = [SupportedCountries.usa.code];
    return imperialCountries.contains(locale.value.countryCode);
  }

  String formatWeight(double kilograms) {
    if (useImperialSystem()) {
      final pounds = kilograms * 2.20462;
      return '${pounds.toStringAsFixed(1)} lb';
    }
    return '${kilograms.toStringAsFixed(1)} kg';
  }

  String formatHeight(double centimeters) {
    if (useImperialSystem()) {
      final inches = centimeters / 2.54;
      final feet = (inches / 12).floor();
      final remainingInches = (inches % 12).round();
      return '$feet\'$remainingInches"';
    }
    return '${centimeters.toStringAsFixed(1)} cm';
  }

  String formatTemperature(double celsius) {
    if (useImperialSystem()) {
      final fahrenheit = (celsius * 9 / 5) + 32;
      return '${fahrenheit.toStringAsFixed(1)}°F';
    }
    return '${celsius.toStringAsFixed(1)}°C';
  }

  // Number formatting
  String formatDecimal(double number) {
    return NumberFormat.decimalPattern(locale.value.toString()).format(number);
  }

  // Distance formatting methods
  String formatDistance(double miles, {bool showFullUnit = false}) {
    if (useImperialSystem()) {
      // Input is already in miles, just format it
      if (miles < 0.1) {
        // Convert to feet for small distances
        final feet = miles * 5280;
        return '${feet.toStringAsFixed(0)} ${showFullUnit ? 'feet' : 'ft'}';
      }
      return '${miles.toStringAsFixed(1)} ${showFullUnit ? 'miles' : 'mi'}';
    } else {
      // Convert miles to kilometers for metric countries
      final kilometers = miles * 1.60934;
      if (kilometers < 1) {
        // Convert to meters for small distances
        final meters = kilometers * 1000;
        return '${meters.toStringAsFixed(0)} ${showFullUnit ? 'meters' : 'm'}';
      }
      return '${kilometers.toStringAsFixed(1)} ${showFullUnit ? 'kilometers' : 'km'}';
    }
  }

  String formatCustomDateFormat({
    required String inputDate,
    required String dateFormat,
  }) {
    String outputDate = "";
    try {
      String currentLocale = locale.value.toString();
      DateTime date = DateTime.parse(inputDate);
      outputDate = DateFormat(dateFormat, currentLocale).format(date);
      return outputDate;
    } catch (e) {
      return inputDate;
    }
  }

  String convertDateMultipleFormat({required String inputDate}) {
    String outputDate = inputDate;
    try {
      // Collapse multiple spaces Remove trailing timezone Trim edges
      String currentLocale = locale.value.toString();
      String cleanedDate = inputDate
          .replaceAll(RegExp(r'\s+'), ' ')
          .replaceAll(RegExp(r' [A-Z]{2,4}$'), '')
          .trim();
      final possibleFormats = [
        DateFormat(ConstantsFile.eeeMMMdYYYYhMMSsa, currentLocale),
        DateFormat(ConstantsFile.eeeMMMdYYYYHHMMSSa, currentLocale),
        DateFormat(ConstantsFile.eeeMMMdHHMMSSYYYY, currentLocale),
        DateFormat(ConstantsFile.eeeMMMDDHHMMSSYYYY, currentLocale),
        DateFormat(ConstantsFile.mMMdYYYYhMMssA, currentLocale),
        DateFormat(ConstantsFile.eeeMMMdYYYYhMMSs, currentLocale),
      ];
      DateTime? parsedDate;
      for (final format in possibleFormats) {
        try {
          parsedDate = format.parseStrict(cleanedDate);
          break;
        } catch (_) {}
      }
      if (parsedDate != null) {
        outputDate = DateFormat(
          ConstantsFile.eeeMMMdYYYYhMMSsa,
        ).format(parsedDate.toLocal());
        return outputDate;
      } else {
        return outputDate;
      }
    } catch (e) {
      LoggerUtil.error(e);
      return outputDate;
    }
  }

  String getPhoneCountryCodeMask() {
    switch (locale.value.countryCode?.toUpperCase()) {
      case 'US':
        return '+1';
      case 'IN':
        return '+91';
      default:
        return '+1';
    }
  }

  List<TextInputFormatter> getZipInputFormatters() {
    switch (locale.value.countryCode?.toUpperCase()) {
      case 'US':
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9\-]')),
          MaskTextInputFormatter(
            mask: '#####-####',
            filter: {"#": RegExp(r'\d')},
            type: MaskAutoCompletionType.lazy,
          ),
          LengthLimitingTextInputFormatter(10),
        ];
      case 'IN':
        return [
          FilteringTextInputFormatter.digitsOnly,
          MaskTextInputFormatter(
            mask: '######',
            filter: {"#": RegExp(r'\d')},
            type: MaskAutoCompletionType.lazy,
          ),
          LengthLimitingTextInputFormatter(6),
        ];
      default:
        return [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9 \-]')),
          LengthLimitingTextInputFormatter(10),
        ];
    }
  }

  String getPhoneMask() {
    switch (locale.value.countryCode?.toUpperCase()) {
      case 'US':
        return '(###)-###-####';
      case 'IN':
        return '####-######';
      default:
        return '(###)-###-####';
    }
  }

  String get datePlaceholder {
    if (locale.value.countryCode == SupportedCountries.usa.code) {
      return ConstantsFile.mDY;
    } else {
      return ConstantsFile.dmY;
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginType();
  }
}
