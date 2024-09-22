abstract class ScheduleRepository {
  Future<dynamic> getGroupSchedule(int groupID, DateTime date);
}

class ScheduleRepositorySupabase implements ScheduleRepository {
  @override
  Future<dynamic> getGroupSchedule(int groupID, DateTime date) async {
    // Пример возвращаемого значения
    return {'groupID': groupID, 'date': date, 'source': 'Supabase'};
  }
}

class ScheduleRepositoryFastApi implements ScheduleRepository {
  @override
  Future getGroupSchedule(int groupID, DateTime date) {
    throw UnimplementedError();
  }
}

