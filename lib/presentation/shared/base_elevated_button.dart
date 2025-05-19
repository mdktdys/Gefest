import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/theme.dart';

class BaseElevatedButton extends ConsumerStatefulWidget {
  final String? text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final bool isPrimary;

  const BaseElevatedButton({
    this.onTap,
    this.text,
    this.width,
    this.height,
    this.isPrimary = false
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseElevatedButtonState();
}

class _BaseElevatedButtonState extends ConsumerState<BaseElevatedButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.isPrimary
        ? Theme.of(context).colorScheme.primaryContainer
        : Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onHover: (value) {},
        onTap: () async {
          setState(() {
            loading = true;
          });
          try {
            await widget.onTap?.call();
          } catch (e) {
            ref.watch(messagesProvider).showMessage(
              type: MesTypes.error,
              header: "Ошибка",
              body: e.toString(),
              context: context
            );
          }
          setState(() {
            loading = false;
          });
        },
        child: Container(
            height: widget.height,
            width: widget.width ?? double.infinity,
            padding: const EdgeInsets.all(10),
            child: loading
                ? const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    widget.text ?? "",
                    textAlign: TextAlign.center,
                    style: Fa.smedium,
                  )),
      ),
    );
  }
}
