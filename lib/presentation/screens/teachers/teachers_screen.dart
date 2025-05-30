import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/teachers/providers/teachers_providers.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/theme.dart';
import 'package:gefest/theme/spacing.dart';
class TeachersScreen extends ConsumerStatefulWidget {
  const TeachersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends ConsumerState<TeachersScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teachersFilter = ref.watch(teachersFilterProvider);

    return ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Text(
            'Преподаватели',
            textAlign: TextAlign.left,
            style: context.styles.ubuntu20
          ),
          SizedBox(height: Spacing.list),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: BaseTextField(
                  controller: controller,
                  hintText: 'Поиск преподавателя...',
                  onChanged: (p0) {
                    ref.read(teachersFilterProvider).updateFilterText(controller.text);
                  },
                ),
              ),
              BaseElevatedButton(
                text: 'Добавить',
                onTap: () {
                  final Group group = Group.create();
                  context.go(Uri(path: Routes.newTeacher).toString());
                },
              )
            ],
          ),
          SizedBox(height: 10),
          
          // DropdownButton<SortOption>(
          //   value: teachersFilter.sortOption,
          //   onChanged: (SortOption? newValue) {
          //     if (newValue != null) {
          //       ref.read(teachersFilterProvider).updateSortOption(newValue);
          //     }
          //   },
          //   underline: SizedBox(),
          //   borderRadius: BorderRadius.circular(16),
          //   items: [
          //     DropdownMenuItem(
          //       value: SortOption.nameAsc,
          //       child: Text("Сортировать по имени (возрастание)"),
          //     ),
          //     DropdownMenuItem(
          //       value: SortOption.nameDesc,
          //       child: Text("Сортировать по имени (убывание)"),
          //     ),
          //   ],
          // ),
          
          SizedBox(height: 10),
          
          // Отображение отфильтрованного и отсортированного списка преподавателей
          AsyncProvider<List<Teacher>>(
            provider: filteredTeachersProvider,
            data: (teachers) {
              return Column(
                children: teachers.map((teacher) {
                  return TeacherListTile(teacher);
                }).toList(),
              );
            },
          ),
        ],
      );
  }
}

class AsyncProvider<T> extends ConsumerWidget {
  final FutureProvider<T> provider;
  final Widget Function()? loading;
  final Widget Function(T)? data;
  final Widget Function(Object,StackTrace)? error;

  const AsyncProvider({
    required this.provider,
    this.data,
    this.loading,
    this.error,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ref.watch(provider).when(data: data?? (data){
      return Text(data.toString());
    }, error: error??(e,o){
      return Center(child: Text(e.toString()),);
    }, loading: loading??(){
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}


class TeacherListTile extends StatelessWidget {
  final Teacher teacher;
  const TeacherListTile(
    this.teacher
  );

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            spacing: 20,
            children: [
              // CircleAvatar(
              //   maxRadius: 32,
              //   backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
              //   foregroundImage: NetworkImage(teacher.image ?? ''),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacher.name ?? '',
                    style: context.styles.ubuntu18
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseElevatedButton(
                text: 'Изменить',
                onTap: () {
                  context.go(Uri(path:'/teacher',queryParameters: {'id': teacher.id.toString()}).toString());
                },
              )
            ],
          )
        ],
      )
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(context).colorScheme.onSurface)),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(teacher.name??'',style: Fa.medium,),
            IconButton(onPressed: (){
              context.go(Uri(path:'/teacher',queryParameters: {'id':teacher.id.toString()}).toString());
            }, icon: Icon(Icons.edit))
          ],
        ));
  }
}


    
          // Builder(builder: (context) {
          //   return ref.watch(teachersProvider).when(data: (data) {
          //     return 
          //   }, error: (e, o) {
          //     return Center(
          //       child: Text("Ошибка ${e.toString()} ${o.toString()}"),
          //     );
          //   }, loading: () {
          //     return const Center(child: CircularProgressIndicator());
          //   });
          // })