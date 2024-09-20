import 'package:flutter/material.dart';
import 'package:gefest/theme.dart';

class BaseElevatedButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final double? width;
  final double? height;
  const BaseElevatedButton(
      {super.key, this.onTap, this.text, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onTap != null
          ? Theme.of(context).colorScheme.primary
          : Ca.primaryDisabled,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onHover: (value) {},
        hoverColor: Ca.primaryHovered,
        onTap: onTap,
        child: Container(
            height: height,
            width: width ?? double.infinity,
            padding: const EdgeInsets.all(10),
            child: Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: Fa.smedium,
            )),
      ),
    );
  }
}
