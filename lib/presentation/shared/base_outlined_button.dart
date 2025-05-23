import 'package:flutter/material.dart';

import 'package:gefest/core/extensions/context_extension.dart';

class BaseOutlinedButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  
  const BaseOutlinedButton({
    this.onTap,
    this.text,
    this.width,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 1,color: color??Theme.of(context).colorScheme.secondary
        )
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onHover: (value) {},
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.all(10),
            child: Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: context.styles.ubuntu14,
          )
        ),
      ),
    );
  }
}
