// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_result_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleListResultModel _$VehicleListResultModelFromJson(
        Map<String, dynamic> json) =>
    VehicleListResultModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      numberPlate: json['number_plate'] as String?,
      model: json['model'] as String?,
      year: json['year'] as int?,
      company: json['company'] as int?,
      branch: json['branch'] as int?,
    );

Map<String, dynamic> _$VehicleListResultModelToJson(
        VehicleListResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number_plate': instance.numberPlate,
      'model': instance.model,
      'year': instance.year,
      'company': instance.company,
      'branch': instance.branch,
    };
