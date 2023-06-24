// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeListModel _$EmployeeListModelFromJson(Map<String, dynamic> json) =>
    EmployeeListModel(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) =>
              EmployeeListResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$EmployeeListModelToJson(EmployeeListModel instance) =>
    <String, dynamic>{
      'result': instance.result?.map((e) => e.toJson()).toList(),
      'message': instance.message,
      'status': instance.status,
    };
