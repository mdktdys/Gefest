import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gefest/core/basics.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/course/provider/course_provider.dart';
import 'package:gefest/presentation/screens/group/providers/group_provider.dart';
import 'package:gefest/presentation/screens/teachers/teachers_screen.dart';
import 'package:gefest/presentation/shared/base_container.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/theme.dart';
import 'package:gefest/theme/spacing.dart';

class CourseScreenParameters extends QueryParameters {
  CourseScreenParameters(super.context);

  int get courseId => int.parse(getParams['id']!);
}

class CourseScreen extends ScreenPageWidget<CourseScreenParameters, Provider<CourseScreenProvider>> {
  
  CourseScreen(BuildContext context) : super(
    params: CourseScreenParameters(context),
    controller: Provider<CourseScreenProvider>((ref) => CourseScreenProvider(ref))
  );

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncProvider(
      provider: courseProvider(params.courseId),
      data: (course) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spacing.listHorizontalPadding,
            children: [
              Text(course.name ?? '',style: Fa.medium),
              BaseContainer(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: Column(
                  spacing: Spacing.list,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Синонимы',
                      textAlign: TextAlign.start,
                      style: context.styles.ubuntu16,
                    ),
                    Column(
                      spacing: Spacing.list,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: course.synonyms.map((String syn) {
                        return BaseContainer(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                syn,
                                style: context.styles.ubuntu14,
                              ),
                              BaseOutlinedButton(
                                text: 'Удалить',
                                onTap: () async {
                                  ref.read(courseScreenProvider).removeSynonyms(context: context, course: course, syn: syn);
                                },
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
                          text: "Добавить синоним",
                          onTap: () async {
                            ref.read(courseScreenProvider).addSynonyms(context, course);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}