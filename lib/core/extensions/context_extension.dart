import 'package:flutter/material.dart';

import 'package:gefest/theme/custom_text_styles.dart';

extension CustomTextStylesExtension on BuildContext {
  CustomTextStyles get styles {
    return Theme.of(this).extension<CustomTextStyles>()!;
  }
}