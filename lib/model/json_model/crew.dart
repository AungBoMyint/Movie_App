import 'package:json_annotation/json_annotation.dart';

part 'crew.g.dart';

@JsonSerializable()
class Crew {
  final String department;
  final String name;
  @JsonKey(name: "profile_path", includeIfNull: true)
  final String? profileImage;
  @JsonKey(name: "credit_id")
  final String creditId;
  Crew(this.department, this.name, this.profileImage, this.creditId);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);
}
