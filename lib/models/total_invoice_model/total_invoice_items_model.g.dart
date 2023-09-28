// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_invoice_items_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalInvoiceItemsModel _$TotalInvoiceItemsModelFromJson(
        Map<String, dynamic> json) =>
    TotalInvoiceItemsModel(
      id: json['id'] as int?,
      saleId: json['sale_id'] as int?,
      item: json['item'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TotalInvoiceItemsModelToJson(
        TotalInvoiceItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sale_id': instance.saleId,
      'item': instance.item,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'price': instance.price,
      'tax': instance.tax,
      'tax_amount': instance.taxAmount,
      'discount': instance.discount,
      'discount_amount': instance.discountAmount,
      'total_amount': instance.totalAmount,
    };
