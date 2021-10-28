import 'json_parser.dart';
import 'package:movie_app/model/model.dart';

class MoviesWithSomethingParser extends JsonParser<MoviesWithSomething>
    with ObjectDecoder<MoviesWithSomething> {
  @override
  Future<MoviesWithSomething> parseFromJson(String json) async {
    final result = decodeJson(json);
    return MoviesWithSomething.fromJson(result);
  }
}
