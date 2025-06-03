import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';

import 'package:gefest/core/api/data/repository/data_source_repository.dart';
import 'package:gefest/core/api/data/schedule/repository/test.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/core/api/models/groups.dart';
import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';

class FastApiDataSourceRepository implements DataSourceRepository  {
  final FastApiService service = GetIt.I.get<ChopperClient>().getService<FastApiService>();

  @override
  Future<List<Department>> fetchDepartments() async {
    final result = await service.fetchDepartments();
    return result.body ?? [];
  }

  @override
  Future<void> createLink({
    required LoadLink link
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteLink({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<int> createGroup({required Group group}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteGroup({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<int> createTeacher({required Teacher teacher}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTeacher({required int id}) {
    throw UnimplementedError();
  }
}