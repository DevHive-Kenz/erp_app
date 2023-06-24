// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_result_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeListResultModel _$EmployeeListResultModelFromJson(
        Map<String, dynamic> json) =>
    EmployeeListResultModel(
      id: json['id'] as int?,
      employeeIqama: json['employee_iqama'] as String?,
      employeeName: json['employee_name'] as String?,
      company: json['company'] as int?,
      branch: json['branch'] as int?,
      user: json['user'] as int?,
    );

Map<String, dynamic> _$EmployeeListResultModelToJson(
        EmployeeListResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee_iqama': instance.employeeIqama,
      'employee_name': instance.employeeName,
      'company': instance.company,
      'branch': instance.branch,
      'user': instance.user,
    };
