// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_document_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDocumentListModel _$EmployeeDocumentListModelFromJson(
        Map<String, dynamic> json) =>
    EmployeeDocumentListModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => EmployeeDocumentListResultModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeDocumentListModelToJson(
        EmployeeDocumentListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };
