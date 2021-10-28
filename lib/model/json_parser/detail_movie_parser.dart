import 'json_parser.dart';
import 'package:movie_app/model/json_model/detail_movie.dart';

class DetailMovieParser extends JsonParser<DetailMovie>
    with ObjectDecoder<DetailMovie> {
  @override
  Future<DetailMovie> parseFromJson(String json) async {
    final decodedJson = decodeJson(json);
    return DetailMovie.fromJson(decodedJson);
  }
}
