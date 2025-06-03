
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';

class TeacherListTile extends StatelessWidget {
  final Teacher teacher;
  const TeacherListTile(
    this.teacher
  );

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
              CircleAvatar(
                maxRadius: 32,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                foregroundImage: NetworkImage(teacher.image ?? ''),
              ),
              Text(
                teacher.name ?? '',
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
                  context.go(Uri(path:'/teacher',queryParameters: {'id': teacher.id.toString()}).toString());
                },
              )
            ],
          )
        ],
      )
    );
  }
}