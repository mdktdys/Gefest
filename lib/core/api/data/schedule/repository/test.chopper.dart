// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$FastApiService extends FastApiService {
  _$FastApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = FastApiService;

  @override
  Future<Response<List<Group>>> getGroups() {
    final Uri $url = Uri.parse('/api/v1/groups/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Group>, Group>($request);
  }

  @override
  Future<Response<DockerInfo>> getContainersList() {
    final Uri $url = Uri.parse('/api/v1/parser/containers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DockerInfo, DockerInfo>($request);
  }
}
