import 'package:json_annotation/json_annotation.dart';

import 'package:gefest/core/api/models/entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
part 'department_model.g.dart';

@JsonSerializable()
class Department implements Entity {
  int id;
  String name;

  Department({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  factory Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
  
  @override
  String get displayName => name;
}

