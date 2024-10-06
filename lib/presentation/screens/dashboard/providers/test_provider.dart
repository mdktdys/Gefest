import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/schedule/repository/test.dart';
import 'package:gefest/core/api/models/DTO/containers.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final testProvider = FutureProvider<DockerInfo?>((ref) async {
  final service = GetIt.I.get<ChopperClient>().getService<FastApiService>();
  final response = await service.getContainersList();
  if (response.isSuccessful) {
    final body = response.body;
    return body;
  } else {
    final code = response.statusCode;
    final error = response.error;
    GetIt.I.get<Talker>().error("${code.toString()} ${error.toString()}");
  }
  return null;
});