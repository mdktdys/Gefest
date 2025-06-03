import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/data/data.dart' hide groupProvider;
import 'package:gefest/core/api/data/repository/data_repository.dart';
import 'package:gefest/core/api/models/course.dart';
import 'package:gefest/core/api/models/groups.dart';
import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/presentation/screens/group/providers/group_provider.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';
import 'package:gefest/presentation/shared/panel_widget.dart';
import 'package:gefest/presentation/shared/shared.dart';

class AddLinkPanel extends ConsumerStatefulWidget {
  final Group group;

  const AddLinkPanel({
    required this.group,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddLinkPanelState();
}

class _AddLinkPanelState extends ConsumerState<AddLinkPanel> {
  late Group group;
  Course? course;
  Teacher? teacher;

  @override
  void initState() {
    group = widget.group;    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Panel(
      title: 'Новая привязка',
      chilren: [
        BaseTextFieldSelector(
          initial: group,
          header: "Группа",
          items: ref.watch(groupsProvider).value ?? [],
          itemSelected: (item) {
            group = item;
          },
        ),
        BaseTextFieldSelector(
          header: "Предмет",
          items: ref.watch(coursesProvider).value ?? [],
          itemSelected: (item) {
            course = item;
          },
        ),
        BaseTextFieldSelector(
          header: "Преподаватель",
          items: ref.watch(teachersProvider).value ?? [],
          itemSelected: (item) {
            teacher = item;
          },
        ),
        BaseElevatedButton(
          text: "Создать привязку",
          onTap: () async {
            await ref.read(dataSourceRepositoryProvider).createLink(link: LoadLink(
              group: group.id,
              teacher: teacher?.id,
              course: course?.id
            ));
            ref.refresh(groupLinksProvider(group.id));
            ref.read(messagesProvider).showMessage(type: MesTypes.success, header: 'Успешно', body: 'Привязка создана', context: context);
            context.pop();
          },
        ),
        BaseOutlinedButton(
          text: "Отмена",
          onTap: () {
            context.pop();
          },
        )
      ],
    );
  }
}
