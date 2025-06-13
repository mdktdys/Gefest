// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/presentation/shared/new_synonym_body.dart';
import 'package:gefest/presentation/shared/string_input_bottomsheet.dart';
import 'package:gefest/theme.dart';

enum SortOption { nameAsc, nameDesc }

enum Answer { ok, cancel }

final teacherSreenProvider = ChangeNotifierProvider<TeacherNotifier>((ref) {
  return TeacherNotifier(ref);
});

class TeacherNotifier extends ChangeNotifier {
  Ref ref;
  TeacherNotifier(this.ref);


  Future<void> addSynonyms(BuildContext context, Teacher teacher) async {
    final String? res = await showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: NewSynonymBody(),
      );
    });
    if(res == null || res.isEmpty) return;
    teacher.synonyms.add(res);
    await GetIt.I.get<Supabase>().client.from('Teachers').update({'synonyms':teacher.synonyms}).eq('id', teacher.id).select('*');
    ref.refresh(teacherProvider(teacher.id));
  }

  Future<void> createQueue(BuildContext context, Teacher teacher) async {
    String? name = await showModalBottomSheet(context: context, builder: (context) => StringInputBottomSheet(
      initial: 'Новая очередь',
      title: 'Наименование очереди',
      submitText: 'Создать')
    );

    if (name == null) {
      return;
    }

    await GetIt.I.get<Supabase>().client.from('Queues').insert({'name': name, 'teacher': teacher.id});
    ref.refresh(teacherQueuesProvider(teacher.id));
  }

  Future<void> deleteQueue({
    required BuildContext context,
    required Teacher teacher,
    required Queue queue
  }) async {
    final Answer? res = await showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnswerBody(
          title: "Удалить очерель ${queue.name}?",
          description: "Действие нельзя отменить",
        ),
      );
    });

    if(res != Answer.ok) {
      return;
    } 

    await GetIt.I.get<Supabase>().client.from('Queues').delete().eq('id', queue.id);
    ref.invalidate(teacherQueuesProvider(teacher.id));
  }

  Future<void> removeSynonyms({required BuildContext context,required Teacher teacher, required String syn}) async {
    final Answer? res = await showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnswerBody(
          title: "Удалить синоним $syn?",
          description: "Действие нельзя отменить",
        ),
      );
    });
    if(res != Answer.ok) return;
    teacher.synonyms.remove(syn);
    await GetIt.I.get<Supabase>().client.from('Teachers').update({'synonyms':teacher.synonyms}).eq('id', teacher.id).select('*');
    ref.refresh(teacherProvider(teacher.id));
  }
}

class AnswerBody extends StatelessWidget {
  final String? title;
  final String? description;
  const AnswerBody({
    this.title,
    this.description
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != null) ...[
          Text(title!,style: Fa.medium),
          SizedBox(height: 10,),
        ],
        if(description != null) ...[
          Text(description!,style: Fa.small),
          SizedBox(height: 10,),
        ],
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: BaseOutlinedButton(
                  text: "Закрыть",
                  onTap: () {
                    context.pop(Answer.cancel);
                  },
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: BaseElevatedButton(
                  text: "Удалить",
                  onTap: () {
                    context.pop(Answer.ok);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TeachersFilter extends ChangeNotifier {
  String _filterText = '';
  SortOption _sortOption = SortOption.nameAsc;

  String get filterText => _filterText;
  SortOption get sortOption => _sortOption;

  void updateFilterText(String text) {
    _filterText = text;
    notifyListeners();
  }

  void updateSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  Future<List<Teacher>> applyFilters(List<Teacher> teachers) async {
    return compute(_filterAndSort, [teachers, _filterText, _sortOption]);
  }

  List<Teacher> _filterAndSort(List<dynamic> args) {
    final teachers = args[0] as List<Teacher>;
    final filterText = args[1] as String;
    final sortOption = args[2] as SortOption;

    var filteredTeachers = teachers.where((teacher) =>
        teacher.name!.toLowerCase().contains(filterText.toLowerCase())).toList();

    switch (sortOption) {
      case SortOption.nameAsc:
        filteredTeachers.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case SortOption.nameDesc:
        filteredTeachers.sort((a, b) => b.name!.compareTo(a.name!));
        break;
    }

    return filteredTeachers;
  }
}

final teachersFilterProvider = ChangeNotifierProvider((ref) => TeachersFilter());

final filteredTeachersProvider = FutureProvider<List<Teacher>>((ref) async {
  final teachersFilter = ref.watch(teachersFilterProvider);
  final allTeachers = await ref.watch(teachersProvider.future);
  
  return await teachersFilter.applyFilters(allTeachers);
});


final teacherProvider = FutureProvider.family<Teacher,int>((ref,id) async {
  return (await ref.watch(teachersProvider.future)).where((teacher) => teacher.id == id).first;
});

final teacherQueuesProvider = FutureProvider.family<List<Queue>, int>((ref, id) async {
  final List<Map<String, dynamic>> data = await GetIt.I.get<Supabase>().client.from('Queues').select('*').eq('teacher', id);
  return data.map((final Map<String, dynamic> json) => Queue.fromMap(json)).toList();
});

class Queue {
  int id;
  String name;
  int teacher;

  Queue({
    required this.id,
    required this.name,
    required this.teacher,
  });

  Queue copyWith({
    int? id,
    String? name,
    int? teacher,
  }) {
    return Queue(
      id: id ?? this.id,
      name: name ?? this.name,
      teacher: teacher ?? this.teacher,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'teacher': teacher,
    };
  }

  factory Queue.fromMap(Map<String, dynamic> map) {
    return Queue(
      id: map['id'] as int,
      name: map['name'] as String,
      teacher: map['teacher'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Queue.fromJson(String source) => Queue.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Queue(id: $id, name: $name, teacher: $teacher)';

  @override
  bool operator ==(covariant Queue other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.teacher == teacher;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ teacher.hashCode;
}
