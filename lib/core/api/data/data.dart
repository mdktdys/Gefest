// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/presentation/screens/load/providers/load_provider.dart';

import '../models/models.dart';

final dataProvider = Provider<DataProvider>((ref) {
  return DataProvider(ref: ref);
});

class DataProvider {
  Ref ref;
  DataProvider({
    required this.ref,
  });

  Teacher? getTeacherById(int id) {
    return ref
        .watch(teachersProvider)
        .value
        ?.where((teacher) => teacher.id == id)
        .firstOrNull;
  }

  Group? getGroupById(int id) {
    return ref
        .watch(groupsProvider)
        .value
        ?.where((group) => group.id == id)
        .firstOrNull;
  }

  Cabinet? getCabinetById(int id) {
    return ref
        .watch(cabinetsProvider)
        .value
        ?.where((cabinet) => cabinet.id == id)
        .firstOrNull;
  }

  Course? getCourseById(int id) {
    return ref
        .watch(coursesProvider)
        .value
        ?.where((course) => course.id == id)
        .firstOrNull;
  }

  CodeDiscipline? getDisciplineCode(int id) {
    return ref
        .watch(codeDisciplineProvider)
        .value
        ?.where((course) => course.id == id)
        .firstOrNull;
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

final cabinetsProvider = FutureProvider<List<Cabinet>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Cabinets').select('*');

  return parse<Cabinet>(res, Cabinet.fromMap).toList();
});

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Courses').select('*');

  return parse<Course>(res, Course.fromMap).toList();
});

final groupsProvider = FutureProvider<List<Group>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Groups').select('*').order('name');

  return parse<Group>(res, Group.fromMap).toList();
});

final teachersProvider = FutureProvider<List<Teacher>>((ref) async {
  final supabaseClient = GetIt.I.get<Supabase>().client;
  final res = await supabaseClient.from('Teachers').select('*');

  return parse<Teacher>(res, Teacher.fromMap).toList();
});

final searchItemsProvider = FutureProvider<List<SearchItem>>((ref) async {
  final groupsAsyncValue = ref.watch(groupsProvider);
  final teachersAsyncValue = ref.watch(teachersProvider);

  if (groupsAsyncValue is AsyncLoading || teachersAsyncValue is AsyncLoading) {
    return [];
  }

  if (groupsAsyncValue.hasError) {
    throw groupsAsyncValue.error!;
  }
  if (teachersAsyncValue.hasError) {
    throw teachersAsyncValue.error!;
  }

  final groups = groupsAsyncValue.value ?? [];
  final teachers = teachersAsyncValue.value ?? [];

  return [...groups, ...teachers];
});

final searchProvider =
    StateNotifierProvider<SearchNotifier, List<SearchItem>>((ref) {
  return SearchNotifier(ref);
});

class SearchNotifier extends StateNotifier<List<SearchItem>> {
  Ref ref;
  SearchNotifier(this.ref)
      : super([
          ...ref.watch(groupsProvider).value ?? [],
          ...ref.watch(teachersProvider).value ?? [],
        ]);

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
