import 'package:json_annotation/json_annotation.dart';

part 'cast.g.dart';

@JsonSerializable()
class Cast {
  final String name;
  @JsonKey(name: "profile_path", includeIfNull: true)
  final String? profileImage;
  final String character;
  @JsonKey(name: "credit_id")
  final String creditId;
  Cast(this.name, this.profileImage, this.character, this.creditId);

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}
