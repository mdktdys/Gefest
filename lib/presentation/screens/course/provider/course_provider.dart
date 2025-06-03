import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/presentation/screens/teachers/providers/teachers_providers.dart';
import 'package:gefest/presentation/shared/new_synonym_body.dart';

final courseProvider = FutureProvider.family<Course,int>((ref,id) async {
  return (await ref.watch(coursesProvider.future)).where((course) => course.id == id).first;
});

final courseScreenProvider = ChangeNotifierProvider<CourseNotifier>((ref) {
  return CourseNotifier(ref);
});

class CourseNotifier extends ChangeNotifier {
  Ref ref;
  CourseNotifier(this.ref);


  Future<void> addSynonyms(BuildContext context, Course course) async {
    final String? res = await showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: NewSynonymBody(),
      );
    });
    if(res == null || res.isEmpty) return;
    course.synonyms.add(res);
    await GetIt.I.get<Supabase>().client.from('Courses').update({'synonyms':course.synonyms}).eq('id', course.id).select('*');
    ref.refresh(courseProvider(course.id));
  }

  Future<void> removeSynonyms({required BuildContext context,required Course course, required String syn}) async {
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
    course.synonyms.remove(syn);
    await GetIt.I.get<Supabase>().client.from('Courses').update({'synonyms':course.synonyms}).eq('id', course.id).select('*');
    ref.refresh(courseProvider(course.id));
  }
}
