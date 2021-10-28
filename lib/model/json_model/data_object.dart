import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/model/json_model/translate_text.dart';

part 'data_object.g.dart';
@JsonSerializable(explicitToJson: true)
class DataObject{
  final List<TranslateText> translations;
  DataObject(this.translations);

  factory DataObject.fromJson(Map<String,dynamic> json) => _$DataObjectFromJson(json);

  Map<String,dynamic> toJson() => _$DataObjectToJson(this);
}