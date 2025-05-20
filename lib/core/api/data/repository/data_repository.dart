import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:gefest/core/api/data/repository/data_source_repository.dart';
import 'package:gefest/core/api/data/repository/fastapi_data_source_repository.dart';

part 'data_repository.g.dart';

@riverpod
DataSourceRepository dataSourceRepository(Ref ref) {
  return FastApiDataSourceRepository();
}