import 'package:movie_app/model/json_model/genre_list.dart';

import 'json_parser.dart';


class GenreParser extends JsonParser<GenreList> with ObjectDecoder<GenreList> {
  @override
  Future<GenreList> parseFromJson(String json) async {
    final decodedJson = decodeJson(json);
    return GenreList.fromJson(decodedJson);
  }
}
