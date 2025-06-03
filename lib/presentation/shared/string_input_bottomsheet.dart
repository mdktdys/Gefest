import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/theme/spacing.dart';

class StringInputBottomSheet extends ConsumerStatefulWidget {
  final String title;
  final String initial;
  final String submitText;

  const StringInputBottomSheet({
    required this.initial,
    required this.title,
    this.submitText = 'Сохранить',
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StringInputBottomSheetState();
}

class _StringInputBottomSheetState extends ConsumerState<StringInputBottomSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initial);
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Spacing.list,
      children: [
        Text(
          widget.title,
          style: context.styles.ubuntu20,
        ),
        BaseTextField(
          autofocus: true,
          controller: controller
        ),
        BaseElevatedButton(
          text: widget.submitText,
          onTap: () {
            context.pop(controller.text);
          },
        )
      ],
    );
  }
}
