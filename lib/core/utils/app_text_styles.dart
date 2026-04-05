import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_sync/core/constants/constants_file.dart';
import 'color_file.dart';

class AppTextStyleHelper {
  final BuildContext context;

  const AppTextStyleHelper(this.context);

  // Display styles
  TextStyle get displayLarge => AppTextStyles.displayLarge(context);

  TextStyle get displayMedium => AppTextStyles.displayMedium(context);

  TextStyle get displaySmall => AppTextStyles.displaySmall(context);

  // Headline styles
  TextStyle get headlineLarge => AppTextStyles.headlineLarge(context);

  TextStyle get headlineMedium => AppTextStyles.headlineMedium(context);

  TextStyle get headlineSmall => AppTextStyles.headlineSmall(context);

  // Title styles
  TextStyle get titleLarge => AppTextStyles.titleLarge(context);

  TextStyle get titleMedium => AppTextStyles.titleMedium(context);

  TextStyle get titleSmall => AppTextStyles.titleSmall(context);

  // Body styles
  TextStyle get bodyLarge => AppTextStyles.bodyLarge(context);

  TextStyle get bodyMedium => AppTextStyles.bodyMedium(context);

  TextStyle get bodySmall => AppTextStyles.bodySmall(context);

  // Label styles
  TextStyle get labelLarge => AppTextStyles.labelLarge(context);

  TextStyle get labelMedium => AppTextStyles.labelMedium(context);

  TextStyle get labelSmall => AppTextStyles.labelSmall(context);

  // Methods with color override
  TextStyle displayLargeWithColor(Color color) =>
      AppTextStyles.displayLarge(context, color: color);

  TextStyle displayMediumWithColor(Color color) =>
      AppTextStyles.displayMedium(context, color: color);

  TextStyle titleLargeWithColor(Color color) =>
      AppTextStyles.titleLarge(context, color: color);

  TextStyle bodyMediumWithColor(Color color) =>
      AppTextStyles.bodyMedium(context, color: color);
}

class AppTextStyles {
  // ==================== BASE STYLES ====================

  static TextStyle _getStyle({
    required TextStyle? baseStyle,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? fontFamily,
    List<Shadow>? shadows,
  }) {
    return (baseStyle ?? const TextStyle()).copyWith(
      color: color,
      fontSize: fontSize?.sp,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontFamily: fontFamily,
      shadows: shadows,
    );
  }

  // ==================== DISPLAY STYLES ====================

  /// Display Large - Largest text on screen
  static TextStyle displayLarge(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.displayLarge,
      color: color,
    );
  }

  /// Display Medium
  static TextStyle displayMedium(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.displayMedium,
      color: color,
    );
  }

  /// Display Small
  static TextStyle displaySmall(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.displaySmall,
      color: color,
    );
  }

  // ==================== HEADLINE STYLES ====================

  /// Headline Large
  static TextStyle headlineLarge(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.headlineLarge,
      color: color,
    );
  }

  /// Headline Medium
  static TextStyle headlineMedium(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.headlineMedium,
      color: color,
    );
  }

  /// Headline Small
  static TextStyle headlineSmall(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.headlineSmall,
      color: color,
    );
  }

  // ==================== TITLE STYLES ====================

  /// Title Large
  static TextStyle titleLarge(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.titleLarge,
      color: color,
    );
  }

  /// Title Medium
  static TextStyle titleMedium(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.titleMedium,
      color: color,
    );
  }

  /// Title Small
  static TextStyle titleSmall(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.titleSmall,
      color: color,
    );
  }

  // ==================== BODY STYLES ====================

  /// Body Large - For longer passages of text
  static TextStyle bodyLarge(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.bodyLarge,
      color: color,
    );
  }

  /// Body Medium - Default text style for Material
  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.bodyMedium,
      color: color,
    );
  }

  /// Body Small
  static TextStyle bodySmall(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.bodySmall,
      color: color,
    );
  }

  // ==================== LABEL STYLES ====================

  /// Label Large - Used for buttons
  static TextStyle labelLarge(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.labelLarge,
      color: color,
    );
  }

  /// Label Medium
  static TextStyle labelMedium(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.labelMedium,
      color: color,
    );
  }

  /// Label Small
  static TextStyle labelSmall(BuildContext context, {Color? color}) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.labelSmall,
      color: color,
    );
  }

  // ==================== CUSTOM UTILITY METHODS ====================

  /// Create custom text style with specific configuration
  static TextStyle custom({
    required BuildContext context,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    String? fontFamily,
    double? letterSpacing,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    double? height,
  }) {
    return _getStyle(
      baseStyle: Theme.of(context).textTheme.bodyMedium,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontStyle: fontStyle,
      height: height,
    );
  }

  // Bold Font Styles (Black Color)
  static final TextStyle boldBlack12 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 12.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack13 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 13.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack14 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 14.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack15 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 15.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack16 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 16.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack17 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 17.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack18 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 18.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack20 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 20.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack22 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 22.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack23 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 23.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack24 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 24.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack26 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 26.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack28 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 28.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack30 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 30.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack31 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 31.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack32 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 32.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack36 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 36.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack40 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 40.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack46 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 46.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle boldBlack52 = TextStyle(
    fontFamily: ConstantsFile.boldFont,
    fontSize: 52.sp,
    color: ColorFile.blackColor,
    fontWeight: FontWeight.w700,
  );

  // Regular Font Styles
  static final TextStyle regularBlack10 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 10.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack12 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 12.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack13 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 13.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack14 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 14.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack16 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 16.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack18 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 18.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack20 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 20.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack21 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 21.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack22 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 22.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack24 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 24.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack26 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 26.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack28 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 28.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack32 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 32.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularBlack36 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 36.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle regularWhite14 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 14.sp,
    color: ColorFile.whiteColor,
  );
  static final TextStyle regularTheme14 = TextStyle(
    fontFamily: ConstantsFile.regularFont,
    fontSize: 14.sp,
    color: ColorFile.webThemeColor,
  );

  // Semi-Bold Font Styles
  static final TextStyle semiBoldBlack12 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 12.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack13 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 13.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack14 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 14.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack16 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 16.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack18 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 18.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack20 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 20.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack21 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 21.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack22 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 22.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack24 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 24.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack26 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 26.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack28 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 28.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack30 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 30.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack32 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 32.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle semiBoldBlack36 = TextStyle(
    fontFamily: ConstantsFile.semiBoldFont,
    fontSize: 36.sp,
    color: ColorFile.blackColor,
  );

  // Medium Font Styles
  static final TextStyle mediumBlack11 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 11.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack12 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 12.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack13 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 13.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack14 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 14.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack16 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 16.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack18 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 18.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack20 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 20.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack22 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 22.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack24 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 24.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack26 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 26.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack28 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 28.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack32 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 32.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumBlack36 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 36.sp,
    color: ColorFile.blackColor,
  );
  static final TextStyle mediumWhite14 = TextStyle(
    fontFamily: ConstantsFile.mediumFont,
    fontSize: 14.sp,
    color: ColorFile.whiteColor,
  );
}
