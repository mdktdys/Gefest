import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/presentation/screens/teachers/techer_screen.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
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

  // Обновление текста фильтрации
  void updateFilterText(String text) {
    _filterText = text;
    notifyListeners();
  }

  // Обновление параметра сортировки
  void updateSortOption(SortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  // Метод для асинхронной фильтрации и сортировки
  Future<List<Teacher>> applyFilters(List<Teacher> teachers) async {
    return compute(_filterAndSort, [teachers, _filterText, _sortOption]);
  }

  // Функция для фильтрации и сортировки на фоне
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