// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(dataSourceRepository)
const dataSourceRepositoryProvider = DataSourceRepositoryProvider._();

final class DataSourceRepositoryProvider
    extends $FunctionalProvider<DataSourceRepository, DataSourceRepository>
    with $Provider<DataSourceRepository> {
  const DataSourceRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dataSourceRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dataSourceRepositoryHash();

  @$internal
  @override
  $ProviderElement<DataSourceRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DataSourceRepository create(Ref ref) {
    return dataSourceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataSourceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<DataSourceRepository>(value),
    );
  }
}

String _$dataSourceRepositoryHash() =>
    r'e3abf15a1b8034836b6068c6933e2cbb716e3ba6';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
