// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_companies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionCompanies _$ProductionCompaniesFromJson(Map<String, dynamic> json) =>
    ProductionCompanies(
      json['id'] as int,
      json['logo_path'] as String?,
      json['name'] as String,
      json['origin_country'] as String,
    );

Map<String, dynamic> _$ProductionCompaniesToJson(
        ProductionCompanies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logoImage,
      'name': instance.name,
      'origin_country': instance.country,
    };
