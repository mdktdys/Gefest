import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/theme/spacing.dart';

class ParaPanel extends ConsumerStatefulWidget {
  final String title;
  final List<Widget> children;

  const ParaPanel({
    required this.title,
    required this.children,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ParaPanelState();
}

class _ParaPanelState extends ConsumerState<ParaPanel> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 670,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
        color: Theme.of(context).colorScheme.surface
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant)
                    )
                  ),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: context.styles.ubuntu20,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: Spacing.list,
                    children: widget.children
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
