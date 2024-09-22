
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/api/models/paras.dart';
import 'package:gefest/theme.dart';

class ScheduleCard extends ConsumerStatefulWidget {
  final List<Paras> parasInTime;

  const ScheduleCard({super.key, required this.parasInTime });

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
            .map((para) => Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ref
                                .watch(dataProvider)
                                .getCourseById(para.course)!
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
                                      .getCourseById(para.course)
                                      ?.fullname ??
                                  "Нет",
                              style: Fa.medium,
                            ),
                            Text(
                              ref
                                      .watch(dataProvider)
                                      .getTeacherById(para.teacher)
                                      ?.name ??
                                  "Нет",
                              style: Fa.smedium,
                            ),
                            Text(
                                ref
                                        .watch(dataProvider)
                                        .getCabinetById(para.cabinet)
                                        ?.name ??
                                    "Нет",
                                style: Fa.smedium),
                          ]),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}