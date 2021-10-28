import 'json_parser.dart';
import 'package:movie_app/model/model.dart';

class VideoListParser extends JsonParser<VideoList>
    with ObjectDecoder<VideoList> {
  @override
  Future<VideoList> parseFromJson(String json) async {
    final decodedJson = decodeJson(json);
    return VideoList.fromJson(decodedJson);
  }
}
