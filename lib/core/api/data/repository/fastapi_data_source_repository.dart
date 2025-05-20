import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';

import 'package:gefest/core/api/data/repository/data_source_repository.dart';
import 'package:gefest/core/api/data/schedule/repository/test.dart';
import 'package:gefest/core/api/models/department_model.dart';

class FastApiDataSourceRepository implements DataSourceRepository  {
  final FastApiService service = GetIt.I.get<ChopperClient>().getService<FastApiService>();

  @override
  Future<List<Department>> fetchDepartments() async {
    final result = await service.fetchDepartments();
    return result.body ?? [];
  }
}