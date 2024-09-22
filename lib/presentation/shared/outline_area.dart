import 'package:flutter/material.dart';

class OutlineArea extends StatelessWidget {
  final Widget child;
  final bool backgroundFilled;
  const OutlineArea({super.key, required this.child,this.backgroundFilled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: backgroundFilled == true ? Theme.of(context).colorScheme.surface : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            color: Theme.of(context).colorScheme.onSurface, width: 2),
      ),
      child: child,
    );
  }
}
