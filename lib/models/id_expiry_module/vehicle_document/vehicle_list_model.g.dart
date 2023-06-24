// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleListModel _$VehicleListModelFromJson(Map<String, dynamic> json) =>
    VehicleListModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map(
              (e) => VehicleListResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VehicleListModelToJson(VehicleListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };
