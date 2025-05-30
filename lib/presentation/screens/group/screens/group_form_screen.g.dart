// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_form_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(GroupFormNotifier)
const groupFormNotifierProvider = GroupFormNotifierProvider._();

final class GroupFormNotifierProvider
    extends $NotifierProvider<GroupFormNotifier, GroupFromState> {
  const GroupFormNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'groupFormNotifierProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$groupFormNotifierHash();

  @$internal
  @override
  GroupFormNotifier create() => GroupFormNotifier();

  @$internal
  @override
  $NotifierProviderElement<GroupFormNotifier, GroupFromState> $createElement(
          $ProviderPointer pointer) =>
      $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroupFromState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<GroupFromState>(value),
    );
  }
}

String _$groupFormNotifierHash() => r'a7537c0e9e55a7b9b1e6311a072ce02a7c3857f1';

abstract class _$GroupFormNotifier extends $Notifier<GroupFromState> {
  GroupFromState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GroupFromState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<GroupFromState>, GroupFromState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
