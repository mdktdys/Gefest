// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_screen_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(filteredGroups)
const filteredGroupsProvider = FilteredGroupsProvider._();

final class FilteredGroupsProvider
    extends $FunctionalProvider<List<Group>, List<Group>>
    with $Provider<List<Group>> {
  const FilteredGroupsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'filteredGroupsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$filteredGroupsHash();

  @$internal
  @override
  $ProviderElement<List<Group>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Group> create(Ref ref) {
    return filteredGroups(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Group> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<List<Group>>(value),
    );
  }
}

String _$filteredGroupsHash() => r'3f66b1dda8cc69737b83197daef1e89a4f80f0f1';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
