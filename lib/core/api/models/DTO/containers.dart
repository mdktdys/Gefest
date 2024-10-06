// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'containers.g.dart';

@JsonSerializable()
class DockerContainerInfo {
  final String name;
  final String status;
  final List<String> image;
  final DateTime? startedAt;
  final DateTime? finishedAt;

  DockerContainerInfo({
    required this.name,
    required this.status,
    required this.image,
    required this.startedAt,
    this.finishedAt,
  });

  // Метод для десериализации из JSON
  factory DockerContainerInfo.fromJson(Map<String, dynamic> json) =>
      _$DockerContainerInfoFromJson(json);

  // Метод для сериализации в JSON
  Map<String, dynamic> toJson() => _$DockerContainerInfoToJson(this);
}

@JsonSerializable()
class DockerInfo{
  final List<DockerContainerInfo> containers;

  DockerInfo({required this.containers});

  // Метод для десериализации из JSON
  factory DockerInfo.fromJson(Map<String, dynamic> json) =>
      _$DockerInfoFromJson(json);

  // Метод для сериализации в JSON
  Map<String, dynamic> toJson() => _$DockerInfoToJson(this);
  
  fromJson<T>(data) {
    return 
      _$DockerInfoFromJson(data);
  }

}
