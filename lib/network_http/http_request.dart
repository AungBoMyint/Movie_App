import 'dart:async';

import 'package:dio/dio.dart';
import 'package:movie_app/model/json_parser/json_parser.dart';

class HTTPRequest {
  //Required for endPoint
  final String endPoint;
  final Map<String, dynamic> data;
  final Map<String, dynamic> extraQuery;
  HTTPRequest(
      {required this.endPoint,
      this.data = const {},
      this.extraQuery = const {}});

  final dio = new Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    connectTimeout: 10000,
    queryParameters: <String, String>{
      "api_key": "656ce03db4ce4f667a5d2e9566646040"
    },
  ))
    ..interceptors.add(InterceptorsWrapper(onError: (err, handler) {
      handler.next(err);
    }));

  //single baseUrl and other data for every request

  Future<T> executeGet<T>(JsonParser<T> parser) async {
    final response =
        await dio.get<String>(endPoint, queryParameters: extraQuery);
    return parser.parseFromJson(response.data ?? "");
  }

  Future<T> executePost<T>(JsonParser<T> parser) async {
    final response = await dio.post<String>(endPoint, data: data);
    return parser.parseFromJson(response.data ?? "");
  }
}
