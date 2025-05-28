import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:gefest/core/basics.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/screens/teachers/providers/teachers_providers.dart';
import 'package:gefest/presentation/screens/teachers/teachers_screen.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/theme.dart';
import 'package:gefest/theme/spacing.dart';

class TeacherScreenParameters extends QueryParameters {
  TeacherScreenParameters(super.context);

  int get teacherId => int.parse(getParams['id']!);
}

class TeacherScreen extends ScreenPageWidget<TeacherScreenParameters> {
  
  TeacherScreen(BuildContext context) : super(params: TeacherScreenParameters(context));

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncProvider(
      provider: teacherProvider(params.teacherId),
      data: (teacher) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(teacher.name??'',style: Fa.medium,),
              SizedBox(height: 20),
              Row(children: [
                BaseOutlinedButton(
                  height: 40,
                  width: 100,
                  color: Colors.green,
                  text: "Добавить",
                  onTap: () async {
                    ref.read(teacherSreenProvider).addSynonyms(context,teacher);
                  },
                )
              ],),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: teacher.synonyms.map((syn){
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
                          ref.read(teacherSreenProvider).removeSynonyms(context: context, teacher: teacher, syn: syn);
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

class NewSynonymBody extends StatelessWidget {
  const NewSynonymBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Новый синоним",style: Fa.medium,),
        SizedBox(height: 10,),
        BaseTextField(
          autofocus: true,
          controller: controller
        ),
        SizedBox(height: 10,),
        BaseElevatedButton(
          height: 40,
          text: "Добавить",
          onTap: () {
            context.pop(controller.text);
          },
        )
      ],
    );
  }
}

class StringInputBottomSheet extends ConsumerStatefulWidget {
  final String title;
  final String initial;
  final String submitText;

  const StringInputBottomSheet({
    required this.initial,
    required this.title,
    this.submitText = 'Сохранить',
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StringInputBottomSheetState();
}

class _StringInputBottomSheetState extends ConsumerState<StringInputBottomSheet> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initial);
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Spacing.list,
      children: [
        Text(
          widget.title,
          style: context.styles.ubuntu20,
        ),
        BaseTextField(
          autofocus: true,
          controller: controller
        ),
        BaseElevatedButton(
          text: widget.submitText,
          onTap: () {
            context.pop(controller.text);
          },
        )
      ],
    );
  }
}