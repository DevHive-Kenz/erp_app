// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnResultModel _$SalesReturnResultModelFromJson(
        Map<String, dynamic> json) =>
    SalesReturnResultModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      soldToId: json['sold_to_id'] as int?,
      printType: json['print_type'] as String?,
      imageFile: json['image_file'] as String?,
      documentFile: json['document_file'] as String?,
      invoiceId: json['invoice_id'] as int?,
      paymentType: json['payment_type'] as int?,
      amount: json['amount'] as num?,
      totalTax: json['total_tax'] as num?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      quotationId: json['quotation_id'] as int?,
      supplyDate: json['supply_date'] == null
          ? null
          : DateTime.parse(json['supply_date'] as String),
      contractNumber: json['contract_number'] as String?,
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      invoicePeriod: json['invoice_period'] as String?,
      referenceNumber: json['reference_number'] as String?,
      preparedBy: json['prepared_by'] as String?,
      approvedBy: json['approved_by'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SalesReturnItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesReturnResultModelToJson(
        SalesReturnResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'sold_to_id': instance.soldToId,
      'print_type': instance.printType,
      'image_file': instance.imageFile,
      'document_file': instance.documentFile,
      'invoice_id': instance.invoiceId,
      'payment_type': instance.paymentType,
      'amount': instance.amount,
      'total_tax': instance.totalTax,
      'date': instance.date?.toIso8601String(),
      'quotation_id': instance.quotationId,
      'supply_date': instance.supplyDate?.toIso8601String(),
      'contract_number': instance.contractNumber,
      'due_date': instance.dueDate?.toIso8601String(),
      'invoice_period': instance.invoicePeriod,
      'reference_number': instance.referenceNumber,
      'prepared_by': instance.preparedBy,
      'approved_by': instance.approvedBy,
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };
