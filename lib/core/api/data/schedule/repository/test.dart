// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:core';
import 'package:chopper/chopper.dart';

import 'package:gefest/core/api/api.dart';
import 'package:gefest/core/api/models/DTO/containers.dart';
import 'package:gefest/secrets.dart';

part 'test.chopper.dart';

class MyRequestInterceptor implements Interceptor {
  MyRequestInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final request = applyHeaders(chain.request,
        {'X-API-KEY': API_KEY, 'Access-Control-Allow-Origin': '*'});
    return chain.proceed(request);
  }
}

@ChopperApi(baseUrl: "/api/v1/")
abstract class FastApiService extends ChopperService {
  static FastApiService create([ChopperClient? client]) =>
      _$FastApiService(client);

  @Get(path: "/groups/")
  Future<Response<List<Group>>> getGroups();

  @Get(path: "/parser/containers")
  Future<Response<DockerInfo>> getContainersList();
}


typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> factories;

  const JsonSerializableConverter(this.factories);

  T? _decodeMap<T>(Map<String, dynamic> values) {
    /// Get jsonFactory using Type parameters
    /// if not found or invalid, throw error or return null
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      /// throw serializer not found error;
      return null;
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v)).toList();

  dynamic _decode<T>(entity) {
    if (entity is Iterable) return _decodeList<T>(entity as List);

    if (entity is Map) return _decodeMap<T>(entity as Map<String, dynamic>);

    return entity;
  }

  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
    Response response,
  ) async {
    // use [JsonConverter] to decode json
    final jsonRes = await super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(body: _decode<Item>(jsonRes.body));
  }

  @override
  // all objects should implements toJson method
  // ignore: unnecessary_overrides
  Request convertRequest(Request request) => super.convertRequest(request);

  @override
  FutureOr<Response> convertError<ResultType, Item>(Response response) async {
    // use [JsonConverter] to decode json
    final jsonRes = await super.convertError(response);
    return jsonRes;
    // return jsonRes.copyWith<ResourceEr>(
    //   body: ResourceError.fromJsonFactory(jsonRes.body),
    // );
  }
}

// List<T> parse<T>(
//         Map<String, dynamic> data, T Function(Map<String, dynamic>) builder) {
//           log(data.toString());
//           final res = List.generate(data.length, (i) => builder(data[i]));
//           return res;
//         }
