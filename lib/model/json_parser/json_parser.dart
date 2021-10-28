library json_parser;

import 'dart:convert';

export 'gener_parser.dart';
export 'movies_with_something_parser.dart';

abstract class JsonParser<T> {
  const JsonParser();

  Future<T> parseFromJson(String json);
}

mixin ObjectDecoder<T> on JsonParser<T> {
  Map<String, dynamic> decodeJson(String json) =>
      jsonDecode(json) as Map<String, dynamic>;
}

mixin ListDecoder<T> on JsonParser<T> {
  List<dynamic> decodeJson(String json) => jsonDecode(json) as List<dynamic>;
}
