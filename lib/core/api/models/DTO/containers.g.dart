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
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
    );

Map<String, dynamic> _$DockerContainerInfoToJson(
        DockerContainerInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'image': instance.image,
      'startedAt': instance.startedAt?.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
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
