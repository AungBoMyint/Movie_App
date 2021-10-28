import 'package:movie_app/model/json_model/data_translate.dart';
import 'package:movie_app/model/json_parser/json_parser.dart';

class GoogleTranslateParser extends JsonParser<DataTranslate> with ObjectDecoder<DataTranslate>{
  @override
  Future<DataTranslate> parseFromJson(String json) async{
    final decodedString = decodeJson(json);
    return DataTranslate.fromJson(decodedString);
  }

}