
import 'dart:convert';

class ParaTime {
  final int number;
  final String start;
  final String end;
  final String saturdayStart;
  final String saturdayEnd;
  final String obedStart;
  final String obedEnd;

  ParaTime(
      {required this.number,
      required this.start,
      required this.end,
      required this.saturdayStart,
      required this.saturdayEnd,
      required this.obedStart,
      required this.obedEnd});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'start': start,
      'end': end,
      'saturdayStart': saturdayStart,
      'saturdayEnd': saturdayEnd,
      'obedStart': obedStart,
      'obedEnd': obedEnd,
    };
  }

  factory ParaTime.fromMap(Map<String, dynamic> map) {
    return ParaTime(
      number: map['number'] as int,
      start: map['start'] as String,
      end: map['end'] as String,
      saturdayStart: map['saturdayStart'] as String,
      saturdayEnd: map['saturdayEnd'] as String,
      obedStart: map['obedStart'] as String,
      obedEnd: map['obedEnd'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParaTime.fromJson(String source) =>
      ParaTime.fromMap(json.decode(source) as Map<String, dynamic>);
}
