// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'containers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DockerContainerInfo _$DockerContainerInfoFromJson(Map<String, dynamic> json) =>
    DockerContainerInfo(
      name: json['name'] as String,
      status: json['status'] as String,
      image: (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      finishedAt: json['finished_at'] == null
          ? null
          : DateTime.parse(json['finished_at'] as String),
    );

Map<String, dynamic> _$DockerContainerInfoToJson(
        DockerContainerInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'image': instance.image,
      'started_at': instance.startedAt?.toIso8601String(),
      'finished_at': instance.finishedAt?.toIso8601String(),
    };

DockerInfo _$DockerInfoFromJson(Map<String, dynamic> json) => DockerInfo(
      containers: (json['containers'] as List<dynamic>)
          .map((e) => DockerContainerInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DockerInfoToJson(DockerInfo instance) =>
    <String, dynamic>{
      'containers': instance.containers,
    };
