import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/extensions.dart';
import 'package:gefest/presentation/screens/schedule/components/editor_panel_top_panel.dart';
import 'package:gefest/presentation/screens/schedule/providers/schedule_provider.dart';
import 'package:gefest/theme.dart';

import 'components/schedule_grid.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ref.read(scheduleProvider).scheduleBloc,
      child: Column(
        children: [
          const ScheduleEditorTopPanel(),
          Builder(builder: (context) {
            switch (ref.watch(scheduleProvider).view) {
              case ScheduleViews.month:
                return MonthView(ref: ref,);
              case ScheduleViews.monthly:
                return MonthlyView();
            }
          }),
          // SizedBox(height: 20,),
          // MonthView(ref: ref)
        ],
      ),
    );
  }
}

class MonthlyView extends ConsumerStatefulWidget {
  const MonthlyView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MonthlyViewState();
}

class _MonthlyViewState extends ConsumerState<MonthlyView> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MonthView extends StatelessWidget {
  const MonthView({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocBuilder<ScheduleBloc, ScheduleState>(
      key: UniqueKey(),
      builder: (context, state) {
        if (state is ScheduleFailed) {
          return Center(
            child: Text("Ошибка ${state.error} ${state.trace}"),
          );
        }
        if (state is ScheduleLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ScheduleSuccess) {
          var collection = [0, 1, 2, 3, 4, 5];
          final weekParas = state.paras;
          GetIt.I.get<Talker>().info(weekParas);
          final mondayDate = ref.watch(scheduleProvider).getMondayDate();
          return ScheduleView(
              collection: collection,
              mondayDate: mondayDate,
              weekParas: weekParas);
        }
        return const Center(child: Text("Выберите объект расписания"));
      },
    ));
  }
}

class ScheduleView extends ConsumerStatefulWidget {
  final List<int> collection;
  final DateTime mondayDate;
  final List<Paras> weekParas;
  const ScheduleView({
    super.key,
    required this.collection,
    required this.mondayDate,
    required this.weekParas,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends ConsumerState<ScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "${1}\n99:99\n99:99",
              style: TextStyle(color: Colors.transparent),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.collection.map((dayOffset) {
                    final date =
                        widget.mondayDate.add(Duration(days: dayOffset));
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date.weekday.toWeekName(),
                              style: Fa.medium,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${date.month.toMonthName()} ${date.day}",
                              style: Fa.small,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ],
        ),
        Expanded(
          child: Builder(builder: (context) {
            return ref.watch(timetableProvider).when(data: (data) {
              return Row(
                children: [
                  Column(
                    children: data
                        .map((paraTime) => Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface))),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${paraTime.number}\n${paraTime.start}\n${paraTime.end}",
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ))
                        .toList(),
                  ),
                  Expanded(
                    child: ScheduleGrid(
                      collection: widget.collection,
                      mondayDate: widget.mondayDate,
                      weekParas: widget.weekParas
                    ),
                  ),
                ],
              );
            }, error: (error, o) {
              return Center(
                child: Text("Ошибка ${error.toString()} ${o.toString()}"),
              );
            }, loading: () {
              return const CircularProgressIndicator();
            });
          }),
        ),
      ],
    );
  }
}
