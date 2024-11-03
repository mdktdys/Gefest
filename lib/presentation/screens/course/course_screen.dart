
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/basics.dart';
import 'package:gefest/presentation/screens/course/provider/course_provider.dart';
import 'package:gefest/presentation/screens/teachers/providers/teachers_providers.dart';
import 'package:gefest/presentation/screens/teachers/teachers_screen.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/theme.dart';
import 'package:go_router/go_router.dart';

class CourseScreenParameters extends QueryParameters {
  CourseScreenParameters(super.context);

  int get courseId => int.parse(getParams['id']!);
}

class CourseScreen extends ScreenPageWidget<CourseScreenParameters> {
  
  CourseScreen(BuildContext context) : super(params: CourseScreenParameters(context));

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncProvider(
      provider: courseProvider(params.courseId),
      data: (course) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(course.name??'',style: Fa.medium,),
              SizedBox(height: 20),
              Row(children: [
                BaseOutlinedButton(
                  height: 40,
                  width: 100,
                  color: Colors.green,
                  text: "Добавить",
                  onTap: () async {
                    ref.read(courseScreenProvider).addSynonyms(context,course);
                  },
                )
              ],),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: course.synonyms.map((syn){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: SelectionArea(child: Text(syn,style: Fa.small))),
                        IconButton(onPressed: (){
                          ref.read(courseScreenProvider).removeSynonyms(context: context, course: course, syn: syn);
                        }, icon: Icon(Icons.remove))
                      ],
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }
}