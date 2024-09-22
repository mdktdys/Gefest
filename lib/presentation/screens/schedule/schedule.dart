import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/schedule/bloc/schedule_bloc.dart';
import 'package:gefest/presentation/screens/schedule/components/editor_panel_top_panel.dart';
import 'package:gefest/presentation/screens/schedule/providers/schedule_provider.dart';

import 'components/schedule_grid.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ref.read(scheduleProvider).scheduleBloc,
      child: Column(
        children: [
          const ScheduleEditorTopPanel(),
          Expanded(child: BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              if (state is ScheduleFailed) {
                return Center(
                  child: Text("Ошибка ${state.error} ${state.trace}"),
                );
              }
              if (state is ScheduleSuccess) {
                var collection = [0, 1, 2, 3, 4, 5];
                final weekParas = state.paras;
                final mondayDate = ref.watch(scheduleProvider).getMondayDate();
                return ScheduleGrid(
                    collection: collection,
                    mondayDate: mondayDate,
                    weekParas: weekParas);
              }
              return const Center(child: Text("Выберите объект расписания"));
            },
          ))
        ],
      ),
    );
  }
}
