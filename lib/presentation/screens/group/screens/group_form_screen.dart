import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gefest/core/basics.dart';
import 'package:gefest/core/extensions/context_extension.dart';
import 'package:gefest/presentation/shared/base_textfield.dart';
import 'package:gefest/theme/spacing.dart';

part 'group_form_screen.freezed.dart';
part 'group_form_screen.g.dart';

class GroupFormScreen extends ScreenPageWidget<QueryParameters>  {
  GroupFormScreen(BuildContext context) : super(params: QueryParameters(context));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          )
        ],
      ),
    );
  }
}


@freezed
sealed class GroupFromState with _$GroupFromState {
 factory GroupFromState({
  String? title
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
}