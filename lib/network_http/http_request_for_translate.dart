import 'package:dio/dio.dart';
import 'package:movie_app/model/json_parser/json_parser.dart';

class HTTPTranslate{
  final Map<String,dynamic> data;
  HTTPTranslate({required this.data});

  ///Dio Instance For All Request
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://google-translate1.p.rapidapi.com/language/translate/v2",
      connectTimeout: 6000,
      headers:{
        'content-type': 'application/x-www-form-urlencoded',
        'accept-encoding': 'application/gzip',
        'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
        'x-rapidapi-key': '22424f4dc6msha036b20937f0009p1a5855jsn6ba235708d97'
      },
    )
  )..interceptors.add(InterceptorsWrapper(
    onRequest: (err,handler){
      handler.next(err);
    }
  ));

  ///Actual Post Request From API
  Future<T> executePost<T>(JsonParser<T> parser) async{
    final response = await dio.post<String>('',data: data);
    return parser.parseFromJson(response.data ?? "");
  }
}