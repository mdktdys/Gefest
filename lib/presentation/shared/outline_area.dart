import 'package:flutter/material.dart';

class OutlineArea extends StatelessWidget {
  final Widget child;
  const OutlineArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            color: Theme.of(context).colorScheme.onSurface, width: 2),
      ),
      child: child,
    );
  }
}
