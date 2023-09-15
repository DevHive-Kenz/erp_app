// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_unit_conversion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductUnitConversionDataModel _$ProductUnitConversionDataModelFromJson(
        Map<String, dynamic> json) =>
    ProductUnitConversionDataModel(
      qty: json['qty'] as String?,
      price: json['price'] as String?,
      toUnit: json['to_unit'] as String?,
      barcode: json['barcode'] as List<dynamic>?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ProductItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductUnitConversionDataModelToJson(
        ProductUnitConversionDataModel instance) =>
    <String, dynamic>{
      'qty': instance.qty,
      'price': instance.price,
      'to_unit': instance.toUnit,
      'barcode': instance.barcode,
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };
