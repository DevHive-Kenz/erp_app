// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_document_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDocumentListModel _$CompanyDocumentListModelFromJson(
        Map<String, dynamic> json) =>
    CompanyDocumentListModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => CompanyDocumentResultListModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyDocumentListModelToJson(
        CompanyDocumentListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };
