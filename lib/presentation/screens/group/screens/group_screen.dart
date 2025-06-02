import 'package:flutter/material.dart';

import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/data/data.dart' hide groupProvider;
import 'package:gefest/core/api/data/providers/department_provider.dart';
import 'package:gefest/core/api/data/repository/data_repository.dart';
import 'package:gefest/core/api/models/course.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/core/api/models/groups.dart';
import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/core/basics.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/presentation/screens/group/providers/group_provider.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';
import 'package:gefest/presentation/screens/teachers/teachers_screen.dart';
import 'package:gefest/presentation/shared/base_container.dart';
import 'package:gefest/presentation/shared/shared.dart';
import 'package:gefest/theme/spacing.dart';

class GroupScreenParameters extends QueryParameters {
  GroupScreenParameters(super.context);

  int get groupId => int.parse(getParams['id']!);
}

class GroupScreen extends ScreenPageWidget<GroupScreenParameters> {
  GroupScreen(BuildContext context) : super(params: GroupScreenParameters(context));

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AsyncProvider<Group>(
      provider: groupProvider(params.groupId),
      data: (Group group) {
        final Department? department = ref.watch(departmentProvider(group.department));
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: Spacing.listHorizontalPadding),
          children: [
            Padding(padding: EdgeInsetsGeometry.only(top: Spacing.listHorizontalPadding)),
            BaseContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 20,
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        foregroundImage: NetworkImage(group.image ?? ''),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.name,
                            style: context.styles.ubuntu22
                          ),
                          Text(
                            department?.name ?? '-',
                            style: context.styles.ubuntu18.copyWith(color: Theme.of(context).colorScheme.outline)
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BaseOutlinedButton(
                        text: 'Удалить',
                        onTap: () {
                          
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.only(top: Spacing.listHorizontalPadding)),
            BaseContainer(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: Spacing.list,
                children: [
                  Text(
                    'Привязки',
                    style: context.styles.ubuntu18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Дисциплина',
                        style: context.styles.ubuntu14,
                      ),
                      Text(
                        'Преподаватель',
                        style: context.styles.ubuntu14,
                      ),
                    ],
                  ),
                  AsyncProvider(
                    provider: groupLinksProvider(group.id),
                    data: (final List<LoadLink> links) {
                      return Column(
                        spacing: Spacing.list,
                        children: links.map((final LoadLink link) {
                          final Course? course = ref.watch(courseProvider(link.course ?? -1));
                          final Teacher? teacher = ref.watch(teacherProvider(link.teacher ?? -1));

                          if (
                            course == null
                            || teacher == null
                          ) {
                            return SizedBox();
                          }

                          return BaseContainer(
                            color: Theme.of(context).colorScheme.surfaceContainer,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Bounceable(
                                    onTap: () {
                                      context.go(Uri(
                                      path: '/course',
                                      queryParameters: {'id': course.id.toString()}).toString());
                                    },
                                    child: Text(
                                      course.name.toString(),
                                      style: context.styles.ubuntu14,
                                    ),
                                  )
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Bounceable(
                                    onTap: () {
                                      context.go(Uri(
                                      path: '/teacher',
                                      queryParameters: {'id': teacher.id.toString()}).toString());
                                    },
                                    child: Text(
                                      teacher.name.toString(),
                                      style: context.styles.ubuntu14,
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ),
                                SizedBox(width: Spacing.list),
                                SizedBox(
                                  height: 36,
                                  child: BaseIconButton(
                                    icon: 'assets/icons/clear.svg',
                                    iconColor: Theme.of(context).colorScheme.outline,
                                    onTap: () async {
                                      bool result = await showDialog(context: context, builder: (context) => YesNoDialog(
                                        title: 'Удалить привязку?',
                                        body: 'Это действие нельзя отменить',
                                      ));
                                      
                                      if (!result) {
                                        return;
                                      }

                                      await ref.watch(dataSourceRepositoryProvider).deleteLink(id: link.id!);
                                      ref.refresh(groupLinksProvider(group.id));
                                      ref.read(messagesProvider).showMessage(type: MesTypes.success, header: 'Успешно', body: 'Привязка удалена', context: context);
                                    },
                                  ),
                                )
                              ],
                            )
                          );
                        }).toList(),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BaseElevatedButton(
                        text: 'Новая привязка',
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AddLinkPanel(group: group)
                          );
                        },
                      )
                    ],
                  ),
                ],
              )
            ),
            Padding(padding: EdgeInsetsGeometry.only(top: Spacing.listHorizontalPadding)),
          ],
        );
      },
    );
  }
}

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
                )),
      ),
    );
  }
}

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

class Panel extends StatelessWidget {
  final String title;
  final List<Widget> chilren;
 
  const Panel({
    required this.title,
    required this.chilren,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          const DialogBlackout(),
          ParaPanel(
            title: title,
            children: chilren,
          ),
        ],
      ),
    );
  }
}


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
