import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class BaseIconButton extends StatelessWidget {
  final Function()? onTap;
  final String icon;
  final Color? fillColor;
  final Color? iconColor;

  const BaseIconButton({
    required this.icon,
    this.iconColor,
    this.fillColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: fillColor ?? Theme.of(context).colorScheme.surfaceContainer,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(width: 2, color: Theme.of(context).colorScheme.surfaceContainerHighest)
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: SvgPicture.asset(
              icon,
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(iconColor ?? Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
