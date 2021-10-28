import 'package:json_annotation/json_annotation.dart';

part 'spoken_language.g.dart';

@JsonSerializable()
class SpokenLanguage {
  @JsonKey(name: "english_name")
  final String longName;
  @JsonKey(name: "iso_639_1")
  final String shortName;
  SpokenLanguage(this.longName, this.shortName);

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}
