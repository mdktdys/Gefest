// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gefest/core/api/api.dart';

class Course extends SearchItem {
  final int id;
  final String? name;
  final String color;
  final String? fullname;
  final List<String> synonyms;

  Course(
      {required this.id,
      required this.name,
      required this.color,
      required this.fullname,
      required this.synonyms}) : super(searchText: fullname??name??'', type: SearchType.course, searchID: id);

  Color getColor() {
    final color = this.color.split(',');
    return Color.fromARGB(int.parse(color[0]), int.parse(color[1]),
        int.parse(color[2]), int.parse(color[3]));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color,
      'fullname': fullname,
      'synonyms': synonyms,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
        id: map['id'] as int,
        name: map['name'] != null ? map['name'] as String : null,
        color: map['color'] as String,
        fullname: map['fullname'] != null ? map['fullname'] as String : null,
        synonyms: List<String>.from(
          (map['synonyms'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);
}
