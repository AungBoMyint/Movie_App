// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_with_something.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesWithSomething _$MoviesWithSomethingFromJson(Map<String, dynamic> json) =>
    MoviesWithSomething(
      json['page'] as int,
      (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['total_pages'] as int,
    );

Map<String, dynamic> _$MoviesWithSomethingToJson(
        MoviesWithSomething instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.total_pages,
    };
