import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/model/json_model/production_companies.dart';
import 'package:movie_app/model/json_model/production_countries.dart';
import 'package:movie_app/model/json_model/spoken_language.dart';

import 'genre.dart';

part 'detail_movie.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailMovie {
  final int budget;
  final List<Genre> genres;
  @JsonKey(name: "homepage")
  final String homeUrl;
  @JsonKey(name: "production_companies")
  final List<ProductionCompanies> productionCompanies;
  @JsonKey(name: "production_countries")
  final List<ProductionCountries> productionCountries;
  final int revenue;
  @JsonKey(name: "spoken_languages")
  final List<SpokenLanguage> spokenLanguages;
  DetailMovie(this.budget, this.genres, this.homeUrl, this.productionCompanies,
      this.productionCountries, this.revenue, this.spokenLanguages);

  factory DetailMovie.fromJson(Map<String, dynamic> json) =>
      _$DetailMovieFromJson(json);

  Map<String, dynamic> toJson() => _$DetailMovieToJson(this);
}
