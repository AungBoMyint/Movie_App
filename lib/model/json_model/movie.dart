import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final int id;
  @JsonKey(name: "original_language")
  final String language;
  final String title;
  final String overview;
  final double popularity;
  @JsonKey()
  final String release_date;
  final double vote_average;
  final int vote_count;
  @JsonKey(name: "backdrop_path", includeIfNull: true)
  final String? background_image;
  @JsonKey(name: "poster_path")
  final String poster_image;
  final List<int> genre_ids;
  Movie(
      this.id,
      this.language,
      this.title,
      this.overview,
      this.popularity,
      this.release_date,
      this.vote_average,
      this.vote_count,
      this.background_image,
      this.poster_image,
      this.genre_ids);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
