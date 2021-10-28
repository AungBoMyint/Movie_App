import 'package:json_annotation/json_annotation.dart';

part 'translate_text.g.dart';
@JsonSerializable()
class TranslateText{
  final String translatedText;
  TranslateText(this.translatedText);

  factory TranslateText.fromJson(Map<String,dynamic> json) => _$TranslateTextFromJson(json);

  Map<String,dynamic> toJson() => _$TranslateTextToJson(this);
}