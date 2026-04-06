import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import '../enum/toast_duration.dart';
import 'app_text_styles.dart';
import 'assets_icons.dart';
import 'color_file.dart';

// class ToastUtil {
//   static Map<String, ToastificationItem> items = {};
//
//   static show({
//     required String? message,
//     ToastificationType type = ToastificationType.error,
//     ToastDuration autoCloseDuration = ToastDuration.sticky,
//   }) {
//     if (message == null || message.isEmpty) return;
//     if (items.isNotEmpty && items.entries.last.value.isRunning) {
//       if (items.entries.last.key == message) {
//         toastification.dismiss(items.entries.last.value);
//         items.remove(items.entries.last.key);
//       }
//     }
//     Color textColor = ColorFile.errorColor;
//     String asset = AssetsIcons.icError;
//     switch (type) {
//       case ToastificationType.error:
//         textColor = ColorFile.errorColor;
//         asset = AssetsIcons.icError;
//         break;
//       case ToastificationType.warning:
//         // backgroundColor = AppColors.warning;
//         asset = AssetsIcons.icWarning;
//         break;
//       case ToastificationType.info:
//         // backgroundColor = AppColors.info;
//         // asset = AssetsIcons.icInfo2;
//         break;
//       case ToastificationType.success:
//         textColor = ColorFile.successColor;
//         asset = AssetsIcons.icSuccess;
//         break;
//     }
//
//     var item = toastification.show(
//       autoCloseDuration: Duration(seconds: autoCloseDuration.seconds),
//       animationDuration: const Duration(milliseconds: 300),
//       description: CustomTextView(
//         message,
//         style: AppTextStyles.mediumBlack14.copyWith(color: textColor),
//       ),
//       type: type,
//       showProgressBar: false,
//       backgroundColor: ColorFile.whiteColor,
//       borderSide: BorderSide(color: textColor, width: 2.0),
//       icon: SvgPicture.asset(asset),
//       callbacks: ToastificationCallbacks(
//         onAutoCompleteCompleted: (value) {
//           var key = items.entries
//               .firstWhere((element) => element.value == value)
//               .key;
//           items.remove(key);
//         },
//         onCloseButtonTap: (value) {
//           toastification.dismiss(value);
//           var key = items.entries
//               .firstWhere((element) => element.value == value)
//               .key;
//           items.remove(key);
//         },
//       ),
//     );
//     items.putIfAbsent(message, () => item);
//   }
//
//   static dismissAll() {
//     toastification.dismissAll();
//   }
// }
import 'package:flutter/material.dart';

// Custom enum for toast positions
enum ToastPosition {
  topLeft,
  topRight,
  topCenter,
  bottomLeft,
  bottomRight,
  bottomCenter,
}

// Toast configuration class for customization
class ToastConfig {
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double borderWidth;
  final double borderRadius;
  final double? iconSize;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool showProgressBar;
  final Duration animationDuration;
  final ToastPosition position;
  final bool shadowEnabled;

  const ToastConfig({
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.borderWidth = 2.0,
    this.borderRadius = 12.0,
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showProgressBar = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.position = ToastPosition.topCenter,
    this.shadowEnabled = true,
  });

  // Predefined themes
  static const ToastConfig compact = ToastConfig(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: 8,
    iconSize: 20,
    borderWidth: 1.5,
  );

  static const ToastConfig large = ToastConfig(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    borderRadius: 16,
    iconSize: 32,
    borderWidth: 2.5,
    shadowEnabled: true,
  );

  static const ToastConfig minimal = ToastConfig(
    showProgressBar: false,
    borderWidth: 0,
    shadowEnabled: false,
    borderRadius: 0,
  );
}

enum ToastSize {
  small,
  medium,
  big,
}

class ToastUtil {
  static final Map<String, ToastificationItem> _activeToasts = {};

