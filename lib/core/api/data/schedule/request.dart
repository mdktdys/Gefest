import 'package:gefest/core/api/data/schedule/types.dart';

class ScheduleRequest {
  final SearchType type;
  final DateTime date;
  final int searchItemID;

  ScheduleRequest(
      {required this.type, required this.date, required this.searchItemID});
}
