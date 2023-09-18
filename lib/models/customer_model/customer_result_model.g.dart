// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerResultModel _$CustomerResultModelFromJson(Map<String, dynamic> json) =>
    CustomerResultModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      user: json['user'] as int?,
      nameArabic: json['name_a'] as String?,
      address1: json['address1'] as String?,
      address1A: json['address1_a'] as String?,
      address2: json['address2'] as String?,
      address2A: json['address2_a'] as String?,
      crnNumber: json['crn_number'] as String?,
      isCustomer: json['is_customer'] as bool?,
      vatNumber: json['vat_number'] as String?,
      isVendor: json['is_vendor'] as bool?,
      isEmployee: json['is_employee'] as bool?,
      isRep: json['is_rep'] as bool?,
      routeId: json['route'] as int?,
      regionId: json['region'] as int?,
      repId: json['rep'] as int?,
      taxId: json['tax_id'] as String?,
      groupId: json['group'] as int?,
      priceList: json['price_list'] as String?,
    );

Map<String, dynamic> _$CustomerResultModelToJson(
        CustomerResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_a': instance.nameArabic,
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
      'route': instance.routeId,
      'region': instance.regionId,
      'rep': instance.repId,
      'tax_id': instance.taxId,
      'group': instance.groupId,
      'price_list': instance.priceList,
      'user': instance.user,
    };
