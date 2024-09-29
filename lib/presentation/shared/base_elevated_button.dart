import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/theme.dart';

class BaseElevatedButton extends ConsumerStatefulWidget {
  final String? text;
  final Function()? onTap;
  final double? width;
  final double? height;
  const BaseElevatedButton(
      {super.key, this.onTap, this.text, this.width, this.height});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BaseElevatedButtonState();
}

class _BaseElevatedButtonState extends ConsumerState<BaseElevatedButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.onTap != null
          ? Theme.of(context).colorScheme.primary
          : Ca.primaryDisabled,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onHover: (value) {},
        hoverColor: Ca.primaryHovered,
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
                context: context);
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
