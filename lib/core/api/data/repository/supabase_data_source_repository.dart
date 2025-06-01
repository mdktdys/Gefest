import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/core/api/data/repository/data_source_repository.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/presentation/screens/load/providers/load_provider.dart';

class SupabaseDataSourceRepository implements DataSourceRepository {
  final Supabase supabase = GetIt.I.get<Supabase>();

  @override
  Future<List<Department>> fetchDepartments() async {
    final response = await supabase.client.from('Departments').select('*');
    return response.map((final Map<String, dynamic> map) => Department.fromMap(map)).toList();
  }

  @override
  Future<void> createLink({
    required LoadLink link
  }) async {
    await supabase.client.from('loadlinkers').insert(link.toMap());
  }

  @override
  Future<void> deleteLink({required int id}) async {
    await supabase.client.from('loadlinkers').delete().eq('id', id);
  }
}