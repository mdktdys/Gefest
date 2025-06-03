// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_form_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(TeacherFormNotifier)
const teacherFormNotifierProvider = TeacherFormNotifierProvider._();

final class TeacherFormNotifierProvider
    extends $NotifierProvider<TeacherFormNotifier, TeacherFormState> {
  const TeacherFormNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'teacherFormNotifierProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$teacherFormNotifierHash();

  @$internal
  @override
  TeacherFormNotifier create() => TeacherFormNotifier();

  @$internal
  @override
  $NotifierProviderElement<TeacherFormNotifier, TeacherFormState>
      $createElement($ProviderPointer pointer) =>
          $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeacherFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<TeacherFormState>(value),
    );
  }
}

String _$teacherFormNotifierHash() =>
    r'3b8645635c10bfb9a26f9922b1541612ea170035';

abstract class _$TeacherFormNotifier extends $Notifier<TeacherFormState> {
  TeacherFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TeacherFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<TeacherFormState>, TeacherFormState, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
