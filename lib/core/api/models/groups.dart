// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gefest/core/api/data/schedule/types.dart';
import 'package:gefest/core/api/models/search.dart';

class Group extends SearchItem {
  final int id;
  final String name;
  final String? image;
  final int department;

  Group({
    required this.id,
    required this.name,
    required this.department,
    required this.image,
  }) : super(
    searchText: name,
    type: SearchType.group,
    searchID: id
  );

  factory Group.mock() {
    return Group(
      id: -1,
      name: 'name',
      department:1,
      image: 'image'
    );
  }

  factory Group.create({
    required final String name,
    final String? image,
    final int? departmentId,
  }) {
    return Group(
      id: -1,
      name: name,
      department: departmentId ?? -1,
      image: image
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'department': department,
      'image': image
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as int,
      name: map['name'] as String,
      department: map['department'] as int,
      image: map['image'] as String?
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source) as Map<String, dynamic>);
}
