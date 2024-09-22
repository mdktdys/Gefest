// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Paras {
  final int id;
  final int group;
  final int number;
  final int course;
  final int teacher;
  final int cabinet;
  final DateTime date;

  Paras(
      {required this.id,
      required this.group,
      required this.number,
      required this.course,
      required this.teacher,
      required this.cabinet,
      required this.date});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'group': group,
      'number': number,
      'course': course,
      'teacher': teacher,
      'cabinet': cabinet,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Paras.fromMap(Map<String, dynamic> map) {
    return Paras(
      id: map['id'] as int,
      group: map['group'] as int,
      number: map['number'] as int,
      course: map['course'] as int,
      teacher: map['teacher'] as int,
      cabinet: map['cabinet'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Paras.fromJson(String source) =>
      Paras.fromMap(json.decode(source) as Map<String, dynamic>);
}
