// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      json['id'] as int,
      json['original_language'] as String,
      json['title'] as String,
      json['overview'] as String,
      (json['popularity'] as num).toDouble(),
      json['release_date'] as String,
      (json['vote_average'] as num).toDouble(),
      json['vote_count'] as int,
      json['backdrop_path'] as String?,
      json['poster_path'] as String,
      (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'original_language': instance.language,
      'title': instance.title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'release_date': instance.release_date,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'backdrop_path': instance.background_image,
      'poster_path': instance.poster_image,
      'genre_ids': instance.genre_ids,
    };
