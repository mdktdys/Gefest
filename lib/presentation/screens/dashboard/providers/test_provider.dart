import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/core/api/data/schedule/repository/test.dart';
import 'package:gefest/core/api/models/groups.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final testProvider = FutureProvider<List<Group>?>((ref) async {
  final service = GetIt.I.get<ChopperClient>().getService<FastApiService>();
  final response = await service.getGroups();
  if (response.isSuccessful) {
    // Successful request
    final body = response.body;
    return body;
  } else {
    // Error code received from server
    final code = response.statusCode;
    final error = response.error;
    GetIt.I.get<Talker>().error("${code.toString()} ${error.toString()}");
  }
  return null;
});