  // Show toast with full customization
  static ToastificationItem show({
    required String? message,
    ToastificationType type = ToastificationType.error,
    ToastDuration autoCloseDuration = ToastDuration.short,
    ToastConfig? config,
    String? title,
    Widget? customIcon,
    VoidCallback? onTap,
  }) {
    if (message == null || message.isEmpty) {
      throw ArgumentError('Message cannot be null or empty');
    }

    // Remove duplicate toast if exists
    _removeDuplicateToast(message);

    final toastConfig = config ?? const ToastConfig();
    final colors = _getColorsForType(type, toastConfig);

    final item = toastification.show(
      title: title != null
          ? Text(
              title,
              style: AppTextStyles.semiBoldBlack16.copyWith(
                color: colors.textColor,
              ),
            )
          : null,
      description: Text(
        message,
        style: AppTextStyles.mediumBlack14.copyWith(
          color: colors.textColor,
        ),
      ),
      icon: customIcon ??
          (type != ToastificationType.info
              ? SvgPicture.asset(
                  _getIconAsset(type),
                  height: toastConfig.iconSize,
                  width: toastConfig.iconSize,
                )
              : null),
      primaryColor: colors.borderColor,
      backgroundColor: colors.backgroundColor,
      foregroundColor: colors.textColor,
      padding: toastConfig.padding,
      margin: toastConfig.margin,
      borderRadius: BorderRadius.circular(toastConfig.borderRadius),
      borderSide: toastConfig.borderWidth > 0
          ? BorderSide(
              color: colors.borderColor,
              width: toastConfig.borderWidth,
            )
          : BorderSide.none,
      boxShadow: toastConfig.shadowEnabled
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
          : null,
      type: type,
      autoCloseDuration: autoCloseDuration == ToastDuration.sticky
          ? null
          : Duration(seconds: autoCloseDuration.seconds),
      animationDuration: toastConfig.animationDuration,
      showProgressBar: toastConfig.showProgressBar,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      alignment: _getAlignment(toastConfig.position),
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: (item) {
          _removeToastByItem(item);
          if (onTap != null) onTap();
        },
        onTap: (item) {
          if (onTap != null) onTap();
          toastification.dismiss(item);
          _removeToastByItem(item);
        },
      ),
    );

