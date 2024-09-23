// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/schedule/bloc/bloc.dart';
import 'package:gefest/core/api/data/schedule/types.dart';
import 'package:gefest/core/api/models/groups.dart';
import 'package:gefest/core/api/models/int_search_wrapper.dart';
import 'package:gefest/core/api/models/search.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/theme.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/api/api.dart';
import '../../../shared/shared.dart';

final scheduleProvider = ChangeNotifierProvider<ScheduleNotifier>((ref) {
  return ScheduleNotifier(ref: ref);
});

class ScheduleNotifier extends ChangeNotifier {
  ScheduleBloc scheduleBloc = ScheduleBloc();
  Ref ref;
  ScheduleNotifier({
    required this.ref,
  });

  DateTime navigationDate = DateTime(2024, 9, 9);
  SearchItem? current_schedule_object;

  setNavigationDate(DateTime date, BuildContext context){
    navigationDate = date;

    if(current_schedule_object != null){
        ScheduleRequest request = ScheduleRequest(
        type: current_schedule_object!.type,
        date: navigationDate,
        searchItemID: current_schedule_object!.searchID);
        context.read<ScheduleBloc>().add(LoadItemSchedule(request));
    }
    notifyListeners();
  }

  DateTime getMondayDate() {
    int currentDayOfWeek = navigationDate.weekday;
    DateTime mondayDate =
        navigationDate.subtract(Duration(days: currentDayOfWeek - 1));
    return mondayDate;
  }

  selectItem(SearchItem item, BuildContext context) {
    current_schedule_object = item;
    ScheduleRequest request = ScheduleRequest(
        type: item.type,
        date: navigationDate,
        searchItemID: item.searchID);
    context.read<ScheduleBloc>().add(LoadItemSchedule(request));
  }

  Future<ActionResult> addPara(Paras para) async {
    return await SupabaseApi.addPara(para);
  }

  openAddParaPanel(
      {required BuildContext context,
      int? number,
      DateTime? date,
      Group? group,
      Teacher? teacher,
      Cabinet? cabinet}) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Row(
              children: [
                const DialogBlackout(),
                AddParaPanel(
                  number: number,
                  date: date,
                  group: group,
                  teacher: teacher,
                  cabinet: cabinet,
                ),
              ],
            ),
          );
        });
  }
}

class AddParaPanel extends ConsumerStatefulWidget {
  final int? number;
  final DateTime? date;
  final Teacher? teacher;
  final Cabinet? cabinet;
  final Group? group;
  final Course? course;
  const AddParaPanel(
      {super.key,
      this.date,
      this.number,
      this.cabinet,
      this.group,
      this.teacher,
      this.course});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddParaPanelState();
}

class _AddParaPanelState extends ConsumerState<AddParaPanel> {
  Teacher? teacher;
  Cabinet? cabinet;
  DateTime? date;
  Group? group;
  Course? course;
  int? number;

