// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_list_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchListResultModel _$BranchListResultModelFromJson(
        Map<String, dynamic> json) =>
    BranchListResultModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      company: json['company'] as int?,
    );

Map<String, dynamic> _$BranchListResultModelToJson(
        BranchListResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'company': instance.company,
    };
