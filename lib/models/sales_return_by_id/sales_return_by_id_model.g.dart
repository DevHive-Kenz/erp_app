// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_by_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnByIDModel _$SalesReturnByIDModelFromJson(
        Map<String, dynamic> json) =>
    SalesReturnByIDModel(
      result: json['result'] == null
          ? null
          : SalesReturnByIdResultModel.fromJson(
              json['result'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$SalesReturnByIDModelToJson(
        SalesReturnByIDModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result?.toJson(),
    };
