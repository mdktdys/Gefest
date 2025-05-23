// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(departments)
const departmentsProvider = DepartmentsProvider._();

final class DepartmentsProvider extends $FunctionalProvider<
        AsyncValue<List<Department>>, FutureOr<List<Department>>>
    with $FutureModifier<List<Department>>, $FutureProvider<List<Department>> {
  const DepartmentsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'departmentsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$departmentsHash();

  @$internal
  @override
  $FutureProviderElement<List<Department>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Department>> create(Ref ref) {
    return departments(ref);
  }
}

String _$departmentsHash() => r'c3d2fbc63a636d4ac83a0c19ed0fd243bc9506f6';

@ProviderFor(department)
const departmentProvider = DepartmentFamily._();

final class DepartmentProvider
    extends $FunctionalProvider<Department?, Department?>
    with $Provider<Department?> {
  const DepartmentProvider._(
      {required DepartmentFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'departmentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$departmentHash();

  @override
  String toString() {
    return r'departmentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Department?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Department? create(Ref ref) {
    final argument = this.argument as int;
    return department(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Department? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<Department?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DepartmentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$departmentHash() => r'c0e3a3aec5277142fe52cf71d426ef052ace426b';

final class DepartmentFamily extends $Family
    with $FunctionalFamilyOverride<Department?, int> {
  const DepartmentFamily._()
      : super(
          retry: null,
          name: r'departmentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  DepartmentProvider call(
    int id,
  ) =>
      DepartmentProvider._(argument: id, from: this);

  @override
  String toString() => r'departmentProvider';
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
