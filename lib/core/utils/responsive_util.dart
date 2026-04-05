import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/platform_constant.dart';
import '../enum/device_type_enum.dart';

class ResponsiveUtil {
  // Singleton instance
  static final ResponsiveUtil _instance = ResponsiveUtil._internal();

  // Private constructor
  ResponsiveUtil._internal();

  // Factory constructor to return the single instance
  factory ResponsiveUtil() => _instance;

  // Instance variables
  double _screenWidth = 1.0;
  double _screenHeight = 1.0;
  double _unitWidth = 1.0;
  double _unitHeight = 1.0;
  DeviceTypeEnum _deviceType = DeviceTypeEnum.mobile;
  bool _isRealDevice = true;

  static void init(BuildContext context) => _instance._initInternal(context);

  // Initialization method
  void _initInternal(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _instance._screenWidth = mediaQuery.size.width;
    _instance._screenHeight = mediaQuery.size.height;

    ScreenUtil.init(
      context,
      designSize: Size(_instance._screenWidth, _instance._screenHeight),
    );

    _instance._unitWidth = _instance._screenWidth / 100;
    _instance._unitHeight = _instance._screenHeight / 100;

    final screenWidthValue = _instance._screenWidth;
    if (screenWidthValue > 1596) {
      _instance._deviceType = DeviceTypeEnum.largeWeb;
    } else if (screenWidthValue > 1366 && screenWidthValue <= 1596) {
      _instance._deviceType = DeviceTypeEnum.mediumWeb;
    } else if (screenWidthValue > 1024 && screenWidthValue <= 1366) {
      _instance._deviceType = DeviceTypeEnum.smallWeb;
    } else if (screenWidthValue > 720 && screenWidthValue <= 1024) {
      _instance._deviceType = DeviceTypeEnum.tablet;
    } else {
      _instance._deviceType = DeviceTypeEnum.mobile;
    }
    _instance._isRealDevice = _checkIfRealDevice();
  }

  // ========== Getters ==========
  static double horizontalPaddingRatio = 5.5;
  static double horizontalPaddingRatioMobile = 3.8;

  static double get screenWidth => _instance._screenWidth;

  static double get screenHeight => _instance._screenHeight;

  static double get unitWidth => _instance._unitWidth;

  static double get unitHeight => _instance._unitHeight;

  static DeviceTypeEnum get deviceType => _instance._deviceType;

  static bool get isRealDevice => _instance._isRealDevice;

  // ========== Device Type Checks ==========
  static bool get isMobile => _instance._deviceType == DeviceTypeEnum.mobile;

  static bool get isTablet => _instance._deviceType == DeviceTypeEnum.tablet;

  static bool get isWeb =>
      _instance._deviceType.index > DeviceTypeEnum.tablet.index;

  static bool get isSmallWeb =>
      _instance._deviceType == DeviceTypeEnum.smallWeb;

  static bool get isMediumWeb =>
      _instance._deviceType == DeviceTypeEnum.mediumWeb;

  static bool get isLargeWeb =>
      _instance._deviceType == DeviceTypeEnum.largeWeb;

  static bool get isAndroid => PlatformConstants.isAndroid;

  static bool get isIOS => PlatformConstants.isIOS;

  static bool get isMobileLarger =>
      _instance._deviceType.index > DeviceTypeEnum.mobile.index;

  static bool get isTabletLarger =>
      _instance._deviceType.index > DeviceTypeEnum.tablet.index;

  static bool get isSmallWebLarger =>
      _instance._deviceType.index > DeviceTypeEnum.smallWeb.index;

  static bool get isMediumWebLarger =>
      _instance._deviceType.index > DeviceTypeEnum.mediumWeb.index;

  static bool get isLargeWebLarger =>
      _instance._deviceType.index > DeviceTypeEnum.largeWeb.index;

  static bool get isMobileOrTablet =>
      _instance._deviceType.index <= DeviceTypeEnum.tablet.index;

  static bool get isTabletOrLarger =>
      _instance._deviceType.index >= DeviceTypeEnum.tablet.index;

  static bool get isSmallWebOrLarger =>
      _instance._deviceType.index >= DeviceTypeEnum.smallWeb.index;

  static bool get isMediumWebOrLarger =>
      _instance._deviceType.index >= DeviceTypeEnum.mediumWeb.index;

  // ========== Utility Methods ==========
  static double width(double percent) => _instance._unitWidth * percent;

  static double height(double percent) => _instance._unitHeight * percent;

  static int get deviceSizeCode => _instance._deviceType.webSizeType;

  // ========== Private Methods ==========
  static bool _checkIfRealDevice() {
    if (PlatformConstants.isWeb) {
      return true;
    }
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        if (Platform.isAndroid) {
          return !_isAndroidEmulator();
        } else if (Platform.isIOS) {
          return !_isIosSimulator();
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static bool _isAndroidEmulator() {
    return PlatformConstants.androidModel.contains('sdk') ||
        PlatformConstants.androidModel.contains('emulator') ||
        PlatformConstants.androidModel.contains('Android SDK') ||
        PlatformConstants.androidBrand.contains('generic') ||
        PlatformConstants.androidHardware.contains('goldfish') ||
        PlatformConstants.androidProduct.contains('sdk') ||
        PlatformConstants.androidProduct.contains('emulator') ||
        PlatformConstants.androidProduct.contains('simulator');
  }

  static bool _isIosSimulator() {
    return PlatformConstants.iosSimulatorModel.isNotEmpty;
  }
}
