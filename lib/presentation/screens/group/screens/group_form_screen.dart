import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gefest/configs/images.dart';
import 'package:gefest/core/api/data/providers/department_provider.dart';
import 'package:gefest/core/api/data/repository/data_repository.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/core/api/models/entity.dart';
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
                              initial: Department(id: 0, name: 'Не определено'),
                              onSelected: (Department department) {
                                ref.read(groupFormNotifierProvider.notifier).onDepartmentChanged(department);
                              }
                            ),
                            BaseTextField(
                              header: 'Изображение',
                              onChanged: (p0) {
                                ref.read(groupFormNotifierProvider.notifier).onImageChanged(p0);
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
                  text: 'Создать группу',
                  onTap: () async {
                    final provider = ref.read(groupFormNotifierProvider);
                    final Group group = Group.create(
                      name: provider.title ?? '-',
                      image: provider.image,
                      departmentId: provider.department?.id
                    );
                    final int groupId = await ref.watch(dataSourceRepositoryProvider).createGroup(group: group);
                    ref.read(messagesProvider).showMessage(type: MesTypes.success, header: 'Успешно', body: 'Группа создана', context: context);
                    log(groupId.toString());
                    context.go(Uri(path: '/group',queryParameters: {'id': groupId.toString()}).toString());
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

class BaseSelector<T extends Entity> extends ConsumerStatefulWidget {
  final AsyncValue<List<T>> items;
  final Function(T) onSelected;
  final String? header;
  final T? initial;

  const BaseSelector({
    required this.items,
    required this.onSelected,
    this.initial,
    this.header,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseSelectorState<T>();
}

class _BaseSelectorState<T extends Entity> extends ConsumerState<BaseSelector<T>> {
  T? selected;

  @override
  void initState() {
    selected = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.header != null) ...[
          Text(
            widget.header!,
            textAlign: TextAlign.left,
            style: context.styles.ubuntu16,
          ),
          const SizedBox(height: 10)
        ],
      Material(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell( 
          onHover: (value) {},
          onTap: () async {
            selected = await showModalBottomSheet(context: context, builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  spacing: Spacing.listHorizontalPadding,
                  children: [
                    if (widget.header != null)
                      Text(
                        widget.header ?? '',
                        textAlign: TextAlign.center,
                        style: context.styles.ubuntu18,
                      ),
                    Column(
                      spacing: Spacing.list,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: widget.items.value!.map((final Entity element) {
                        return Bounceable(
                          onTap: () {
                            context.pop(element);
                          },
                          child: BaseContainer(
                            child: Text(element.displayName)
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }) ?? selected;
            if (selected != null) {
              widget.onSelected(selected!);
            }
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: widget.items.isLoading
            ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
              children: [
                Expanded(
                  child: Text(
                      selected?.displayName ?? 'Не выбрано',
                      textAlign: TextAlign.left,
                      style: context.styles.ubuntu16
                    ),
                ),
                SvgPicture.asset(
                  Images.menu,
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.outlineVariant, BlendMode.srcIn),
                )
              ],
            )
            )
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