import 'package:get_it/get_it.dart' show GetIt;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/test.dart';

import 'package:gefest/core/api/data/repository/data_source_repository.dart';
import 'package:gefest/core/api/data/repository/fastapi_data_source_repository.dart';
import 'package:gefest/core/api/data/repository/supabase_data_source_repository.dart';
import 'package:gefest/secrets.dart';

void main() {
  group('Performance test for fetchDepartments', () async {
    late DataSourceRepository supabaseRepository;
    late DataSourceRepository fastApiRepository;
    
    setUp(() async {

      if (!GetIt.I.isRegistered<Supabase>()) {
        final supabase = await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
        GetIt.I.registerSingleton<Supabase>(supabase);
      }

      supabaseRepository = SupabaseDataSourceRepository();
      fastApiRepository = FastApiDataSourceRepository();
    });

    test('Supabase fetchDepartments performance', () async {
      final stopwatch = Stopwatch()..start();

      final departments = await supabaseRepository.fetchDepartments();

      stopwatch.stop();

      print('Supabase fetchDepartments took: ${stopwatch.elapsedMilliseconds} ms');

      expect(departments, isNotEmpty);
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    });

    test('FastApi fetchDepartments performance', () async {
      final stopwatch = Stopwatch()..start();

      final departments = await fastApiRepository.fetchDepartments();

      stopwatch.stop();

      print('FastApi fetchDepartments took: ${stopwatch.elapsedMilliseconds} ms');

      expect(departments, isNotEmpty);
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    });
  });
}
