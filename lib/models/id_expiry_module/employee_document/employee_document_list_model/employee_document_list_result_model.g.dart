// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_document_list_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDocumentListResultModel _$EmployeeDocumentListResultModelFromJson(
        Map<String, dynamic> json) =>
    EmployeeDocumentListResultModel(
      id: json['id'] as int?,
      documentType: json['document_type'] as String?,
      documentNumber: json['document_number'] as String?,
      expiry: json['expiry'] as String?,
      company: json['company'] as int?,
      branch: json['branch'] as int?,
      employee: json['employee'] as int?,
    );

Map<String, dynamic> _$EmployeeDocumentListResultModelToJson(
        EmployeeDocumentListResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_type': instance.documentType,
      'document_number': instance.documentNumber,
      'expiry': instance.expiry,
      'company': instance.company,
      'branch': instance.branch,
      'employee': instance.employee,
    };
