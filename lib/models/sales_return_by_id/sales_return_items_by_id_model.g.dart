// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_items_by_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnByIdItemModel _$SalesReturnByIdItemModelFromJson(
        Map<String, dynamic> json) =>
    SalesReturnByIdItemModel(
      id: json['id'] as int?,
      saleId: json['sale_id'] as int?,
      item: json['item'] as String?,
      unit: json['unit'] as String?,
      price: json['price'] as num?,
      quantity: json['quantity'] as num?,
      tax: json['tax'] as num?,
      taxAmount: json['tax_amount'] as num?,
      discount: json['discount'] as num?,
      discountAmount: json['discount_amount'] as num?,
      totalAmount: json['total_amount'] as num?,
    );

Map<String, dynamic> _$SalesReturnByIdItemModelToJson(
        SalesReturnByIdItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sale_id': instance.saleId,
      'item': instance.item,
      'unit': instance.unit,
      'price': instance.price,
      'quantity': instance.quantity,
      'tax': instance.tax,
      'tax_amount': instance.taxAmount,
      'discount': instance.discount,
      'discount_amount': instance.discountAmount,
      'total_amount': instance.totalAmount,
    };
