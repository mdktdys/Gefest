// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/presentation/screens/schedule/components/para_panel.dart';

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

  DateTime navigationDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  SearchItem? current_schedule_object;

  setNavigationDate(DateTime date, BuildContext context) {
    navigationDate = date;

    if (current_schedule_object != null) {
      ScheduleRequest request = ScheduleRequest(
          type: current_schedule_object!.type,
          date: getMondayDate(),
          searchItemID: current_schedule_object!.searchID);
      context.read<ScheduleBloc>().add(LoadItemSchedule(request));
    }
    notifyListeners();
  }

  refreshSchedule(){
    scheduleBloc.add(ReloadItemSchedule());
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
        type: item.type, date: getMondayDate(), searchItemID: item.searchID);
    context.read<ScheduleBloc>().add(LoadItemSchedule(request));
  }

  Future<ActionResult> addPara(Paras para) async {
    return await SupabaseApi.addPara(para);
  }

  Future<ActionResult> editPara(Paras para) async {
    return await SupabaseApi.editPara(para);
  }

  Future<ActionResult> removePara(Paras para) async {
    var res = await SupabaseApi.removePara(para);
    scheduleBloc.add(ReloadItemSchedule());
    return res;
  }

  openParaPanel(
      {required BuildContext context,
      int? number,
      DateTime? date,
      Group? group,
      Teacher? teacher,
      Course? course,
      int? paraID,
      required ParaPanelOption option,
      Cabinet? cabinet}) async {
    final res = await showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Row(
              children: [
                const DialogBlackout(),
                ParaPanel(
                  number: number,
                  option: option,
                  date: date,
                  course: course,
                  group: group,
                  teacher: teacher,
                  cabinet: cabinet,
                  paraID: paraID,
                ),
              ],
            ),
          );
        });
    return res;
  }
}
