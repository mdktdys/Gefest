import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/api/models/paras.dart';
import 'package:gefest/presentation/screens/schedule/providers/schedule_provider.dart';
import 'package:gefest/presentation/shared/base_icon_button.dart';
import 'package:gefest/theme.dart';

class ScheduleCard extends ConsumerStatefulWidget {
  final List<Paras> parasInTime;

  const ScheduleCard({super.key, required this.parasInTime});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends ConsumerState<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.onSurface)),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.parasInTime
            .map((para) => ScheduleCardPara(para: para))
            .toList(),
      ),
    );
  }
}

class ScheduleCardPara extends ConsumerStatefulWidget {
  final Paras para;
  const ScheduleCardPara({super.key, required this.para});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduleCardParaState();
}

class _ScheduleCardParaState extends ConsumerState<ScheduleCardPara> {
  bool hovered = false;

  hover(bool hover) {
    setState(() {
      hovered = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        onEnter: (event) {
          hover(true);
        },
        onExit: (event) {
          hover(false);
        },
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ref
                          .watch(dataProvider)
                          .getCourseById(widget.para.course)!
                          .getColor()),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ref
                                .watch(dataProvider)
                                .getCourseById(widget.para.course)
                                ?.fullname ??
                            ref.watch(dataProvider).getCourseById(widget.para.course)?.name??"",
                        style: Fa.medium,
                      ),
                      Text(
                        ref
                                .watch(dataProvider)
                                .getTeacherById(widget.para.teacher)
                                ?.name ??
                            "Нет",
                        style: Fa.smedium,
                      ),
                      Text(
                          ref
                                  .watch(dataProvider)
                                  .getCabinetById(widget.para.cabinet)
                                  ?.name ??
                              "Нет",
                          style: Fa.smedium),
                    ]),
              ],
            ),
            hovered
                ? Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: BaseIconButton(
                            icon: "assets/icons/edit.svg",
                            onTap: () async {
                              await ref.read(scheduleProvider).openParaPanel(
                                date: widget.para.date,
                                group: ref.watch(dataProvider).getGroupById(widget.para.group),
                                course: ref.watch(dataProvider).getCourseById(widget.para.course),
                                teacher: ref.watch(dataProvider).getTeacherById(widget.para.teacher),
                                cabinet: ref.watch(dataProvider).getCabinetById(widget.para.cabinet),
                                paraID: widget.para.id,
                                  number: widget.para.number,
                                  context: context,
                                  option: ParaPanelOption.edit);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: BaseIconButton(
                            icon: "assets/icons/cross.svg",
                            onTap: () async {
                              await ref
                                  .read(scheduleProvider)
                                  .removePara(widget.para);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
