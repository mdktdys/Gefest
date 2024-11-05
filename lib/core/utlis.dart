import 'dart:math';

import 'package:flutter/material.dart';

Color getColorForText(String text) {
  final hash = text.hashCode;
  final random = Random(hash);

  int red = random.nextInt(256);
  int green = random.nextInt(256);
  int blue = random.nextInt(256);

  int maxValue = max(red, max(green, blue));
  if (maxValue == red) {
    red = 230;
  } else if (maxValue == green) {
    green = 230;
  } else {
    blue = 230;
  }

  return Color.fromARGB(255, red, green, blue);
}
