import 'package:json_annotation/json_annotation.dart';

part 'production_companies.g.dart';

@JsonSerializable()
class ProductionCompanies {
  final int id;
  @JsonKey(name: "logo_path", includeIfNull: true)
  final String? logoImage;
  final String name;
  @JsonKey(name: "origin_country")
  final String country;
  ProductionCompanies(this.id, this.logoImage, this.name, this.country);

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}
