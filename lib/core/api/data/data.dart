// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/models/cabinet.dart';
import 'package:gefest/core/api/models/course.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../models/models.dart';
import '../models/search.dart';

final dataProvider = Provider<DataProvider>((ref) {
  return DataProvider(ref: ref);
});

class DataProvider {
  Ref ref;
  DataProvider({
    required this.ref,
  });

  Teacher? getTeacherById(int id) {
    return ref.watch(teachersProvider).value?.where((teacher)=>teacher.id == id).firstOrNull;
  }

  Group? getGroupById(int id) {
    return ref.watch(groupsProvider).value?.where((group)=>group.id == id).firstOrNull;
  }

  Cabinet? getCabinetById(int id) {
    return ref.watch(cabinetsProvider).value?.where((cabinet)=>cabinet.id == id).firstOrNull;
  }

  Course? getCourseById(int id) {
    return ref.watch(coursesProvider).value?.where((course)=>course.id == id).firstOrNull;
  }
}

final timetableProvider = FutureProvider<List<ParaTime>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient
      .from('scheduleTimetable')
      .select('*')
      .order('number', ascending: true);
  return parse<ParaTime>(res, ParaTime.fromMap).toList();
});

final groupsProvider = FutureProvider<List<Group>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Groups').select('*');
  GetIt.I.get<Talker>().error(res);

  return parse<Group>(res, Group.fromMap).toList();
});

final teachersProvider = FutureProvider<List<Teacher>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Teachers').select('*');

  return parse<Teacher>(res, Teacher.fromMap).toList();
});

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Courses').select('*');

  return parse<Course>(res, Course.fromMap).toList();
});

final cabinetsProvider = FutureProvider<List<Cabinet>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Cabinets').select('*');

  return parse<Cabinet>(res, Cabinet.fromMap).toList();
});

final searchProvider =
    StateNotifierProvider<SearchNotifier, List<SearchItem>>((ref) {
  return SearchNotifier(ref);
});

class SearchNotifier extends StateNotifier<List<SearchItem>> {
  Ref ref;
  SearchNotifier(this.ref) : super([]);

  void search(String text) {
    final filter = text.toLowerCase();
    state = [
      ...ref
              .watch(groupsProvider)
              .value
              ?.where((x) => x.searchText.toLowerCase().contains(filter)) ??
          [],
      ...ref
              .watch(teachersProvider)
              .value
              ?.where((x) => x.searchText.toLowerCase().contains(filter)) ??
          [],
    ];
  }
}
