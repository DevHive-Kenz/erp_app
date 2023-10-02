// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data_values_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDataValueModel _$MasterDataValueModelFromJson(
        Map<String, dynamic> json) =>
    MasterDataValueModel(
      id: json['id'] as int?,
      user: json['user'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MasterDataValueModelToJson(
        MasterDataValueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
    };
