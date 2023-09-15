// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_base_price_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductBasePriceDataModel _$ProductBasePriceDataModelFromJson(
        Map<String, dynamic> json) =>
    ProductBasePriceDataModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      baseLow: json['base_low'] as String?,
      baseMax: json['base_max'] as String?,
      baseStandard: json['base_standard'] as String?,
    );

Map<String, dynamic> _$ProductBasePriceDataModelToJson(
        ProductBasePriceDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'base_low': instance.baseLow,
      'base_max': instance.baseMax,
      'base_standard': instance.baseStandard,
    };
