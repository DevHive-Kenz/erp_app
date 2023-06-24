// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_document_list_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDocumentListResultModel _$VehicleDocumentListResultModelFromJson(
        Map<String, dynamic> json) =>
    VehicleDocumentListResultModel(
      id: json['id'] as int?,
      documentType: json['document_type'] as String?,
      documentId: json['document_id'] as String?,
      expiry: json['expiry'] as String?,
      company: json['company'] as int?,
      branch: json['branch'] as int?,
      vehicle: json['vehicle'] as int?,
    );

Map<String, dynamic> _$VehicleDocumentListResultModelToJson(
        VehicleDocumentListResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_type': instance.documentType,
      'document_id': instance.documentId,
      'expiry': instance.expiry,
      'company': instance.company,
      'branch': instance.branch,
      'vehicle': instance.vehicle,
    };
