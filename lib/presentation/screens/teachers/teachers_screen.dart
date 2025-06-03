import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/teachers/providers/teachers_providers.dart';
import 'package:gefest/presentation/screens/teachers/widgets/teacher_list_tile.dart';
import 'package:gefest/presentation/shared/async_provider.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/routes.dart';
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
                // final Group group = Group.create(name: '');
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
