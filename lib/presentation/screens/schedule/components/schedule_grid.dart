import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/presentation/screens/schedule/components/empty_card.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/api/models/models.dart';
import 'schedule_card.dart';

class ScheduleGrid extends ConsumerStatefulWidget {
  final List<int> collection;
  final DateTime mondayDate;
  final List<Paras> weekParas;
  const ScheduleGrid(
      {super.key,
      required this.collection,
      required this.mondayDate,
      required this.weekParas});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleGridState();
}

class _ScheduleGridState extends ConsumerState<ScheduleGrid> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.collection.map((day) {
        final DateTime currentDay = widget.mondayDate.add(Duration(days: day));
        final dayParas = widget.weekParas
            .where((paras) => paras.date == currentDay)
            .toList();
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ref.watch(timetableProvider).value!.map((paratiming) {
              final parasInTime = dayParas
                  .where((paras) => paras.number == paratiming.number)
                  .toList();
              bool isEmpty = parasInTime.isEmpty;
              return Expanded(
                child: Builder(builder: (context) {
                  if (isEmpty) {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                        child: EmptyCard(
                          date: currentDay,
                          number: paratiming.number,
                        ));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ScheduleCard(parasInTime: parasInTime),
                  );
                }),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
