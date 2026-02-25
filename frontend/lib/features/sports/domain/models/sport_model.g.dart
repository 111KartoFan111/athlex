// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SportModelImpl _$$SportModelImplFromJson(Map<String, dynamic> json) =>
    _$SportModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$$SportModelImplToJson(_$SportModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'iconUrl': instance.iconUrl,
    };
