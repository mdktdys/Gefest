
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/models/int_search_wrapper.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/presentation/screens/schedule/providers/schedule_provider.dart';
import 'package:gefest/theme.dart';

import '../../../../core/api/api.dart';
import '../../../shared/shared.dart';

enum ParaPanelOption{
  create,
  edit,
}

class ParaPanel extends ConsumerStatefulWidget {
  final ParaPanelOption option;
  final int? number;
  final DateTime? date;
  final Teacher? teacher;
  final Cabinet? cabinet;
  final Group? group;
  final Course? course;
  final int? paraID;
  
  const ParaPanel({super.key,
      this.date,
      required this.option,
      this.number,
      this.cabinet,
      this.paraID,
      this.group,
      this.teacher,
      this.course});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ParaPanelState();
}

class _ParaPanelState extends ConsumerState<ParaPanel> {
  Teacher? teacher;
  Cabinet? cabinet;
  DateTime? date;
  Group? group;
  Course? course;
  int? number;

  @override
  void initState() {
    super.initState();
    course = widget.course;
    teacher = widget.teacher;
    cabinet = widget.cabinet;
    date = widget.date;
    group = widget.group;
    number = widget.number;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 670,
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: Theme.of(context).colorScheme.onSurface)),
          color: Theme.of(context).colorScheme.surface),
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
                              color: Theme.of(context).colorScheme.onSurface))),
                  child: Text(
                    widget.option == ParaPanelOption.create ? "Новая пара" : "Изменить пару",
                    textAlign: TextAlign.left,
                    style: Fa.big,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseTextFieldSelector(
                        initial: number != null ? SearchInt(value: number!) : null,
                        header: "Пара",
                        items: [1, 2, 3, 4, 5, 6]
                            .map((x) => SearchInt(value: x))
                            .toList(),
                        itemSelected: (item) {
                          number = (item as SearchInt).value;
                        },
                      ),
                      BaseTextFieldSelector(
                        initial: group,
                        header: "Группа",
                        items: ref.watch(groupsProvider).value ?? [],
                        itemSelected: (item) {
                          group = item;
                        },
                      ),
                      BaseTextFieldSelector(
                        initial: course,
                        header: "Предмет",
                        items: ref.watch(coursesProvider).value ?? [],
                        itemSelected: (item) {
                          course = item;
                        },
                      ),
                      BaseTextFieldSelector(
                        initial: teacher,
                        header: "Преподаватель",
                        items: ref.watch(teachersProvider).value ?? [],
                        itemSelected: (item) {
                          teacher = item;
                        },
                      ),
                      BaseTextFieldSelector(
                        initial: cabinet,
                        header: "Кабинет",
                        items: ref.watch(cabinetsProvider).value ?? [],
                        itemSelected: (item) {
                          cabinet = item;
                        },
                      ),
                      Text(date.toString())
                      // BaseTextFieldSelector(
                      //   header: "Дата",
                      //   items: ref.watch(coursesProvider).value ?? [],
                      // ),
                    ],
                  ),
                ),
                
              ],
            ),

          ),
          Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Theme.of(context).colorScheme.onSurface))
                ),
                child: Column(
                  children: [
                    BaseElevatedButton(
                      text: widget.option == ParaPanelOption.create ? "Добавить" : "Изменить",
                      onTap: () async {
                        if (group != null &&
                            number != null &&
                            course != null &&
                            teacher != null &&
                            cabinet != null &&
                            date != null) {
                          Paras para = Paras(
                              id: widget.paraID??-1,
                              group: group!.id,
                              number: number!,
                              course: course!.id,
                              teacher: teacher!.id,
                              cabinet: cabinet!.id,
                              date: date!);
          
          
                          switch (widget.option) {
                            case ParaPanelOption.create:
                              final res =
                              await ref.watch(scheduleProvider).addPara(para);
                          ref
                              .watch(scheduleProvider)
                              .scheduleBloc
                              .add(ReloadItemSchedule());
                          context.pop(ActionResultOk(text: "Created"));
                              break;
                            case ParaPanelOption.edit:
                              final res =
                              await ref.watch(scheduleProvider).editPara(para);
                          ref
                              .watch(scheduleProvider)
                              .scheduleBloc
                              .add(ReloadItemSchedule());
                          context.pop(ActionResultOk(text: "Edited"));
                              break;
                          }
          
                        } else {
                          ref.watch(messagesProvider).showMessage(
                              type: MesTypes.error,
                              context: context,
                              header: "Где-то пусто",
                              body:
                                  "Какие-то поля не заполните, проверьте еще раз");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BaseOutlinedButton(
                      text: "Отмена",
                      onTap: () {
                        context.pop(ActionResultError(text: "Cancel"));
                      },
                    )
                  ],
                ),
              )
        ],
      ),
    );
  }
}
