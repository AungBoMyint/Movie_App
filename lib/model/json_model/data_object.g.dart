// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataObject _$DataObjectFromJson(Map<String, dynamic> json) => DataObject(
      (json['translations'] as List<dynamic>)
          .map((e) => TranslateText.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataObjectToJson(DataObject instance) =>
    <String, dynamic>{
      'translations': instance.translations.map((e) => e.toJson()).toList(),
    };
