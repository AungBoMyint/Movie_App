import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/model/json_model/data_object.dart';

part 'data_translate.g.dart';

@JsonSerializable(explicitToJson: true)
class DataTranslate{
  final DataObject data;
  DataTranslate(this.data);

  factory DataTranslate.fromJson(Map<String,dynamic> json) => _$DataTranslateFromJson(json);

  Map<String,dynamic> toJson() => _$DataTranslateToJson(this);
}