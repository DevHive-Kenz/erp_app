// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_document_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDocumentListModel _$VehicleDocumentListModelFromJson(
        Map<String, dynamic> json) =>
    VehicleDocumentListModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => VehicleDocumentListResultModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VehicleDocumentListModelToJson(
        VehicleDocumentListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };
