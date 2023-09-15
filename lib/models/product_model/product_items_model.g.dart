// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItemsModel _$ProductItemsModelFromJson(Map<String, dynamic> json) =>
    ProductItemsModel(
      lowLimitPrice: json['low_limit_price'] as String?,
      maxLimitPrice: json['max_limit_price'] as String?,
      standardLimitPrice: json['standard_limit_price'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ProductItemsModelToJson(ProductItemsModel instance) =>
    <String, dynamic>{
      'low_limit_price': instance.lowLimitPrice,
      'max_limit_price': instance.maxLimitPrice,
      'standard_limit_price': instance.standardLimitPrice,
      'id': instance.id,
    };
