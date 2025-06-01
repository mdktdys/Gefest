import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';

abstract class DataSourceRepository {
  Future<List<Department>> fetchDepartments();

  Future<void> createLink({required LoadLink link});

  Future<void> deleteLink({required int id});
}