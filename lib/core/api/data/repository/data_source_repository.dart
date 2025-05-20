import 'package:gefest/core/api/models/department_model.dart';

abstract class DataSourceRepository {
  Future<List<Department>> fetchDepartments();
}