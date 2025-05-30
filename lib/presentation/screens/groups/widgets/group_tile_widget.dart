import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/data/providers/department_provider.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/core/api/models/groups.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';

class GroupTileWidget extends ConsumerWidget {
  final Group group;

  const GroupTileWidget({
    required this.group,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Department? department = ref.watch(departmentProvider(group.department));
    
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
              CircleAvatar(
                maxRadius: 32,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                foregroundImage: NetworkImage(group.image ?? ''),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: context.styles.ubuntu18
                  ),
                  Text(
                    department?.name ?? '-',
                    style: context.styles.ubuntu14.copyWith(color: Theme.of(context).colorScheme.outline)
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseElevatedButton(
                text: 'Изменить',
                onTap: () {
                  context.go(Uri(path: '/group',queryParameters: {'id': group.id.toString()}).toString());
                },
              )
            ],
          )
        ],
      )
    );
  }
}