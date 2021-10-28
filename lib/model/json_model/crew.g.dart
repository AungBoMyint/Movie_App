// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
      json['department'] as String,
      json['name'] as String,
      json['profile_path'] as String?,
      json['credit_id'] as String,
    );

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      'department': instance.department,
      'name': instance.name,
      'profile_path': instance.profileImage,
      'credit_id': instance.creditId,
    };
