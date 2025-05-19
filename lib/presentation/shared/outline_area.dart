import 'package:flutter/material.dart';

class OutlineArea extends StatelessWidget {
  final Widget child;
  final bool backgroundFilled;
  final List<BoxShadow>? boxShadow;
  const OutlineArea({super.key, required this.child,this.backgroundFilled = false, this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        color: backgroundFilled == true ? Theme.of(context).colorScheme.surface : Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            color: Theme.of(context).colorScheme.surfaceContainer, width: 2),
      ),
      child: child,
    );
  }
}
