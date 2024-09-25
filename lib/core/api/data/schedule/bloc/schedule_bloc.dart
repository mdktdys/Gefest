import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/api/data/schedule/request.dart';
import 'package:gefest/core/api/data/schedule/types.dart';
import 'package:gefest/core/api/models/converter.dart';
import 'package:gefest/core/api/models/paras.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleRequest? currentRequest;

  ScheduleBloc() : super(ScheduleInitial()) {
    restartable();
    on<LoadItemSchedule>((event, emit) async {
      try {
        emit(ScheduleLoading());
        final request = event.request;
        currentRequest = event.request;
        final paras = await SupabaseApi.getParas(
            request.type, request.searchItemID, request.date);
        emit(ScheduleSuccess(paras: paras));
      } catch (e, s) {
        emit(ScheduleFailed(e.toString(), s.toString()));
      }

    },transformer: restartable());
    on<ReloadItemSchedule>((event, emit) async {
      try {
        if (currentRequest == null) {
          emit(ScheduleInitial());
          return;
        }
        final request = currentRequest!;
        final paras = await SupabaseApi.getParas(
            request.type, request.searchItemID, request.date);
        emit(ScheduleSuccess(paras: paras));
      } catch (e, s) {
        emit(ScheduleFailed(e.toString(), s.toString()));
      }
    },transformer: restartable());
  }
}

class SupabaseApi {
  static Future<ActionResult> addPara(Paras para) async {
    final response = await GetIt.I.get<Supabase>().client.from('Paras').insert({
      'group': para.group,
      'number': para.number,
      'course': para.course,
      'teacher': para.teacher,
      'cabinet': para.cabinet,
      'date': para.date.toString()
    }).select('*');
    return ActionResultOk(text: "Created");
  }

  static Future<ActionResult> editPara(Paras para) async {
    final response = await GetIt.I.get<Supabase>().client.from('Paras').update({
      'group': para.group,
      'number': para.number,
      'course': para.course,
      'teacher': para.teacher,
      'cabinet': para.cabinet,
      'date': para.date.toString()
    }).eq('id', para.id).select('*');
    return ActionResultOk(text: "Edited");
  }

  static Future<ActionResult> removePara(Paras para) async {
    final response = await GetIt.I.get<Supabase>().client.from('Paras').delete().eq('id', para.id).select('*');
    return ActionResultOk(text: "Deleted");
  }

  static Future<List<Paras>> getParas(
      SearchType type, int searchID, DateTime date) async {
    var request = GetIt.I
        .get<Supabase>()
        .client
        .from('Paras')
        .select("*")
        .lte('date', date.add(const Duration(days: 6)))
        .gte('date', date);
    switch (type) {
      case SearchType.group:
        request = request.eq('group', searchID);
        break;
      case SearchType.teacher:
        request = request.eq('teacher', searchID);
        break;
      default:
    }
    final response = await request.order('number');
    GetIt.I.get<Talker>().warning(date);
    return parse<Paras>(response, Paras.fromMap).toList();
  }
}
