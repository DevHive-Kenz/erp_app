// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalInvoiceModel _$TotalInvoiceModelFromJson(Map<String, dynamic> json) =>
    TotalInvoiceModel(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) =>
              TotalInvoiceResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$TotalInvoiceModelToJson(TotalInvoiceModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };
