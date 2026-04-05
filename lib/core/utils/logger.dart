import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerUtil {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    level: kReleaseMode ? Level.off : Level.debug,
  );

  static Logger get logger => _logger;

  printLog(String title, String log) {
    LoggerUtil.logger.d('("--------$title-------------$log');
  }
}
