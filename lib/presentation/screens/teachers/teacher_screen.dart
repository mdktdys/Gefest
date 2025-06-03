import 'package:flutter/material.dart';

import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/configs/images.dart';
import 'package:gefest/core/api/data/data.dart' hide teacherProvider;
import 'package:gefest/core/api/data/repository/data_repository.dart';
import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/core/basics.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/presentation/screens/teachers/providers/teachers_providers.dart';
import 'package:gefest/presentation/shared/async_provider.dart';
import 'package:gefest/presentation/shared/base_container.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/presentation/shared/yes_no_dialog.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/theme/spacing.dart';

class TeacherScreenParameters extends QueryParameters {
  TeacherScreenParameters(super.context);

  int get teacherId => int.parse(getParams['id']!);
}

// class TeacherScreen extends ScreenPageWidget<TeacherScreenParameters> {
  
//   TeacherScreen(BuildContext context) : super(params: TeacherScreenParameters(context));

//   @override 
//   Widget build(BuildContext context, WidgetRef ref) {
//     return AsyncProvider(
//       provider: teacherProvider(params.teacherId),
//       data: (teacher) {
//         return SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20),
//               Text(teacher.name??'',style: Fa.medium,),
//               SizedBox(height: 20),
//               Row(children: [
//                 BaseOutlinedButton(
//                   height: 40,
//                   width: 100,
//                   color: Colors.green,
//                   text: "Добавить",
//                   onTap: () async {
//                     ref.read(teacherSreenProvider).addSynonyms(context,teacher);
//                   },
//                 )
//               ]),
//               SizedBox(height: 20,),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: teacher.synonyms.map((syn){
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: Theme.of(context).colorScheme.onSurface)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child: SelectionArea(child: Text(syn,style: Fa.small))),
//                         IconButton(onPressed: (){
//                           ref.read(teacherSreenProvider).removeSynonyms(context: context, teacher: teacher, syn: syn);
//                         }, icon: Icon(Icons.remove))
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


class TeacherScreen extends ScreenPageWidget<TeacherScreenParameters> {
  TeacherScreen(BuildContext context) : super(params: TeacherScreenParameters(context));

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AsyncProvider<Teacher>(
      provider: teacherProvider(params.teacherId),
      data: (Teacher teacher) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: Spacing.listHorizontalPadding),
          children: [
            Padding(padding: EdgeInsetsGeometry.only(top: Spacing.listHorizontalPadding)),
            BaseContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 20,
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        foregroundImage: NetworkImage(teacher.image ?? ''),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teacher.name ?? '',
                            style: context.styles.ubuntu22
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BaseOutlinedButton(
                        text: 'Удалить',
                        onTap: () async {
                          bool result = await showDialog(context: context, builder: (context) => YesNoDialog(
                            title: 'Удалить преподавателя?',
                            body: 'Это действие нельзя отменить',
                          ));

                          if (!result) {
                            return;
                          }

                          await ref.watch(dataSourceRepositoryProvider).deleteTeacher(id: teacher.id);
                          ref.invalidate(teachersProvider);
                          ref.read(messagesProvider).showMessage(type: MesTypes.success, header: 'Успешно', body: 'Преподаватель удален', context: context);
                          context.go(Routes.teachers);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.only(top: Spacing.listHorizontalPadding)),
            BaseContainer(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: Spacing.list,
                children: [
                  Text(
                    'Синонимы',
                    style: context.styles.ubuntu18,
                  ),
                  Wrap(
                    spacing: Spacing.list,
                    runSpacing: Spacing.list,
                    children: teacher.synonyms.map((final String syn) {
                      return BaseContainer(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        child: Row(
                          spacing: Spacing.list,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              syn,
                              style: context.styles.ubuntu16,
                            ),
                            Bounceable(
                              onTap: () {
                                ref.read(teacherSreenProvider).removeSynonyms(
                                  context: context,
                                  teacher: teacher,
                                  syn: syn
                                );
                              },
                              child: SvgPicture.asset(
                                Images.trash,
                                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.outlineVariant, BlendMode.srcIn),
                              ),
                            )
                          ],
                        )
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BaseElevatedButton(
                        text: 'Новый синоним',
                        onTap: () async {
                          ref.read(teacherSreenProvider).addSynonyms(context, teacher);
                        },
                      )
                    ],
                  ),
                ],
              )
            ),
            Padding(padding: EdgeInsetsGeometry.only(top: Spacing.listHorizontalPadding)),
          ],
        );
      },
    );
  }
}
