// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnModel _$SalesReturnModelFromJson(Map<String, dynamic> json) =>
    SalesReturnModel(
      result: (json['result'] as List<dynamic>?)
          ?.map(
              (e) => SalesReturnResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$SalesReturnModelToJson(SalesReturnModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };
