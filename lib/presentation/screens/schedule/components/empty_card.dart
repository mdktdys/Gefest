
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/api.dart';
import 'package:gefest/presentation/screens/schedule/providers/schedule_provider.dart';
import 'package:gefest/theme.dart';

class EmptyCard extends ConsumerStatefulWidget {
  final int number;
  final DateTime date;
  const EmptyCard({super.key, required this.date, required this.number});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmptyCardState();
}

class _EmptyCardState extends ConsumerState<EmptyCard> {
  bool hovering = false;
  bool creating = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        if (!creating) {
          setState(() {
            hovering = true;
          });
        }
      },
      onExit: (event) {
        if (!creating) {
          setState(() {
            hovering = false;
          });
        }
      },
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Builder(builder: (context) {
            if (hovering) {
              return GestureDetector(
                onTap: () {
                  creating = true;
                  hovering = false;
                  setState(() {});
                  final currentScheduleObject = ref.read(scheduleProvider).current_schedule_object!;
                  switch (currentScheduleObject.type) {
                    case SearchType.group:
                      final group = ref.watch(dataProvider).getGroupById(currentScheduleObject.searchID);
                      ref.read(scheduleProvider).openAddParaPanel(context:context,number: widget.number,date: widget.date, group: group);
                      break;
                      case SearchType.teacher:
                      final teacher = ref.watch(dataProvider).getTeacherById(currentScheduleObject.searchID);
                      ref.read(scheduleProvider).openAddParaPanel(context:context,number: widget.number,date: widget.date, teacher: teacher);
                      break;
                    default:
                  }
                },
                child: Center(
                  child: Text(
                    "Добавить",
                    style: Fa.small,
                  ),
                ),
              );
            }

            if (creating) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.surface)),
                width: double.infinity,
                height: double.infinity,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("picker"),
                  ],
                ),
              );
            }

            return Container(
                color: Theme.of(context).colorScheme.surface,
                width: double.infinity,
                height: double.infinity,
                child: const SizedBox.shrink());
          })),
    );
  }
}
