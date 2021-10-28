import 'package:json_annotation/json_annotation.dart';

part 'production_countries.g.dart';

@JsonSerializable()
class ProductionCountries {
  final String name;
  ProductionCountries(this.name);

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}
