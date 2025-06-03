import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_container.dart';
import 'package:gefest/presentation/shared/shared.dart';
import 'package:gefest/theme/spacing.dart';

class YesNoDialog extends ConsumerWidget {
  final String title;
  final String body;

  const YesNoDialog({
    required this.title,
    required this.body,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: BaseContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: Spacing.list,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: context.styles.ubuntu20,
              ),
              Text(
                body,
                textAlign: TextAlign.left,
                style: context.styles.ubuntu14,
              ),
              Row(
                spacing: Spacing.list,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: BaseOutlinedButton(
                      text: 'Отмена',
                      onTap: () {
                        context.pop(false);
                      },
                    ),
                  ),
                  Expanded(
                    child: BaseElevatedButton(
                      text: 'Удалить',
                      onTap: () {
                        context.pop(true);
                      },
                    ),
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
