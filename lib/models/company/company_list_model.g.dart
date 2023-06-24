// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyListModel _$CompanyListModelFromJson(Map<String, dynamic> json) =>
    CompanyListModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CompanyListResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyListModelToJson(CompanyListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result?.map((e) => e?.toJson()).toList(),
    };
