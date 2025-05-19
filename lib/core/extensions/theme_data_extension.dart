import 'package:flutter/material.dart';

import 'package:gefest/theme/custom_text_styles.dart';

extension TextThemeTools on ThemeData {
  ThemeData applyCustomTextTheme() {
    return copyWith(extensions: [CustomTextStyles(theme: this)]);
  }
}
