
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/models/cabinet.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';

class CabinetListTile extends StatelessWidget {
  final Cabinet cabinet;

  const CabinetListTile(this.cabinet);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            spacing: 20,
            children: [
              Text(
                cabinet.name,
                style: context.styles.ubuntu18
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseElevatedButton(
                text: 'Изменить',
                onTap: () {
                  context.go(Uri(path:'/cabinet',queryParameters: {'id': cabinet.id.toString()}).toString());
                },
              )
            ],
          )
        ],
      )
    );
  }
}