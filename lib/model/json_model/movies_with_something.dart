import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movies_with_something.g.dart';

@JsonSerializable(explicitToJson: true)
class MoviesWithSomething {
  final int page;
  final List<Movie> results;
  final int total_pages;
  MoviesWithSomething(this.page, this.results, this.total_pages);

  factory MoviesWithSomething.fromJson(Map<String, dynamic> json) =>
      _$MoviesWithSomethingFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesWithSomethingToJson(this);
}
