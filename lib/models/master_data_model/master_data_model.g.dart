// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterDataModel _$MasterDataModelFromJson(Map<String, dynamic> json) =>
    MasterDataModel(
      result: json['result'] == null
          ? null
          : MasterDataResultModel.fromJson(
              json['result'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$MasterDataModelToJson(MasterDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result?.toJson(),
    };
