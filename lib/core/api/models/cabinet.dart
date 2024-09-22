// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gefest/core/api/api.dart';

class Cabinet extends SearchItem {
  final int id;
  final String name;
  final List<String> synonyms;

  Cabinet({required this.id, required this.name, required this.synonyms}) : super(searchText: name, type: SearchType.cabinet, searchID: id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'synonyms': synonyms,
    };
  }

  factory Cabinet.fromMap(Map<String, dynamic> map) {
    return Cabinet(
        id: map['id'] as int,
        name: map['name'] as String,
        synonyms: List<String>.from(
          (map['synonyms'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Cabinet.fromJson(String source) =>
      Cabinet.fromMap(json.decode(source) as Map<String, dynamic>);
}
