// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchListModel _$BranchListModelFromJson(Map<String, dynamic> json) =>
    BranchListModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BranchListResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BranchListModelToJson(BranchListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result?.map((e) => e?.toJson()).toList(),
    };
