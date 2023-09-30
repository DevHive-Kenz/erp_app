// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_invoice_customer_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalInvoiceCustomerDataModel _$TotalInvoiceCustomerDataModelFromJson(
        Map<String, dynamic> json) =>
    TotalInvoiceCustomerDataModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      date: json['date'] as String?,
      name: json['name'] as String?,
      nameA: json['name_a'] as String?,
      address1: json['address1'] as String?,
      address1A: json['address1_a'] as String?,
      address2: json['address2'] as String?,
      address2A: json['address2_a'] as String?,
      crnNumber: json['crn_number'] as String?,
      vatNumber: json['vat_number'] as String?,
      isCustomer: json['is_customer'] as bool?,
      isVendor: json['is_vendor'] as bool?,
      isEmployee: json['is_employee'] as bool?,
      isRep: json['is_rep'] as bool?,
      regionId: json['region_id'] as int?,
      repId: json['rep_id'] as int?,
      taxId: json['tax_id'] as String?,
      groupId: json['group_id'] as int?,
    );

Map<String, dynamic> _$TotalInvoiceCustomerDataModelToJson(
        TotalInvoiceCustomerDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'date': instance.date,
      'name': instance.name,
      'name_a': instance.nameA,
      'address1': instance.address1,
      'address1_a': instance.address1A,
      'address2': instance.address2,
      'address2_a': instance.address2A,
      'crn_number': instance.crnNumber,
      'vat_number': instance.vatNumber,
      'is_customer': instance.isCustomer,
      'is_vendor': instance.isVendor,
      'is_employee': instance.isEmployee,
      'is_rep': instance.isRep,
      'region_id': instance.regionId,
      'rep_id': instance.repId,
      'tax_id': instance.taxId,
      'group_id': instance.groupId,
    };
