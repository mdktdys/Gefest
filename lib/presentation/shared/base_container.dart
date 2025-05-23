import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;

  const BaseContainer({
    required this.child,

    this.padding = const EdgeInsetsGeometry.all(10),
    this.margin,
    this.color,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}