

import 'package:movie_app/model/json_model/credit.dart';

import 'json_parser.dart';

class CreditPraser extends JsonParser<Credit> with ObjectDecoder<Credit> {
  @override
  Future<Credit> parseFromJson(String json) async {
    final decodedJson = decodeJson(json);
    return Credit.fromJson(decodedJson);
  }
}
