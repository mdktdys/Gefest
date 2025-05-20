import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/core/api/data/repository/data_source_repository.dart';
import 'package:gefest/core/api/models/department_model.dart';

class SupabaseDataSourceRepository implements DataSourceRepository {
  final Supabase supabase = GetIt.I.get<Supabase>();

  @override
  Future<List<Department>> fetchDepartments() async {
    final response = await supabase.client.from('Departments').select('*');
    return response.map((final Map<String, dynamic> map) => Department.fromMap(map)).toList();
  }
}