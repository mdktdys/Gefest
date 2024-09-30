import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:gefest/core/api/api.dart';

part 'test.chopper.dart';

@ChopperApi(baseUrl: "/api/v1/groups/")
abstract class FastApiService extends ChopperService {
  static FastApiService create([ChopperClient? client]) => 
      _$FastApiService(client);


  @Get()
  Future<Response<List<Group>>> getGroups();
}