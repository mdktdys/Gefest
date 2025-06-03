import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/core/api/models/groups.dart';
import 'package:gefest/core/api/models/teachers.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';

abstract class DataSourceRepository {
  Future<List<Department>> fetchDepartments();

  Future<void> createLink({required LoadLink link});

  Future<void> deleteLink({required int id});

  Future<int> createGroup({required Group group});

  Future<void> deleteGroup({required int id});

  Future<int> createTeacher({required Teacher teacher});

  Future<void> deleteTeacher({required int id});
}