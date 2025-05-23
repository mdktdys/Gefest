import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gefest/core/api/data/repository/data_repository.dart';
import 'package:gefest/core/api/models/department_model.dart';

part 'department_provider.g.dart';

@riverpod
Future<List<Department>> departments (Ref ref) async {
  return await ref.watch(dataSourceRepositoryProvider).fetchDepartments(); 
}


@riverpod
Department? department(Ref ref, int id) {
  final AsyncValue<List<Department>> departmentsAsync = ref.watch(departmentsProvider);

  if (!departmentsAsync.hasValue) {
    null;
  }

  return departmentsAsync.value?.where((Department department) => department.id == id).firstOrNull;
}