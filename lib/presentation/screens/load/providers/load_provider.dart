// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/core/api/api.dart';

final loadProvider = FutureProvider<List<LoadLink>>((ref) async {
  final res = await GetIt.I.get<Supabase>().client.from('loadlinkers').select('*');
  log(res.toString());
  return parse<LoadLink>(res, LoadLink.fromMap).toList();
});

final codeDisciplineProvider = FutureProvider<List<CodeDiscipline>>((ref) async {
  final res = await GetIt.I.get<Supabase>().client.from('DisciplineCodes').select('*');
  return parse<CodeDiscipline>(res, CodeDiscipline.fromMap).toList();
});

class CodeDiscipline {
  final int id;
  final String name; 
  CodeDiscipline({
    required this.id,
    required this.name,
  });

  CodeDiscipline copyWith({
    int? id,
    String? name,
  }) {
    return CodeDiscipline(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CodeDiscipline.fromMap(Map<String, dynamic> map) {
    return CodeDiscipline(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeDiscipline.fromJson(String source) => CodeDiscipline.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CodeDiscipline(id: $id, name: $name)';

  @override
  bool operator ==(covariant CodeDiscipline other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class LoadLink {
  final int id;
  final int? load;
  final int? group;
  final int? course;
  final int? codediscipline;
  final int? teacher;
  final int? certificationformFirst;
  final int? firstSemesterHours;
  final int? secondSemesterHours;
  final int? totalHours;
  final int? srsHours;
  final int? konspectHours;
  final int? LandPHours;
  final int? lecturesHours;
  final int? practicesHours;
  final int? lab1Hours;
  final int? lab2Hours;
  final int? KandPHours;
  final int? ExamHours;
  final int? certificationformSecond;
  LoadLink({
    required this.id,
    this.load,
    this.group,
    this.course,
    this.codediscipline,
    this.teacher,
    this.certificationformFirst,
    this.firstSemesterHours,
    this.secondSemesterHours,
    this.totalHours,
    this.srsHours,
    this.konspectHours,
    this.LandPHours,
    this.lecturesHours,
    this.practicesHours,
    this.lab1Hours,
    this.lab2Hours,
    this.KandPHours,
    this.ExamHours,
    this.certificationformSecond,
  });

  LoadLink copyWith({
    int? id,
    int? load,
    int? group,
    int? course,
    int? codediscipline,
    int? teacher,
    int? certificationformFirst,
    int? firstSemesterHours,
    int? secondSemesterHours,
    int? totalHours,
    int? srsHours,
    int? konspectHours,
    int? LandPHours,
    int? lecturesHours,
    int? practicesHours,
    int? lab1Hours,
    int? lab2Hours,
    int? KandPHours,
    int? ExamHours,
    int? certificationformSecond,
  }) {
    return LoadLink(
      id: id ?? this.id,
      load: load ?? this.load,
      group: group ?? this.group,
      course: course ?? this.course,
      codediscipline: codediscipline ?? this.codediscipline,
      teacher: teacher ?? this.teacher,
      certificationformFirst: certificationformFirst ?? this.certificationformFirst,
      firstSemesterHours: firstSemesterHours ?? this.firstSemesterHours,
      secondSemesterHours: secondSemesterHours ?? this.secondSemesterHours,
      totalHours: totalHours ?? this.totalHours,
      srsHours: srsHours ?? this.srsHours,
      konspectHours: konspectHours ?? this.konspectHours,
      LandPHours: LandPHours ?? this.LandPHours,
      lecturesHours: lecturesHours ?? this.lecturesHours,
      practicesHours: practicesHours ?? this.practicesHours,
      lab1Hours: lab1Hours ?? this.lab1Hours,
      lab2Hours: lab2Hours ?? this.lab2Hours,
      KandPHours: KandPHours ?? this.KandPHours,
      ExamHours: ExamHours ?? this.ExamHours,
      certificationformSecond: certificationformSecond ?? this.certificationformSecond,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'load': load,
      'group': group,
      'course': course,
      'codediscipline': codediscipline,
      'teacher': teacher,
      'certificationformFirst': certificationformFirst,
      'firstSemesterHours': firstSemesterHours,
      'secondSemesterHours': secondSemesterHours,
      'totalHours': totalHours,
      'srsHours': srsHours,
      'konspectHours': konspectHours,
      'LandPHours': LandPHours,
      'lecturesHours': lecturesHours,
      'practicesHours': practicesHours,
      'lab1Hours': lab1Hours,
      'lab2Hours': lab2Hours,
      'KandPHours': KandPHours,
      'ExamHours': ExamHours,
      'certificationformSecond': certificationformSecond,
    };
  }

  factory LoadLink.fromMap(Map<String, dynamic> map) {
    return LoadLink(
      id: map['id'] as int,
      load: map['load'] != null ? map['load'] as int : null,
      group: map['group'] != null ? map['group'] as int : null,
      course: map['course'] != null ? map['course'] as int : null,
      codediscipline: map['codediscipline'] != null ? map['codediscipline'] as int : null,
      teacher: map['teacher'] != null ? map['teacher'] as int : null,
      certificationformFirst: map['certificationformFirst'] != null ? map['certificationformFirst'] as int : null,
      firstSemesterHours: map['firstSemesterHours'] != null ? map['firstSemesterHours'] as int : null,
      secondSemesterHours: map['secondSemesterHours'] != null ? map['secondSemesterHours'] as int : null,
      totalHours: map['totalHours'] != null ? map['totalHours'] as int : null,
      srsHours: map['srsHours'] != null ? map['srsHours'] as int : null,
      konspectHours: map['konspectHours'] != null ? map['konspectHours'] as int : null,
      LandPHours: map['LandPHours'] != null ? map['LandPHours'] as int : null,
      lecturesHours: map['lecturesHours'] != null ? map['lecturesHours'] as int : null,
      practicesHours: map['practicesHours'] != null ? map['practicesHours'] as int : null,
      lab1Hours: map['lab1Hours'] != null ? map['lab1Hours'] as int : null,
      lab2Hours: map['lab2Hours'] != null ? map['lab2Hours'] as int : null,
      KandPHours: map['KandPHours'] != null ? map['KandPHours'] as int : null,
      ExamHours: map['ExamHours'] != null ? map['ExamHours'] as int : null,
      certificationformSecond: map['certificationformSecond'] != null ? map['certificationformSecond'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadLink.fromJson(String source) => LoadLink.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoadLink(id: $id, load: $load, group: $group, course: $course, codediscipline: $codediscipline, teacher: $teacher, certificationformFirst: $certificationformFirst, firstSemesterHours: $firstSemesterHours, secondSemesterHours: $secondSemesterHours, totalHours: $totalHours, srsHours: $srsHours, konspectHours: $konspectHours, LandPHours: $LandPHours, lecturesHours: $lecturesHours, practicesHours: $practicesHours, lab1Hours: $lab1Hours, lab2Hours: $lab2Hours, KandPHours: $KandPHours, ExamHours: $ExamHours, certificationformSecond: $certificationformSecond)';
  }

  @override
  bool operator ==(covariant LoadLink other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.load == load &&
      other.group == group &&
      other.course == course &&
      other.codediscipline == codediscipline &&
      other.teacher == teacher &&
      other.certificationformFirst == certificationformFirst &&
      other.firstSemesterHours == firstSemesterHours &&
      other.secondSemesterHours == secondSemesterHours &&
      other.totalHours == totalHours &&
      other.srsHours == srsHours &&
      other.konspectHours == konspectHours &&
      other.LandPHours == LandPHours &&
      other.lecturesHours == lecturesHours &&
      other.practicesHours == practicesHours &&
      other.lab1Hours == lab1Hours &&
      other.lab2Hours == lab2Hours &&
      other.KandPHours == KandPHours &&
      other.ExamHours == ExamHours &&
      other.certificationformSecond == certificationformSecond;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      load.hashCode ^
      group.hashCode ^
      course.hashCode ^
      codediscipline.hashCode ^
      teacher.hashCode ^
      certificationformFirst.hashCode ^
      firstSemesterHours.hashCode ^
      secondSemesterHours.hashCode ^
      totalHours.hashCode ^
      srsHours.hashCode ^
      konspectHours.hashCode ^
      LandPHours.hashCode ^
      lecturesHours.hashCode ^
      practicesHours.hashCode ^
      lab1Hours.hashCode ^
      lab2Hours.hashCode ^
      KandPHours.hashCode ^
      ExamHours.hashCode ^
      certificationformSecond.hashCode;
  }
}
