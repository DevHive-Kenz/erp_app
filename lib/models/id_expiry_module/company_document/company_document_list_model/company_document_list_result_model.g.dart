// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_document_list_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDocumentResultListModel _$CompanyDocumentResultListModelFromJson(
        Map<String, dynamic> json) =>
    CompanyDocumentResultListModel(
      id: json['id'] as int?,
      documentType: json['document_type'] as String?,
      documentNumber: json['document_number'] as String?,
      expiry: json['expiry'] as String?,
      company: json['company'] as int?,
      branch: json['branch'] as int?,
    );

Map<String, dynamic> _$CompanyDocumentResultListModelToJson(
        CompanyDocumentResultListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_type': instance.documentType,
      'document_number': instance.documentNumber,
      'expiry': instance.expiry,
      'company': instance.company,
      'branch': instance.branch,
    };
