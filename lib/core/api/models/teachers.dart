// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gefest/core/api/data/schedule/types.dart';
import 'package:gefest/core/api/models/search.dart';

class Teacher extends SearchItem {
  final int id;
  final String? name;
  final String? image;
  final List<String> synonyms;

  factory Teacher.create({
    required String name,
    String? image
  }) {
    return Teacher(
      id: -1,
      name: name,
      image: image,
      synonyms: []
    );
  }

  Teacher({
    required this.id,
    required this.name,
    required this.synonyms,
    required this.image,
  }) : super(
    searchText: name ?? '',
    searchID: id,
    type: SearchType.teacher
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
        id: map['id'] as int,
        name: map['name'] != null ? map['name'] as String : null,
        image: map['image'] != null ? map['image'] as String : null,
        synonyms: List<String>.from(
          (map['synonyms'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source) as Map<String, dynamic>);
}
