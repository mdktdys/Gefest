import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:gefest/core/api/api.dart';
import 'package:gefest/secrets.dart';

part 'test.chopper.dart';

const apiHeaders = {"X-API-KEY": API_KEY};

class MyRequestInterceptor implements Interceptor {
  
  MyRequestInterceptor();
  
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final request = applyHeader(chain.request, 'X-API-KEY', API_KEY);
    return chain.proceed(request);
  }
}

@ChopperApi(baseUrl: "/api/v1/")
abstract class FastApiService extends ChopperService {
  static FastApiService create([ChopperClient? client]) => 
      _$FastApiService(client);


  @Get(path: "/groups",headers: apiHeaders)
  Future<Response<List<Group>>> getGroups();


  @Get(path: "/parser/containers")
  Future<Response<DockerContainersList>> getContainersList();
}

class DockerContainersList {
  final List<DockerContainerInfo> containers;

  DockerContainersList({required this.containers});

  factory DockerContainersList.fromJson(List<dynamic> json) {
    List<DockerContainerInfo> containerList = json
        .map((container) => DockerContainerInfo.fromJson(container))
        .toList();

    return DockerContainersList(containers: containerList);
  }

  List<Map<String, dynamic>> toJson() {
    return containers.map((container) => container.toJson()).toList();
  }
}

class DockerContainerInfo {
  final String name;
  final String status;
  final List<String> image;
  final DateTime startedAt;
  final DateTime? finishedAt;

  DockerContainerInfo({
    required this.name,
    required this.status,
    required this.image,
    required this.startedAt,
    this.finishedAt,
  });

  factory DockerContainerInfo.fromJson(Map<String, dynamic> json) {
    return DockerContainerInfo(
      name: json['name'],
      status: json['status'],
      image: List<String>.from(json['image']),
      startedAt: DateTime.parse(json['started_at']),
      finishedAt: json['finished_at'] != null
          ? DateTime.parse(json['finished_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'image': image,
      'started_at': startedAt.toIso8601String(),
      'finished_at': finishedAt?.toIso8601String(),
    };
  }
}