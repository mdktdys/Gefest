import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/configs/constants.dart';
import 'package:gefest/core/basics.dart';
import 'package:gefest/presentation/screens/settings/widgets/settings_header.dart';
import 'package:gefest/presentation/screens/settings/widgets/settings_theme_switch_block.dart';
import 'package:gefest/theme/spacing.dart';

class SettingsScreenParameters extends QueryParameters {
  SettingsScreenParameters(super.context);

  // int get teacherId => int.parse(getParams['id']!);
}

class SettingsScreen extends ScreenPageWidget<SettingsScreenParameters> {
  SettingsScreen(BuildContext context) : super(params: SettingsScreenParameters(context));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Spacing.listHorizontalPadding),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Constants.maxWidthDesktop),
            child: Column(
              spacing: Spacing.list,
              children: [
                const SizedBox.shrink(),
                const SettingsHeader(),
                // const SettingsLogoBlock(),
                const ThemeSwitchBlock(),
                Text(
                  Constants.version,
                  textAlign: TextAlign.center,
                  // style: context.styles.monospace12
                ),
                SizedBox(height: Constants.bottomSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
