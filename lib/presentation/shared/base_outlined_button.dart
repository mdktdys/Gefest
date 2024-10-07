import 'package:flutter/material.dart';
import 'package:gefest/theme.dart';

class BaseOutlinedButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  const BaseOutlinedButton(
      {super.key, this.onTap, this.text, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(width: 1,color: color??Theme.of(context).colorScheme.onSurface )),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onHover: (value) {},
        hoverColor: Theme.of(context).colorScheme.onSurface,
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
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
