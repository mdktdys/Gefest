import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/presentation/shared/shared.dart';

import '../../theme.dart';

class ThemeButton extends ConsumerWidget {
  final Color color;
  const ThemeButton({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseIconButton(
      color: color,
      icon: ref.watch(themeProvider).isDark()
          ? "assets/icons/dark.svg"
          : "assets/icons/light.svg",
      onTap: () {
        ref.read(themeProvider).toggle();
      },
    );
  }
}