  @override
  void initState() {
    super.initState();
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
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //       border: Border(
          //           bottom: BorderSide(
          //               color: Theme.of(context).colorScheme.onSurface))),
          //   child: Text(
          //     "Новая пара",
          //     textAlign: TextAlign.left,
          //     style: Fa.big,
          //   ),
          // ),
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
                Text(
                  "Пара: ${widget.number}",
                  textAlign: TextAlign.left,
                  style: Fa.medium,
                ),
                const SizedBox(
                  height: 10,
                ),
                BaseTextFieldSelector(
                  initial: number != null ? SearchInt(value: number!) : null,
                  header: "Пара",
                  items: [1, 2, 3, 4, 5, 6]
                      .map((x) => SearchInt(value: x))
                      .toList(),
                      itemSelected: (item){
                        number = (item as SearchInt).value;
                      },
                ),
                BaseTextFieldSelector(
                  initial: group,
                  header: "Группа",
                  items: ref.watch(groupsProvider).value ?? [],
                  itemSelected: (item){
                    group = item;
                  },
                ),
                BaseTextFieldSelector(
                  initial: course,
                  header: "Предмет",
                  items: ref.watch(coursesProvider).value ?? [],
                  itemSelected: (item){
                    course = item;
                  },
                ),
                BaseTextFieldSelector(
                  initial: teacher,
                  header: "Преподаватель",
                  items: ref.watch(teachersProvider).value ?? [],
                  itemSelected: (item){
                    teacher = item;
                  },
                ),
                BaseTextFieldSelector(
                  initial: cabinet,
                  header: "Кабинет",
                  items: ref.watch(cabinetsProvider).value ?? [],
                  itemSelected: (item){
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
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BaseElevatedButton(
                  text: "Добавить",
                  onTap: () async {
                    if (group != null &&
                        number != null &&
                        course != null &&
                        teacher != null &&
                        cabinet != null &&
                        date != null) {
                      Paras para = Paras(
                          id: -1,
                          group: group!.id,
                          number: number!,
                          course: course!.id,
                          teacher: teacher!.id,
                          cabinet: cabinet!.id,
                          date: date!);
                      final res = await ref.watch(scheduleProvider).addPara(para);
                      ref.watch(scheduleProvider).scheduleBloc.add(ReloadItemSchedule());
                      context.pop();
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
                    context.pop();
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

class BaseTextFieldSelector extends ConsumerStatefulWidget {
  final Function? itemSelected;
  final List<SearchItem> items;
  final String? hint;
  final String? header;
  final SearchItem? initial;
  const BaseTextFieldSelector(
      {super.key,
      this.hint,
      this.itemSelected,
      this.initial,
      required this.items,
      this.header});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BaseTextFieldSelectorState();
}

class _BaseTextFieldSelectorState extends ConsumerState<BaseTextFieldSelector> {
  SearchItem? choosed;
  TextEditingController controller = TextEditingController();
  List<SearchItem> filtered = [];
  bool field_activated = false;
  bool fieldLocked = false;

  @override
  void initState() {
    super.initState();
    filtered = widget.items;
    choosed = widget.initial;

    if (choosed != null) {
      controller.text = choosed!.searchText;
      fieldLocked = true;
    }
  }

  _filterSearch(text) {
    setState(() {
      filtered = widget.items
          .where((x) => x.searchText.toLowerCase().contains(text))
          .toList();
    });
  }

  _onSelect(SearchItem item) {
    setState(() {
      choosed = item;
      controller.text = item.searchText;
      fieldLocked = true;
      widget.itemSelected?.call(choosed);
    });
  }

  _clearField() {
    setState(() {
      choosed = null;
      field_activated = false;
      filtered = widget.items;
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: BaseTextField(
                locked: choosed != null ? true : false,
                onTap: () {
                  if (!field_activated && choosed == null) {
                    setState(() {
                      field_activated = true;
                    });
                  }
                },
                onChanged: (p0) => _filterSearch(p0.toLowerCase()),
                controller: controller,
                header: widget.header,
                hintText: widget.hint,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 48,
              height: 48,
              child: BaseIconButton(
                icon: "assets/icons/clear.svg",
                color: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  _clearField();
                },
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 300),
            child: (choosed == null && field_activated)
                ? ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 600),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: filtered.isEmpty
                          ? SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Ничего не найдено",
                                textAlign: TextAlign.center,
                                style: Fa.smedium,
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Theme.of(context).colorScheme.surface,
                                  indent: 10,
                                  endIndent: 10,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                final item = filtered[index];
                                return Material(
                                  color: Theme.of(context).colorScheme.surface,
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                      hoverColor: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      onTap: () {
                                        _onSelect(item);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          item.searchText,
                                          style: Fa.smedium,
                                        ),
                                      )),
                                );
                              },
                            ),
                    ),
                  )
                : const SizedBox.shrink())
      ],
    );
  }
}
