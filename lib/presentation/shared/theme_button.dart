import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/presentation/shared/providers/theme_provider.dart';
import 'package:gefest/presentation/shared/shared.dart';


class ThemeButton extends ConsumerWidget {
  final Color color;
  const ThemeButton({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseIconButton(
      icon:ref.read(lightThemeProvider).themeMode == ThemeMode.dark
          ? "assets/icons/dark.svg"
          : "assets/icons/light.svg",
      onTap: () {
        int themeIndex = ThemeMode.values.indexOf(ref.read(lightThemeProvider).themeMode);
        themeIndex++;

        if (themeIndex > ThemeMode.values.length) {
          themeIndex = 1;
        }

        ref.read(lightThemeProvider).setThemeMode(themeIndex + 1);
      },
    );
  }
}
