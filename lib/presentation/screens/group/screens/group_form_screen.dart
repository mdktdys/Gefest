import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gefest/core/api/data/providers/department_provider.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/core/basics.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_container.dart';
import 'package:gefest/presentation/shared/base_elevated_button.dart';
import 'package:gefest/presentation/shared/base_outlined_button.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/theme/spacing.dart';

part 'group_form_screen.freezed.dart';
part 'group_form_screen.g.dart';

class GroupFormScreen extends ScreenPageWidget<QueryParameters>  {
  GroupFormScreen(BuildContext context) : super(params: QueryParameters(context));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(groupFormNotifierProvider);
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Новая группа',
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
                                ref.read(groupFormNotifierProvider.notifier).onNameChanged(p0);
                                _formKey.currentState!.validate();
                              },
                            ),
                            BaseSelector<Department>(
                              header: 'Отделение',
                              items: ref.watch(departmentsProvider),
                            ),
                            BaseTextField(
                              header: 'Отделение',
                              validator: (p0) {
                                if (p0?.isEmpty ?? true) {
                                  return 'Отделение не может быть пустым';
                                }
                                                  
                                return null;
                              },
                              onChanged: (p0) {
                                ref.read(groupFormNotifierProvider.notifier).onNameChanged(p0);
                                _formKey.currentState!.validate();
                              },
                            ),
                            BaseTextField(
                              header: 'Изображение',
                              onChanged: (p0) {
                                ref.read(groupFormNotifierProvider.notifier).onNameChanged(p0);
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
                    
                  },
                ),
              ),
              Expanded(
                child: BaseElevatedButton(
                  text: 'Создать группу',
                  onTap: () {
                    
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

class BaseSelector<T> extends ConsumerWidget {
  final AsyncValue<List<T>> items;
  final String? header;
 
  const BaseSelector({
    required this.items,
    this.header,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (header != null) ...[
          Text(
            header!,
            textAlign: TextAlign.left,
            style: context.styles.ubuntu16,
          ),
          const SizedBox(height: 10)
        ],
      Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onHover: (value) {},
        onTap: () async {
          // setState(() {
          //   loading = true;
          // });
          // try {
          //   await widget.onTap?.call();
          // } catch (e) {
          //   ref.watch(messagesProvider).showMessage(
          //     type: MesTypes.error,
          //     header: "Ошибка",
          //     body: e.toString(),
          //     context: context
          //   );
          // }
          // setState(() {
          //   loading = false;
          // });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: items.isLoading
            ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                "",
                textAlign: TextAlign.center,
                style: context.styles.ubuntu16
              )
            ),
          ),
        )
      ],
    );
  }
}

@freezed
sealed class GroupFromState with _$GroupFromState {
 factory GroupFromState({
  String? title,
  String? image,
  Department? department,
 }) = _GroupFromState;
}

@riverpod
class GroupFormNotifier extends _$GroupFormNotifier {
  @override
  GroupFromState build() {
    return GroupFromState();
  }

  void onNameChanged(String text) {
    state = state.copyWith(title: text);
  }

  void onImageChanged(String? url) {
    state = state.copyWith(image: url);
  }

  void onDepartmentChanged(Department? department) {
    state = state.copyWith(department: department);
  }
}