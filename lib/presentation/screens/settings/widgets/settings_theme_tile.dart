import 'package:flutter/material.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/presentation/shared/providers/theme_provider.dart';

class ThemeTile extends ConsumerWidget {
  final FlexSchemeData scheme;
  final FlexScheme flexScheme;
  final bool isDark;

  const ThemeTile({
    required this.flexScheme,
    required this.scheme,
    required this.isDark,
    super.key,
  });

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final theme = isDark ? scheme.dark : scheme.light;
    final bool isCurrent = ref.watch(lightThemeProvider).scheme == flexScheme;
    return Bounceable(
      onTap: () {
        ref.read(lightThemeProvider).setScheme(flexScheme);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
          border: isCurrent ? Border.all(color: Theme.of(context).colorScheme.inversePrimary, width: 4) :  null, )
        ,
        child: ClipRRect(
          borderRadius: BorderRadius.circular( isCurrent ? 10 : 6),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Column(
              children: [
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: Container(color: theme.primary),
                    ),
                    Expanded(
                      child: Container(
                        color: theme.tertiary,
                      ),
                    ),
                  ],),
                ),
                Expanded(
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        color: theme.primaryContainer,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: theme.secondary,
                      ),
                    ),
                  ],),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
