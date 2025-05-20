import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gefest/core/api/data/data.dart';
import 'package:gefest/core/api/models/groups.dart';

part 'groups_screen_provider.g.dart';

@riverpod
List<Group> filteredGroups(Ref ref) {
  final String searchText = ref.watch(searchStringProvider).toLowerCase();
  return ref.watch(groupsProvider).value?.where((final Group group) => group.name.toLowerCase().contains(searchText)).toList() ?? []; 
}

final searchStringProvider = StateProvider<String>((ref) {
  return '';
});