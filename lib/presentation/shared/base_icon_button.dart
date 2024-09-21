import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseIconButton extends StatelessWidget {
  final Function()? onTap;
  final String icon;
  const BaseIconButton({super.key, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              width: 2, color: Theme.of(context).colorScheme.onSurface)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: SvgPicture.asset(
              icon,
              color: Colors.white,
              width: 32,
              height: 32,
            ),
          ),
        ),
      ),
    );
  }
}
