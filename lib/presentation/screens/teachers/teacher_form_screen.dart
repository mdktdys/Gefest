import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gefest/core/api/data/repository/data_repository.dart';
import 'package:gefest/core/api/models/models.dart';
import 'package:gefest/core/basics.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/core/messages/messages_provider.dart';
import 'package:gefest/presentation/shared/base_container.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/theme/spacing.dart';

part 'teacher_form_screen.freezed.dart';
part 'teacher_form_screen.g.dart';

class TeacherFormScreen extends ScreenPageWidget<QueryParameters>  {
  TeacherFormScreen(BuildContext context) : super(params: QueryParameters(context));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(teacherFormNotifierProvider);
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Новый преподаватель',
            textAlign: TextAlign.left,
            style: context.styles.ubuntu20
          ),
          SizedBox(height: Spacing.list),
          BaseContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  spacing: Spacing.list,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        spacing: Spacing.list,
                        children: [
                          BaseTextField(
                            header: 'Наименование',
                            validator: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return 'Наименование не может быть пустым';
                              }
                                                
                              return null;
                            },
                            onChanged: (p0) {
                              ref.read(teacherFormNotifierProvider.notifier).onNameChanged(p0);
                              _formKey.currentState!.validate();
                            },
                          ),
                          BaseTextField(
                            header: 'Изображение',
                            onChanged: (p0) {
                              ref.read(teacherFormNotifierProvider.notifier).onImageChanged(p0);
                              _formKey.currentState!.validate();
                            },
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                      foregroundImage: NetworkImage(provider.image ?? ''),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: Spacing.list),
          Row(
            spacing: Spacing.list,
            children: [
              Expanded(
                child: BaseOutlinedButton(
                  text: 'Отмена',
                  onTap: () {
                    context.go(Routes.groups);
                  },
                ),
              ),
              Expanded(
                child: BaseElevatedButton(
                  text: 'Создать преподавателя',
                  onTap: () async {
                    final provider = ref.read(teacherFormNotifierProvider);
                    final Teacher teacher = Teacher.create(
                      name: provider.title ?? '-',
                      image: provider.image,
                    );
                    final int teacherId = await ref.watch(dataSourceRepositoryProvider).createTeacher(teacher: teacher);
                    ref.read(messagesProvider).showMessage(type: MesTypes.success, header: 'Успешно', body: 'Преподаватель создан', context: context);
                    log(teacherId.toString());
                    context.go(Uri(path: Routes.teacher,queryParameters: {'id': teacherId.toString()}).toString());
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

@freezed
sealed class TeacherFormState with _$TeacherFormState {
 factory TeacherFormState({
  String? title,
  String? image,
 }) = _TeacherFormState;
}

@riverpod
class TeacherFormNotifier extends _$TeacherFormNotifier {
  @override
  TeacherFormState build() {
    return TeacherFormState();
  }

  void onNameChanged(String text) {
    state = state.copyWith(title: text);
  }

  void onImageChanged(String? url) {
    state = state.copyWith(image: url);
  }
}