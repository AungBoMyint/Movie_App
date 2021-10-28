import 'package:json_annotation/json_annotation.dart';

import 'genre.dart';

part 'genre_list.g.dart';

@JsonSerializable(explicitToJson: true)
class GenreList {
  final List<Genre> genres;
  GenreList(this.genres);

  factory GenreList.fromJson(Map<String, dynamic> jsonDecodeString) =>
      _$GenreListFromJson(jsonDecodeString);

  Map<String, dynamic> toJson() => _$GenreListToJson(this);
}
