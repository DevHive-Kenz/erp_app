// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResultModel _$ProductResultModelFromJson(Map<String, dynamic> json) =>
    ProductResultModel(
      id: json['id'] as int?,
      baseUnitName: json['base_unit_name'] as String?,
      sku: json['sku'] as String?,
      added: json['added'] == null
          ? null
          : DateTime.parse(json['added'] as String),
      userID: json['user_id'] as int?,
      name: json['name'] as String?,
      nameArabic: json['name_arabic'] as String?,
      image: json['image'] as String?,
      categoryId: json['category_id'] as int?,
      itemCode: json['item_code'] as String?,
      baseUnitId: json['base_unit_id'] as int?,
      taxCategoryId: json['tax_category_id'] as int?,
      blnActive: json['bln_active'] as bool?,
      blnStocked: json['bln_stocked'] as bool?,
      blnManufactured: json['bln_manufactured'] as bool?,
      blnPurchased: json['bln_purchased'] as bool?,
      blnSold: json['bln_sold'] as bool?,
      productTypeId: json['product_type_id'] as int?,
      discountType: json['discount_type'] as String?,
      discount: json['discount'] as num?,
      discountedPrice: json['discounted_price'] as num?,
      price: json['price'] as num?,
      barCode: json['bar_code'] as List<dynamic>?,
      basePriceData: (json['base_price_data'] as List<dynamic>?)
          ?.map((e) => ProductItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitConversionData: (json['unit_conversion_data'] as List<dynamic>?)
          ?.map((e) => ProductUnitConversionDataModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResultModelToJson(ProductResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'added': instance.added?.toIso8601String(),
      'user_id': instance.userID,
      'name': instance.name,
      'name_arabic': instance.nameArabic,
      'image': instance.image,
      'category_id': instance.categoryId,
      'item_code': instance.itemCode,
      'base_unit_id': instance.baseUnitId,
      'base_unit_name': instance.baseUnitName,
      'tax_category_id': instance.taxCategoryId,
      'bln_active': instance.blnActive,
      'bln_stocked': instance.blnStocked,
      'bln_manufactured': instance.blnManufactured,
      'bln_purchased': instance.blnPurchased,
      'bln_sold': instance.blnSold,
      'product_type_id': instance.productTypeId,
      'discount_type': instance.discountType,
      'discount': instance.discount,
      'discounted_price': instance.discountedPrice,
      'price': instance.price,
      'bar_code': instance.barCode,
      'base_price_data':
          instance.basePriceData?.map((e) => e.toJson()).toList(),
      'unit_conversion_data':
          instance.unitConversionData?.map((e) => e.toJson()).toList(),
    };