    _activeToasts[message] = item;
    return item;
  }

  // Success toast
  static void success({
    required String message,
    ToastDuration duration = ToastDuration.short,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    show(
      message: message,
      type: ToastificationType.success,
      autoCloseDuration: duration,
      config: config,
      title: title,
      onTap: onTap,
    );
  }

  // Error toast
  static void error({
    required String message,
    ToastDuration duration = ToastDuration.medium,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    show(
      message: message,
      type: ToastificationType.error,
      autoCloseDuration: duration,
      config: config,
      title: title,
      onTap: onTap,
    );
  }

  // Warning toast
  static void warning({
    required String message,
    ToastDuration duration = ToastDuration.medium,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    show(
      message: message,
      type: ToastificationType.warning,
      autoCloseDuration: duration,
      config: config,
      title: title,
      onTap: onTap,
    );
  }

  // Info toast
  static void info({
    required String message,
    ToastDuration duration = ToastDuration.medium,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    show(
      message: message,
      type: ToastificationType.info,
      autoCloseDuration: duration,
      config: config,
      title: title,
      onTap: onTap,
    );
  }

  // Success toast with size and position
  static void successWithSize({
    required String message,
    ToastSize size = ToastSize.medium,
    ToastPosition position = ToastPosition.topCenter,
    ToastDuration duration = ToastDuration.short,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    // Customize config based on size and position
    ToastConfig? sizeConfig;

    switch (size) {
      case ToastSize.small:
        sizeConfig = ToastConfig.compact;
        break;
      case ToastSize.medium:
        sizeConfig = const ToastConfig();
        break;
      case ToastSize.big:
        sizeConfig = ToastConfig.large;
        break;
    }

    // Override position if provided
    if (position != ToastPosition.topCenter) {
      sizeConfig = sizeConfig.copyWith(position: position);
    }

    show(
      message: message,
      type: ToastificationType.success,
      autoCloseDuration: duration,
      config: sizeConfig,
      title: title,
      onTap: onTap,
    );
  }

// Info toast with size and position
  static void infoWithSize({
    required String message,
    ToastSize size = ToastSize.medium,
    ToastPosition position = ToastPosition.topCenter,
    ToastDuration duration = ToastDuration.short,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    ToastConfig? sizeConfig;

    switch (size) {
      case ToastSize.small:
        sizeConfig = ToastConfig.compact;
        break;
      case ToastSize.medium:
        sizeConfig = const ToastConfig();
        break;
      case ToastSize.big:
        sizeConfig = ToastConfig.large;
        break;
    }

    // Override position if provided
    if (position != ToastPosition.topCenter) {
      sizeConfig = sizeConfig.copyWith(position: position);
    }

    show(
      message: message,
      type: ToastificationType.info,
      autoCloseDuration: duration,
      config: sizeConfig,
      title: title,
      onTap: onTap,
    );
  }

// Error toast with size and position
  static void errorWithSize({
    required String message,
    ToastSize size = ToastSize.medium,
    ToastPosition position = ToastPosition.topCenter,
    ToastDuration duration = ToastDuration.medium,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    ToastConfig? sizeConfig;

    switch (size) {
      case ToastSize.small:
        sizeConfig = ToastConfig.compact;
        break;
      case ToastSize.medium:
        sizeConfig = const ToastConfig();
        break;
      case ToastSize.big:
        sizeConfig = ToastConfig.large;
        break;
    }

    // Override position if provided
    if (position != ToastPosition.topCenter) {
      sizeConfig = sizeConfig.copyWith(position: position);
    }

    show(
      message: message,
      type: ToastificationType.error,
      autoCloseDuration: duration,
      config: sizeConfig,
      title: title,
      onTap: onTap,
    );
  }

// Warning toast with size and position
  static void warningWithSize({
    required String message,
    ToastSize size = ToastSize.medium,
    ToastPosition position = ToastPosition.topCenter,
    ToastDuration duration = ToastDuration.medium,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    ToastConfig? sizeConfig;

    switch (size) {
      case ToastSize.small:
        sizeConfig = ToastConfig.compact;
        break;
      case ToastSize.medium:
        sizeConfig = const ToastConfig();
        break;
      case ToastSize.big:
        sizeConfig = ToastConfig.large;
        break;
    }

    // Override position if provided
    if (position != ToastPosition.topCenter) {
      sizeConfig = sizeConfig.copyWith(position: position);
    }

    show(
      message: message,
      type: ToastificationType.warning,
      autoCloseDuration: duration,
      config: sizeConfig,
      title: title,
      onTap: onTap,
    );
  }

// Generic method for any toast type with size and position
  static void showWithSizeAndPosition({
    required String message,
    required ToastificationType type,
    ToastSize size = ToastSize.medium,
    ToastPosition position = ToastPosition.topCenter,
    ToastDuration duration = ToastDuration.medium,
    ToastConfig? config,
    String? title,
    VoidCallback? onTap,
  }) {
    ToastConfig? sizeConfig;

    switch (size) {
      case ToastSize.small:
        sizeConfig = ToastConfig.compact;
        break;
      case ToastSize.medium:
        sizeConfig = const ToastConfig();
        break;
      case ToastSize.big:
        sizeConfig = ToastConfig.large;
        break;
    }

    // Override position if provided
    if (position != ToastPosition.topCenter) {
      sizeConfig = sizeConfig.copyWith(position: position);
    }

    show(
      message: message,
      type: type,
      autoCloseDuration: duration,
      config: sizeConfig,
      title: title,
      onTap: onTap,
    );
  }

  // Loading toast (doesn't auto-dismiss)
  static ToastificationItem loading({
    required String message,
    ToastConfig? config,
    String? title,
  }) {
    return show(
      message: message,
      type: ToastificationType.info,
      autoCloseDuration: ToastDuration.sticky,
      config: config ?? const ToastConfig(),
      title: title,
      customIcon: const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }

  // Dismiss specific toast
  static void dismiss(String message) {
    final toast = _activeToasts[message];
    if (toast != null) {
      toastification.dismiss(toast);
      _activeToasts.remove(message);
    }
  }

  // Dismiss all toasts
  static void dismissAll() {
    toastification.dismissAll();
    _activeToasts.clear();
  }

  // Dismiss latest toast
  static void dismissLatest() {
    if (_activeToasts.isNotEmpty) {
      final lastEntry = _activeToasts.entries.last;
      toastification.dismiss(lastEntry.value);
      _activeToasts.remove(lastEntry.key);
    }
  }

  // Check if toast exists
  static bool isShowing(String message) {
    return _activeToasts.containsKey(message);
  }

  // Get active toast count
  static int get activeCount => _activeToasts.length;

  // Get all active toast messages
  static List<String> get activeMessages => _activeToasts.keys.toList();

  // Private helper methods
  static void _removeDuplicateToast(String message) {
    if (_activeToasts.containsKey(message)) {
      toastification.dismiss(_activeToasts[message]!);
      _activeToasts.remove(message);
    }
  }

  static void _removeToastByItem(ToastificationItem item) {
    final key = _activeToasts.entries
        .firstWhere(
          (entry) => entry.value == item,
        )
        .key;
    if (key.isNotEmpty) {
      _activeToasts.remove(key);
    }
  }

  static _ToastColors _getColorsForType(
      ToastificationType type, ToastConfig config) {
    switch (type) {
      case ToastificationType.success:
        return _ToastColors(
          backgroundColor: config.backgroundColor ?? ColorFile.whiteColor,
          borderColor: config.borderColor ?? ColorFile.successColor,
          textColor: config.textColor ?? ColorFile.successColor,
        );
      case ToastificationType.error:
        return _ToastColors(
          backgroundColor: config.backgroundColor ?? ColorFile.whiteColor,
          borderColor: config.borderColor ?? ColorFile.errorColor,
          textColor: config.textColor ?? ColorFile.errorColor,
        );
      case ToastificationType.warning:
        return _ToastColors(
          backgroundColor: config.backgroundColor ?? ColorFile.whiteColor,
          borderColor: config.borderColor ?? ColorFile.warningColor,
          textColor: config.textColor ?? ColorFile.warningColor,
        );
      case ToastificationType.info:
        return _ToastColors(
          backgroundColor: config.backgroundColor ?? ColorFile.whiteColor,
          borderColor: config.borderColor ?? ColorFile.infoColor,
          textColor: config.textColor ?? ColorFile.infoColor,
        );
    }
  }

  static String _getIconAsset(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return AssetsIcons.icSuccess;
      case ToastificationType.error:
        return AssetsIcons.icError;
      case ToastificationType.warning:
        return AssetsIcons.icWarning;
      case ToastificationType.info:
        return AssetsIcons.icInfo;
    }
  }

  static AlignmentGeometry _getAlignment(ToastPosition position) {
    switch (position) {
      case ToastPosition.topLeft:
        return Alignment.topLeft;
      case ToastPosition.topRight:
        return Alignment.topRight;
      case ToastPosition.topCenter:
        return Alignment.topCenter;
      case ToastPosition.bottomLeft:
        return Alignment.bottomLeft;
      case ToastPosition.bottomRight:
        return Alignment.bottomRight;
      case ToastPosition.bottomCenter:
        return Alignment.bottomCenter;
    }
  }
}

// Helper class for colors
class _ToastColors {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  _ToastColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });
}

// Extension for ToastConfig copying
extension ToastConfigExtension on ToastConfig {
  ToastConfig copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    double? borderWidth,
    double? borderRadius,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool? showProgressBar,
    Duration? animationDuration,
    ToastPosition? position,
    bool? shadowEnabled,
  }) {
    return ToastConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      iconSize: iconSize ?? this.iconSize,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      animationDuration: animationDuration ?? this.animationDuration,
      position: position ?? this.position,
      shadowEnabled: shadowEnabled ?? this.shadowEnabled,
    );
  }
}
