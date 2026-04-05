// ==================== EXTENSION FOR GLOBAL ACCESS ====================

import 'package:flutter/material.dart';
import 'package:soul_sync/core/utils/app_text_styles.dart';

extension TextStyleExtension on BuildContext {
  AppTextStyleHelper get textStyles => AppTextStyleHelper(this);

  TextStyle get displayLarge => AppTextStyles.displayLarge(this);
  TextStyle get displayMedium => AppTextStyles.displayMedium(this);
  TextStyle get displaySmall => AppTextStyles.displaySmall(this);
  TextStyle get headlineLarge => AppTextStyles.headlineLarge(this);
  TextStyle get headlineMedium => AppTextStyles.headlineMedium(this);
  TextStyle get headlineSmall => AppTextStyles.headlineSmall(this);
  TextStyle get titleLarge => AppTextStyles.titleLarge(this);
  TextStyle get titleMedium => AppTextStyles.titleMedium(this);
  TextStyle get titleSmall => AppTextStyles.titleSmall(this);
  TextStyle get bodyLarge => AppTextStyles.bodyLarge(this);
  TextStyle get bodyMedium => AppTextStyles.bodyMedium(this);
  TextStyle get bodySmall => AppTextStyles.bodySmall(this);
  TextStyle get labelLarge => AppTextStyles.labelLarge(this);
  TextStyle get labelMedium => AppTextStyles.labelMedium(this);
  TextStyle get labelSmall => AppTextStyles.labelSmall(this);
}