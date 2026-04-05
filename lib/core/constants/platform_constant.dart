import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformConstants {
  static String get androidModel {
    if (kIsWeb) return '';
    try {
      return const String.fromEnvironment(
        'ro.product.models',
        defaultValue: '',
      );
    } catch (e) {
      return '';
    }
  }

  static String get androidBrand {
    if (kIsWeb) return '';
    try {
      return const String.fromEnvironment('ro.product.brand', defaultValue: '');
    } catch (e) {
      return '';
    }
  }

  static String get androidHardware {
    if (kIsWeb) return '';
    try {
      return const String.fromEnvironment('ro.hardware', defaultValue: '');
    } catch (e) {
      return '';
    }
  }

  static String get androidProduct {
    if (kIsWeb) return '';
    try {
      return const String.fromEnvironment('ro.product.name', defaultValue: '');
    } catch (e) {
      return '';
    }
  }

  // iOS-specific constants
  static String get iosSimulatorModel {
    if (kIsWeb) return '';
    try {
      return const String.fromEnvironment(
        'SIMULATOR_MODEL_IDENTIFIER',
        defaultValue: '',
      );
    } catch (e) {
      return '';
    }
  }

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isWeb => kIsWeb;
}
